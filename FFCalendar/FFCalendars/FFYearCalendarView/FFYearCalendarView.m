//
//  FFYearCalendarView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/18/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFYearCalendarView.h"

#import "FFYearCollectionView.h"
#import "FFYearCollectionViewFlowLayout.h"
#import "FFImportantFilesForCalendar.h"

@interface FFYearCalendarView () <FFYearCollectionViewProtocol>
@property (nonatomic, strong) FFYearCollectionView *collectionViewYear;
@end

@implementation FFYearCalendarView

#pragma mark - Synthesize

@synthesize collectionViewYear;
@synthesize protocol;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        collectionViewYear = [[FFYearCollectionView alloc] initWithFrame:CGRectMake(SPACE_COLLECTIONVIEW_CELL_YEAR, SPACE_COLLECTIONVIEW_CELL_YEAR, self.frame.size.width-2*SPACE_COLLECTIONVIEW_CELL_YEAR, self.frame.size.height-2*SPACE_COLLECTIONVIEW_CELL_YEAR) collectionViewLayout:[FFYearCollectionViewFlowLayout new]];
        [collectionViewYear setProtocol:self];
        [self addSubview:collectionViewYear];
        
        [self setAutoresizingMask: AR_WIDTH_HEIGHT];
        [collectionViewYear setAutoresizingMask:AR_WIDTH_HEIGHT | AR_TOP_BOTTOM];
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

#pragma mark - Invalidate Layout

- (void)invalidateLayout {
    [collectionViewYear.collectionViewLayout invalidateLayout];
}

#pragma mark - FFDateManager Notification

- (void)dateChanged:(NSNotification *)not {
    
    [collectionViewYear setContentOffset:CGPointMake(0., collectionViewYear.frame.size.height) animated:NO];
    [collectionViewYear reloadData];
}

#pragma mark - FFYearCollectionView Protocol

- (void)showMonthCalendar {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(showMonthCalendar)]) {
        [protocol showMonthCalendar];
    }
}

@end
