//
//  FFMonthCollectionViewForYearCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/6/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFMonthCollectionViewForYearCell.h"

#import "FFHeaderMonthForYearCell.h"
#import "FFMonthCellForYearCell.h"
#import "FFEvent.h"
#import "FFImportantFilesForCalendar.h"

@interface FFMonthCollectionViewForYearCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic) CGSize sizeOfCells;
@property (nonatomic, strong) NSMutableArray *arrayDates;
@property (nonatomic, strong) NSDate *dateFirstDayOfMonth;
@end

@implementation FFMonthCollectionViewForYearCell

#pragma mark - Synthesize

@synthesize protocol;
@synthesize sizeOfCells;
@synthesize arrayDates;
@synthesize dateFirstDayOfMonth;
@synthesize date;

#pragma mark - Lyfecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    self = [super initWithFrame:frame collectionViewLayout:[UICollectionViewFlowLayout new]];
    
    if (self) {
        // Initialization code
        
        [self setUserInteractionEnabled:YES];
        
        [self setDataSource:self];
        [self setDelegate:self];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self registerClass:[FFMonthCellForYearCell class] forCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL];
        [self registerClass:[FFHeaderMonthForYearCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:REUSE_IDENTIFIER_MONTH_HEADER];
    }
    return self;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id obj = [arrayDates objectAtIndex:indexPath.row];
    
    if (obj != [NSNull null] && protocol != nil && [protocol respondsToSelector:@selector(showMonthCalendar)]) {
        [[FFDateManager sharedManager] setCurrentDate:(NSDate *)obj];
        [protocol showMonthCalendar];
    }
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    arrayDates = [NSMutableArray new];
    
    NSDateComponents *compDateManeger = [NSDate componentsOfDate:date];
    dateFirstDayOfMonth = [NSDate dateWithYear:compDateManeger.year month:compDateManeger.month day:1];
    NSDateComponents *componentsFirstDayOfMonth = [NSDate componentsOfDate:dateFirstDayOfMonth];
    
    long lastDayMonth = [dateFirstDayOfMonth numberOfDaysInMonthCount];
    long numOfCellsInCollection = [dateFirstDayOfMonth numberOfWeekInMonthCount]*7;
    
    for (long i=1-(componentsFirstDayOfMonth.weekday-1),j=numOfCellsInCollection-(componentsFirstDayOfMonth.weekday-1); i<=j; i++) {
        
        [arrayDates addObject:(i>=1 && i<=lastDayMonth)?[NSDate dateWithYear:compDateManeger.year month:compDateManeger.month day:i]:[NSNull null]];
    }
    
    sizeOfCells =  CGSizeMake((self.frame.size.width)/7, (self.frame.size.height-50.)/6);
    
    return [arrayDates count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FFMonthCellForYearCell *cell = (FFMonthCellForYearCell *)[collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL forIndexPath:indexPath];
    [cell initLayout];
    
    id obj = [arrayDates objectAtIndex:indexPath.row];
    if (obj != [NSNull null]) {
        
        NSDate *dateCell = (NSDate *)obj;
        NSDateComponents *components = [NSDate componentsOfDate:dateCell];

        [cell.labelDay setText:[NSString stringWithFormat:@"%li", (long)[components day]]];
        
        if ([NSDate isTheSameDateTheCompA:components compB:[NSDate componentsOfCurrentDate]]) {
            [cell markAsCurrentDay];
        }
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        FFHeaderMonthForYearCell *headerView = (FFHeaderMonthForYearCell *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:REUSE_IDENTIFIER_MONTH_HEADER forIndexPath:indexPath];
        [headerView setDate:date];
        [headerView addWeekLabelsWithSizeOfCells:sizeOfCells];
        reusableview = headerView;
    }
    
    return  reusableview;
}

#pragma mark - UICollectionView Delegate FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return sizeOfCells;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGSize headerViewSize = CGSizeMake(self.frame.size.width, 50.);
    
    return headerViewSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
