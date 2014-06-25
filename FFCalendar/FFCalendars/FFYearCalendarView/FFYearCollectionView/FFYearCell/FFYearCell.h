//
//  FFYearCell.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/6/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@protocol FFYearCellProtocol <NSObject>
@required
- (void)showMonthCalendar;
@end

@interface FFYearCell : UICollectionViewCell

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) id<FFYearCellProtocol> protocol;

- (void)initLayout;

@end
