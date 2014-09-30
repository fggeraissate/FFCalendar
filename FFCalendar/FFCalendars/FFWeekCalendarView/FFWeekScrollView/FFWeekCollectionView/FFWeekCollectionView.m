//
//  FFWeekCollectionView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/21/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFWeekCollectionView.h"

#import "FFWeekCell.h"
#import "FFWeekCollectionViewFlowLayout.h"
#import "FFImportantFilesForCalendar.h"

@interface FFWeekCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FFWeekCellProtocol>
@property (nonatomic) CGFloat lastContentOffset;
@property (nonatomic) BOOL boolGoNext;
@property (nonatomic) BOOL boolGoPrevious;
@end

@implementation FFWeekCollectionView

@synthesize protocol;
@synthesize lastContentOffset;
@synthesize dictEvents;
@synthesize boolGoNext;
@synthesize boolGoPrevious;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    self = [super initWithFrame:frame collectionViewLayout:[FFWeekCollectionViewFlowLayout new]];
    
    if (self) {
        // Initialization code
        
        [self setDataSource:self];
        [self setDelegate:self];
        
        [self setBackgroundColor:[UIColor lighterGrayCustom]];
        
        [self registerClass:[FFWeekCell class] forCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL];
        
        [self setScrollEnabled:YES];
        [self setPagingEnabled:YES];
        
        boolGoPrevious = NO;
        boolGoNext = NO;
        
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
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

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    long intDay = 7*([[[FFDateManager sharedManager] currentDate] numberOfWeekInMonthCount]+2);
    
    return intDay;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDateComponents *comp = [NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]];
    NSDate *dateFirstDayOfMonth = [NSDate dateWithYear:comp.year month:comp.month day:1];
    NSDateComponents *componentsFirstDayOfMonth = [NSDate componentsOfDate:dateFirstDayOfMonth];

    FFWeekCell *cell = (FFWeekCell *)[collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL forIndexPath:indexPath];
    [cell clean];
    [cell setProtocol:self];
    [cell setDate:[NSDate dateWithYear:comp.year month:comp.month day:1+indexPath.row-(componentsFirstDayOfMonth.weekday-1)-7]];
    [cell showEvents:[dictEvents objectForKey:cell.date]];
    
    if ([NSDate isTheSameDateTheCompA:cell.date.componentsOfDate compB:[NSDate componentsOfCurrentDate]] && protocol != nil && [protocol respondsToSelector:@selector(showHourLine:)]) {
        [protocol showHourLine:YES];
    }

    return cell;
}

#pragma mark - UICollectionView Delegate FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((self.frame.size.width-7*SPACE_COLLECTIONVIEW_CELL)/7, self.frame.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return SPACE_COLLECTIONVIEW_CELL;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return SPACE_COLLECTIONVIEW_CELL;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(collectionViewDidScroll)]) {
        [protocol collectionViewDidScroll];
    }
    
    if (!boolGoPrevious && scrollView.contentOffset.x < 0) {
        boolGoPrevious = YES;
    }
    
    if (!boolGoNext && scrollView.contentOffset.x >  ([[[FFDateManager sharedManager] currentDate] numberOfWeekInMonthCount]-1)*scrollView.frame.size.width) {
        boolGoNext = YES;
    }
    
    if (protocol != nil && [protocol respondsToSelector:@selector(showHourLine:)]) {
        [protocol showHourLine:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    lastContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSDateComponents *comp = [NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]];
    
    ScrollDirection scrollDirection;
    if (lastContentOffset > scrollView.contentOffset.x || boolGoPrevious) {
        scrollDirection = ScrollDirectionRight;
        comp.day -= 7;
    } else if (lastContentOffset < scrollView.contentOffset.x || boolGoNext) {
        scrollDirection = ScrollDirectionLeft;
        comp.day += 7;
    } else {
        scrollDirection = ScrollDirectionNone;
    }
    
    [[FFDateManager sharedManager] setCurrentDate:[NSDate dateWithYear:comp.year month:comp.month day:comp.day]];
    
    boolGoPrevious = NO;
    boolGoNext = NO;
}

#pragma mark - FFWeekCell Protocol

- (void)saveEditedEvent:(FFEvent *)eventNew ofCell:(UICollectionViewCell *)cell atIndex:(NSInteger)intIndex {
    
    NSDate *dateNew = eventNew.dateDay;
        
    NSMutableArray *arrayNew = [dictEvents objectForKey:dateNew];
    if (!arrayNew) {
        arrayNew = [NSMutableArray new];
        [dictEvents setObject:arrayNew forKey:dateNew];
    }
    [arrayNew addObject:eventNew];
    
    if (protocol != nil && [protocol respondsToSelector:@selector(setNewDictionary:)]) {
        [protocol setNewDictionary:dictEvents];
    } else {
        [self reloadData];
    }
}

- (void)deleteEventOfCell:(UICollectionViewCell *)cell atIndex:(NSInteger)intIndex {
    
    FFWeekCell *cellWeek = (FFWeekCell *)cell;
    
    NSDate *date = cellWeek.date;
    NSMutableArray *array = [dictEvents objectForKey:date];
    [array removeObjectAtIndex:intIndex];
    if (array.count == 0) {
        [dictEvents removeObjectForKey:date];
    }
    
    if (protocol != nil && [protocol respondsToSelector:@selector(setNewDictionary:)]) {
        [protocol setNewDictionary:dictEvents];
    } else {
        [self reloadData];
    }
}

@end
