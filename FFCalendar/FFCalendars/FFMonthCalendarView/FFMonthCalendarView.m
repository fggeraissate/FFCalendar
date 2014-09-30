//
//  FFMonthCalendarView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/18/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFMonthCalendarView.h"

#import "FFMonthCollectionView.h"
#import "FFMonthHeaderView.h"
#import "FFImportantFilesForCalendar.h"

@interface FFMonthCalendarView () <FFMonthCollectionViewProtocol>
@property (nonatomic, strong) FFMonthCollectionView *collectionViewMonth;
@end

@implementation FFMonthCalendarView

#pragma mark - Synthesize

@synthesize dictEvents;
@synthesize collectionViewMonth;
@synthesize protocol;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        FFMonthHeaderView *view = [[FFMonthHeaderView alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, HEADER_HEIGHT_MONTH)];
        [self addSubview:view];
        
        collectionViewMonth = [[FFMonthCollectionView alloc] initWithFrame:CGRectMake(0., HEADER_HEIGHT_MONTH, self.frame.size.width, self.frame.size.height-HEADER_HEIGHT_MONTH) collectionViewLayout:[UICollectionViewLayout new]];
        [collectionViewMonth setProtocol:self];
        [self addSubview:collectionViewMonth];
        
        [self setAutoresizingMask: AR_WIDTH_HEIGHT];
        [collectionViewMonth setAutoresizingMask:AR_WIDTH_HEIGHT | AR_TOP_BOTTOM];
        [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
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
    
    [collectionViewMonth setDictEvents:_dictEvents];
    [collectionViewMonth reloadData];
}

#pragma mark - Invalidate Layout

- (void)invalidateLayout {
    
    [collectionViewMonth.collectionViewLayout invalidateLayout];
    [collectionViewMonth reloadData];
}

#pragma mark - FFDateManager Notification

- (void)dateChanged:(NSNotification *)not {
    
    [collectionViewMonth setContentOffset:CGPointMake(0., collectionViewMonth.frame.size.height) animated:NO];
    [collectionViewMonth reloadData];
}

#pragma mark - FFMonthCollectionView Protocol

- (void)setNewDictionary:(NSDictionary *)dict {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(setNewDictionary:)]) {
        [protocol setNewDictionary:dict];
    }
}


@end
