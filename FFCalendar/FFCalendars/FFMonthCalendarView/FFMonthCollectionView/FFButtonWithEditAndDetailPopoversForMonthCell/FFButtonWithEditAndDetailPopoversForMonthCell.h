//
//  FFButtonWithEditAndDetailPopoversForMonthCell.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/15/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

#import "FFEvent.h"

@protocol FFButtonWithEditAndDetailPopoversForMonthCellProtocol <NSObject>
@required
- (void)saveEditedEvent:(FFEvent *)eventNew ofButton:(UIButton *)button;
- (void)deleteEventOfButton:(UIButton *)button;
@end

@interface FFButtonWithEditAndDetailPopoversForMonthCell : UIButton

@property (nonatomic, strong) id<FFButtonWithEditAndDetailPopoversForMonthCellProtocol> protocol;
@property (nonatomic, strong) FFEvent *event;

@end
