//
//  FFWeekCell.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/22/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>
#import "FFEvent.h"

@protocol FFWeekCellProtocol <NSObject>
@required
- (void)saveEditedEvent:(FFEvent *)eventNew ofCell:(UICollectionViewCell *)cell atIndex:(NSInteger)intIndex;
- (void)deleteEventOfCell:(UICollectionViewCell *)cell atIndex:(NSInteger)intIndex;
@end

@interface FFWeekCell : UICollectionViewCell

@property (nonatomic, strong) id<FFWeekCellProtocol>protocol;
@property (nonatomic, strong) NSDate *date;

- (void)clean;

- (void)showEvents:(NSArray *)array;

@end
