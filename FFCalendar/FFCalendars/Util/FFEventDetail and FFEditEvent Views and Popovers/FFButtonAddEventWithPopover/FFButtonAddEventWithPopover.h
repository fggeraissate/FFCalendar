//
//  FFButtonAddEventWithPopover.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/25/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

#import "FFEvent.h"

@protocol FFButtonAddEventWithPopoverProtocol <NSObject>
@required
- (void)addNewEvent:(FFEvent *)eventNew;
@end

@interface FFButtonAddEventWithPopover : UIButton

@property (nonatomic, strong) id<FFButtonAddEventWithPopoverProtocol> protocol;

@end
