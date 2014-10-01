//
//  FFDayHeaderCollectionView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/26/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFDayHeaderCollectionView.h"

#import "FFDayHeaderCell.h"
#import "FFWeekCollectionViewFlowLayout.h"
#import "FFImportantFilesForCalendar.h"

#define QNT_BY_PAGING 7

@interface FFDayHeaderCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic) CGFloat lastContentOffset;
@property (nonatomic) BOOL boolGoPrevious;
@property (nonatomic) BOOL boolGoNext;
@end

@implementation FFDayHeaderCollectionView

#pragma mark - Synthesize

@synthesize lastContentOffset;
@synthesize protocol;
@synthesize boolGoPrevious;
@synthesize boolGoNext;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    self = [super initWithFrame:frame collectionViewLayout:[FFWeekCollectionViewFlowLayout new]];
    
    if (self) {
        // Initialization code
        
        [self setDataSource:self];
        [self setDelegate:self];
        
        [self setBackgroundColor:[UIColor lighterGrayCustom]];
        
        [self registerClass:[FFDayHeaderCell class] forCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL];
        
        [self setScrollEnabled:YES];
        [self setPagingEnabled:YES];
        
        boolGoNext = NO;
        boolGoPrevious = NO;
        
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

#pragma mark - UIScrollView Methods

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    
    return YES;
}

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
    
    NSDate *dateOfLabel = [NSDate dateWithYear:comp.year month:comp.month day:1+indexPath.row-(componentsFirstDayOfMonth.weekday-1)-7];
    NSDateComponents *compDateOfLabel = [NSDate componentsOfDate:dateOfLabel];
    
    FFDayHeaderCell *cell = (FFDayHeaderCell *)[collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL forIndexPath:indexPath];
    [cell.button addTarget:self action:@selector(dayButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.date = dateOfLabel;
    [cell.button setTitle:[NSString stringWithFormat:@"%@, %li", [arrayWeekAbrev objectAtIndex:compDateOfLabel.weekday-1], (long)compDateOfLabel.day] forState:UIControlStateNormal];
    [cell.button setSelected:([NSDate isTheSameDateTheCompA:compDateOfLabel compB:[[FFDateManager sharedManager] currentDate].componentsOfDate])];
    cell.button.tag = indexPath.row;
    
    if (cell.isSelected && protocol && [protocol respondsToSelector:@selector(daySelected:)]) {
        [protocol daySelected:cell.date];
    }
    
    return cell;
}

#pragma mark - Button Action

- (void)dayButton:(FFDayHeaderButton *)button {
    
    if (protocol && [protocol respondsToSelector:@selector(daySelected:)]) {
        [protocol daySelected:button.date];
    }
    
    [[FFDateManager sharedManager] setCurrentDate:button.date];
    
    [self reloadData];
}

#pragma mark - Scroll to Date

- (void)scrollToDate:(NSDate *)date {
    
    NSDateComponents *comp = [NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]];
    NSDate *dateFirstDayOfMonth = [NSDate dateWithYear:comp.year month:comp.month day:1];
    NSDateComponents *componentsFirstDayOfMonth = [NSDate componentsOfDate:dateFirstDayOfMonth];
    
    int x = 0;
    for (long i=1-(componentsFirstDayOfMonth.weekday-1),j=7*[[[FFDateManager sharedManager] currentDate] numberOfWeekInMonthCount]-(componentsFirstDayOfMonth.weekday-1); i<=j; i++) {
        NSDate *datea = [NSDate dateWithYear:comp.year month:comp.month day:i];
        
        if ([NSDate isTheSameDateTheCompA:date.componentsOfDate compB:datea.componentsOfDate]) {
            break;
        }
        x++;
    }
    
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:x+(7-comp.weekday)+7 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
}

#pragma mark - UICollectionView Delegate FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((self.frame.size.width)/7, self.frame.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!boolGoPrevious && scrollView.contentOffset.x < 0) {
        boolGoPrevious = YES;
    }
    
    if (!boolGoNext && scrollView.contentOffset.x >  ([[[FFDateManager sharedManager] currentDate] numberOfWeekInMonthCount]-1)*scrollView.frame.size.width) {
        boolGoNext = YES;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    lastContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSDateComponents *comp = [[[FFDateManager sharedManager] currentDate] componentsOfDate];
    
    ScrollDirection scrollDirection;
    if (lastContentOffset > scrollView.contentOffset.x || boolGoPrevious) {
        scrollDirection = ScrollDirectionRight;
        comp.day -=QNT_BY_PAGING;
    } else if (lastContentOffset < scrollView.contentOffset.x || boolGoNext) {
        scrollDirection = ScrollDirectionLeft;
        comp.day +=QNT_BY_PAGING;
    } else {
        scrollDirection = ScrollDirectionNone;
    }
    
    if (protocol && [protocol respondsToSelector:@selector(daySelected:)]) {
        [protocol daySelected:[[FFDateManager sharedManager] currentDate]];
    }
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    [[FFDateManager sharedManager] setCurrentDate:date];
    
    boolGoPrevious = NO;
    boolGoNext = NO;
}


@end
