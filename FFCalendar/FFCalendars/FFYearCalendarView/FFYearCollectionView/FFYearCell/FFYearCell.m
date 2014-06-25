//
//  FFYearCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/6/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFYearCell.h"

#import "FFMonthCollectionViewForYearCell.h"

@interface FFYearCell () <FFMonthCollectionViewForYearCellProtocol>
@property (nonatomic, strong) FFMonthCollectionViewForYearCell *collectionView;
@end

@implementation FFYearCell

@synthesize protocol;
@synthesize date;
@synthesize collectionView;

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

- (void)initLayout {
    
    if (!collectionView) {
        collectionView = [[FFMonthCollectionViewForYearCell alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, self.frame.size.height) collectionViewLayout:[UICollectionViewLayout new]];
        [collectionView setProtocol:self];
        [self addSubview:collectionView];
    }
}

- (void)setDate:(NSDate *)_date {
    
    date = _date;
    
    [collectionView setDate:date];
    [collectionView reloadData];
}

#pragma mark - FFMonthCollectionViewForYearCell Protocol

- (void)showMonthCalendar {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(showMonthCalendar)]) {
        [protocol showMonthCalendar];
    }
}

@end
