//
//  FFEventDetailPopoverController.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/15/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

#import "FFEvent.h"

@protocol FFEventDetailPopoverControllerProtocol <NSObject>
@required
- (void)showPopoverEditWithEvent:(FFEvent *)_event;
@end

@interface FFEventDetailPopoverController : UIPopoverController

@property (nonatomic, strong) id<FFEventDetailPopoverControllerProtocol> protocol;

- (id)initWithEvent:(FFEvent *)eventInit;

@end
