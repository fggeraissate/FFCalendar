//
//  FFMonthCollectionViewForYearCell.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/6/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@protocol FFMonthCollectionViewForYearCellProtocol <NSObject>
@required
- (void)showMonthCalendar;
@end

@interface FFMonthCollectionViewForYearCell : UICollectionView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) id<FFMonthCollectionViewForYearCellProtocol> protocol;

@end
