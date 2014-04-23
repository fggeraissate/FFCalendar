//
//  FFDayCell.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/23/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

#import "FFEvent.h"

@protocol FFDayCellProtocol <NSObject>
- (void)showViewDetailsWithEvent:(FFEvent *)_event cell:(UICollectionViewCell *)cell;

@end

@interface FFDayCell : UICollectionViewCell

@property (nonatomic, strong) id<FFDayCellProtocol> protocol;
@property (nonatomic, strong) NSDate *date;

- (void)showEvents:(NSArray *)array;

@end
