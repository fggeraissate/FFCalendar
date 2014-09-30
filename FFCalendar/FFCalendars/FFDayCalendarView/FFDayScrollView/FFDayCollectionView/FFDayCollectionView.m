//
//  FFDayCollectionView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/23/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFDayCollectionView.h"

#import "FFDayCollectionViewFlowLayout.h"
#import "FFImportantFilesForCalendar.h"

@interface FFDayCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic) CGFloat lastContentOffset;
@property (nonatomic) BOOL boolGoPrevious;
@property (nonatomic) BOOL boolGoNext;
@end

@implementation FFDayCollectionView

@synthesize protocol;
@synthesize dictEvents;
@synthesize lastContentOffset;
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

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    self = [super initWithFrame:frame collectionViewLayout:[FFDayCollectionViewFlowLayout new]];
    
    if (self) {
        // Initialization code
        
        [self setDataSource:self];
        [self setDelegate:self];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self registerClass:[FFDayCell class] forCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL];
        
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
    
//    int intDay = [[[DateManager sharedManager] currentDate] numberOfDaysInMonthCount];
    long intDay = 7*([[[FFDateManager sharedManager] currentDate] numberOfWeekInMonthCount]+2);
    
    return intDay;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDateComponents *comp = [NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]];
    
    FFDayCell *cell = (FFDayCell *)[collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL forIndexPath:indexPath];
    [cell setProtocol:(id)self.superview.superview];
    [cell setDate:[NSDate dateWithYear:comp.year month:comp.month day:1+indexPath.row-7]];
    [cell showEvents:[dictEvents objectForKey:cell.date]];
    
    return cell;
}

#pragma mark - UICollectionView Delegate FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((self.frame.size.width-1), self.frame.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!boolGoPrevious && scrollView.contentOffset.x < 0) {
        boolGoPrevious = YES;
    }
    
    if (!boolGoNext && scrollView.contentOffset.x > 7*([[[FFDateManager sharedManager] currentDate] numberOfWeekInMonthCount]+2-1)*scrollView.frame.size.width) {
        boolGoNext = YES;
        
        NSLog(@"%f", scrollView.contentOffset.x);
         NSLog(@"%f", 7*([[[FFDateManager sharedManager] currentDate] numberOfWeekInMonthCount]+2-1)*scrollView.frame.size.width);
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
        comp.day -= 1;
    } else if (lastContentOffset < scrollView.contentOffset.x || boolGoNext) {
        scrollDirection = ScrollDirectionLeft;
        comp.day += 1;
    } else {
        scrollDirection = ScrollDirectionNone;
    }
    
    [[FFDateManager sharedManager] setCurrentDate:[NSDate dateWithYear:comp.year month:comp.month day:comp.day]];
    
    if (protocol != nil && [protocol respondsToSelector:@selector(updateHeader)]) {
        [protocol updateHeader];
    }
    
    boolGoPrevious = NO;
    boolGoNext = NO;
}

@end
