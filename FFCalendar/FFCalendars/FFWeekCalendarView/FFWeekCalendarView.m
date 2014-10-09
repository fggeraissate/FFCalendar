//
//  FFWeekCalendarView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/21/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFWeekCalendarView.h"

#import "FFWeekHeaderCollectionView.h"
#import "FFWeekScrollView.h"
#import "FFImportantFilesForCalendar.h"

@interface FFWeekCalendarView () <FFWeekCollectionViewProtocol, FFWeekHeaderCollectionViewProtocol>
@property (nonatomic, strong) FFWeekHeaderCollectionView *scrollViewHeaderWeek;
@property (nonatomic, strong) FFWeekScrollView *weekContainerScroll;
@end

@implementation FFWeekCalendarView

#pragma mark - Synthesize

@synthesize dictEvents;
@synthesize scrollViewHeaderWeek;
@synthesize weekContainerScroll;
@synthesize protocol;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
        [self setBackgroundColor:[UIColor whiteColor]];
        
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
    
    if (!scrollViewHeaderWeek) {
        UIView *viewLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80., HEADER_HEIGHT_SCROLL)];
        [viewLeft setBackgroundColor:[UIColor lighterGrayCustom]];
        [self addSubview:viewLeft];
        
        scrollViewHeaderWeek = [[FFWeekHeaderCollectionView alloc] initWithFrame:CGRectMake(viewLeft.frame.size.width, 0, self.frame.size.width-viewLeft.frame.size.width, HEADER_HEIGHT_SCROLL)];
        [scrollViewHeaderWeek setProtocol:self];
        [self scrollToPage:(int)[NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]].weekOfMonth+1];
        [self addSubview:scrollViewHeaderWeek];
        
        weekContainerScroll = [[FFWeekScrollView alloc] initWithFrame:CGRectMake(0, HEADER_HEIGHT_SCROLL, self.frame.size.width, self.frame.size.height-HEADER_HEIGHT_SCROLL)];
        [self addSubview:weekContainerScroll];
    }
    [weekContainerScroll setDictEvents:dictEvents];
    [weekContainerScroll.collectionViewWeek setProtocol:self];
}

- (void)scrollToPage:(int)_intPage {
    NSInteger intIndex = 7*_intPage-1;
    [scrollViewHeaderWeek scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:intIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
}

#pragma mark - Invalidate Layout

- (void)invalidateLayout {
    
    [scrollViewHeaderWeek.collectionViewLayout invalidateLayout];
    [weekContainerScroll.collectionViewWeek.collectionViewLayout invalidateLayout];
    [self dateChanged:nil];
}

#pragma mark - FFDateManager Notification

- (void)dateChanged:(NSNotification *)not {
    
    [scrollViewHeaderWeek reloadData];
    [self scrollToPage:(int)[NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]].weekOfMonth+1];
    
    [weekContainerScroll.collectionViewWeek reloadData];
}

#pragma mark - FFWeekCollectionView Protocol

- (void)collectionViewDidScroll {
    
    CGPoint offset = scrollViewHeaderWeek.contentOffset;
    offset.x = weekContainerScroll.collectionViewWeek.contentOffset.x;
    [scrollViewHeaderWeek setContentOffset:offset];
}

- (void)showHourLine:(BOOL)show {
    
    [weekContainerScroll showlabelsWithActualHourWithAlpha:show];
}

- (void)setNewDictionary:(NSDictionary *)dict {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(setNewDictionary:)]) {
        [protocol setNewDictionary:dictEvents];
    }
}

#pragma mark - FFWeekHeaderCollectionView Protocol

- (void)headerDidScroll {
    
    CGPoint offset = weekContainerScroll.collectionViewWeek.contentOffset;
    offset.x = scrollViewHeaderWeek.contentOffset.x;
    [weekContainerScroll.collectionViewWeek setContentOffset:offset];
}

@end
