//
//  FFDayCalendarView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/23/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFDayCalendarView.h"

#import "FFDayHeaderCollectionView.h"
#import "FFDayScrollView.h"

#import "FFEventDetailView.h"
#import "FFEditEventView.h"

#import "FFImportantFilesForCalendar.h"

@interface FFDayCalendarView () <FFDayCellProtocol, FFEditEventViewProtocol, FFEventDetailViewProtocol, FFDayHeaderCollectionViewProtocol, FFDayCollectionViewProtocol, UIGestureRecognizerDelegate>
@property (nonatomic, strong) FFDayHeaderCollectionView *collectionViewHeaderDay;
@property (nonatomic, strong) FFDayScrollView *dayContainerScroll;
@property (nonatomic, strong) FFEventDetailView *viewDetail;
@property (nonatomic, strong) FFEditEventView *viewEdit;
@property (nonatomic) BOOL boolAnimate;
@end

@implementation FFDayCalendarView

#pragma mark - Synthesize

@synthesize dictEvents;
@synthesize collectionViewHeaderDay;
@synthesize dayContainerScroll;
@synthesize viewDetail;
@synthesize viewEdit;
@synthesize protocol;
@synthesize boolAnimate;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [gesture setDelegate:self];
        [self addGestureRecognizer:gesture];
        
        boolAnimate = NO;
        
        [self setAutoresizingMask: AR_WIDTH_HEIGHT];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setDictEvents:(NSMutableDictionary *)_dictEvents {
    
    dictEvents = _dictEvents;
    
    if (!dayContainerScroll) {
        collectionViewHeaderDay = [[FFDayHeaderCollectionView alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, HEADER_HEIGHT_SCROLL)];
        [collectionViewHeaderDay setProtocol:self];
        [collectionViewHeaderDay scrollToDate:[[FFDateManager sharedManager] currentDate]];
        [self addSubview:collectionViewHeaderDay];
        
        dayContainerScroll = [[FFDayScrollView alloc] initWithFrame:CGRectMake(0, HEADER_HEIGHT_SCROLL, self.frame.size.width/2., self.frame.size.height-HEADER_HEIGHT_SCROLL)];
        [self addSubview:dayContainerScroll];
    }
    [dayContainerScroll setDictEvents:dictEvents];
    [dayContainerScroll.collectionViewDay setProtocol:self];
}

#pragma mark - Invalidate Layout

- (void)invalidateLayout {
    [collectionViewHeaderDay.collectionViewLayout invalidateLayout];
    [dayContainerScroll.collectionViewDay.collectionViewLayout invalidateLayout];
    [self dateChanged:nil];
}

#pragma mark - FFDateManager Notification

- (void)dateChanged:(NSNotification *)not {
    
    [dayContainerScroll.collectionViewDay reloadData];
    [dayContainerScroll.collectionViewDay scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:[NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]].day-1+7 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:boolAnimate];
    
    boolAnimate = NO;
    
    [self updateHeader];
    
    if ([NSDate isTheSameDateTheCompA:[NSDate componentsOfCurrentDate] compB:[NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]]]) {
        [dayContainerScroll scrollRectToVisible:CGRectMake(0, dayContainerScroll.labelWithActualHour.frame.origin.y, dayContainerScroll.frame.size.width, dayContainerScroll.frame.size.height) animated:YES];
    }
}

#pragma mark - Tap Gesture

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    
    for (UIView *subviews in self.subviews) {
        if ([subviews isKindOfClass:[FFEventDetailView class]] || [subviews isKindOfClass:[FFEditEventView class]]) {
            [subviews removeFromSuperview];
        }
    }
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    CGPoint point = [gestureRecognizer locationInView:self];
    
    return !(viewEdit.superview != nil && CGRectContainsPoint(viewEdit.frame, point));
}

#pragma mark - FFDayCollectionView Protocol

- (void)updateHeader {
    
    [collectionViewHeaderDay reloadData];
    
    [collectionViewHeaderDay scrollToDate:[[FFDateManager sharedManager] currentDate]];
}

#pragma mark - FFDayHeaderCollectionView Protocol

- (void)daySelected:(NSDate *)date {
    
    boolAnimate = YES;
}

#pragma mark - FFDayCell Protocol

- (void)showViewDetailsWithEvent:(FFEvent *)_event cell:(UICollectionViewCell *)cell {
    
    [viewEdit removeFromSuperview];
    viewEdit = nil;
    [viewDetail removeFromSuperview];
    viewDetail = nil;
    
    viewDetail = [[FFEventDetailView alloc] initWithFrame:CGRectMake(self.frame.size.width/2., HEADER_HEIGHT_SCROLL, self.frame.size.width/2., self.frame.size.height-HEADER_HEIGHT_SCROLL) event:_event];
    [viewDetail setAutoresizingMask:AR_WIDTH_HEIGHT | UIViewAutoresizingFlexibleLeftMargin];
    [viewDetail setProtocol:self];
    [self addSubview:viewDetail];
}

#pragma mark - FFEventDetailView Protocol

- (void)showEditViewWithEvent:(FFEvent *)_event {
    
    viewEdit = [[FFEditEventView alloc] initWithFrame:CGRectMake(self.frame.size.width/2., HEADER_HEIGHT_SCROLL, self.frame.size.width/2., self.frame.size.height-HEADER_HEIGHT_SCROLL) event:_event];
    [viewEdit setAutoresizingMask:AR_WIDTH_HEIGHT | UIViewAutoresizingFlexibleLeftMargin];
    [viewEdit setProtocol:self];
    [self addSubview:viewEdit];
    
    [viewDetail removeFromSuperview];
    viewDetail = nil;
}

#pragma mark - FFEditEventView Protocol

- (void)saveEvent:(FFEvent *)_event {
    
    NSMutableArray *arrayEvents = [dictEvents objectForKey:_event.dateDay];
    
    if (!arrayEvents) {
        arrayEvents = [NSMutableArray new];
        [dictEvents setObject:arrayEvents forKey:_event.dateDay];
    }
    
    [arrayEvents addObject:_event];
}

- (void)deleteEvent:(FFEvent *)_event {
    
    NSMutableArray *arrayEvents = [dictEvents objectForKey:_event.dateDay];
    [arrayEvents removeObject:_event];
    if (arrayEvents.count == 0) {
        [dictEvents removeObjectForKey:_event.dateDay];
    }
    
    if (protocol != nil && [protocol respondsToSelector:@selector(setNewDictionary:)]) {
        [protocol setNewDictionary:dictEvents];
    } else {
        [dayContainerScroll.collectionViewDay reloadData];
    }
}

- (void)removeThisView:(UIView *)view {
    
    [view removeFromSuperview];
    view = nil;
}

@end
