//
//  FFHeaderMonthForYearCell.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/13/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@interface FFHeaderMonthForYearCell : UICollectionReusableView

@property (nonatomic, strong) NSDate *date;

- (void)addWeekLabelsWithSizeOfCells:(CGSize)sizeOfCells;

@end
