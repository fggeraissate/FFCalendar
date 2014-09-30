//
//  FFWeekHeaderCollectionView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/26/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFWeekHeaderCollectionView.h"

#import "FFWeekHeaderCell.h"
#import "FFWeekCollectionViewFlowLayout.h"
#import "FFImportantFilesForCalendar.h"

@interface FFWeekHeaderCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic) CGFloat lastContentOffset;
@property (nonatomic) BOOL boolGoPrevious;
@property (nonatomic) BOOL boolGoNext;
@end

@implementation FFWeekHeaderCollectionView

@synthesize lastContentOffset;
@synthesize protocol;
@synthesize boolGoPrevious;
@synthesize boolGoNext;

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
        
        [self registerClass:[FFWeekHeaderCell class] forCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL];
        
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
    
    FFWeekHeaderCell *cell = (FFWeekHeaderCell *)[collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL forIndexPath:indexPath];
    [cell cleanCell];
    cell.date = dateOfLabel;
    
    [cell.label setText:[NSString stringWithFormat:@"%@, %li", [arrayWeekAbrev objectAtIndex:compDateOfLabel.weekday-1], (long)compDateOfLabel.day]];
    
    if (compDateOfLabel.weekday == 1 || compDateOfLabel.weekday == 7) {
        [cell.label setTextColor:[UIColor grayColor]];
    }
    
    if ([NSDate isTheSameDateTheCompA:compDateOfLabel compB:[NSDate componentsOfCurrentDate]]) {
        [cell.imageView setImage:[UIImage imageNamed:@"redCircle"]];
        [cell.label setTextColor:[UIColor whiteColor]];
    }

    
    return cell;
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
    
    if (protocol != nil && [protocol respondsToSelector:@selector(headerDidScroll)]) {
        [protocol headerDidScroll];
    }
    
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


@end
