//
//  FFMonthCell.h
//  FFCalendar
//
//  Created by Felipe Rocha on 14/02/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

#import "FFEvent.h"

@protocol FFMonthCellProtocol <NSObject>
@required
- (void)saveEditedEvent:(FFEvent *)eventNew ofCell:(UICollectionViewCell *)cell atIndex:(NSInteger)intIndex;
- (void)deleteEventOfCell:(UICollectionViewCell *)cell atIndex:(NSInteger)intIndex;
@end

@interface FFMonthCell : UICollectionViewCell

@property (nonatomic, strong) id<FFMonthCellProtocol> protocol;
@property (nonatomic, strong) NSMutableArray *arrayEvents;

@property (strong, nonatomic) UILabel *labelDay;
@property (strong, nonatomic) UIImageView *imageViewCircle;

- (void)initLayout;
- (void)markAsWeekend;
- (void)markAsCurrentDay;

@end
