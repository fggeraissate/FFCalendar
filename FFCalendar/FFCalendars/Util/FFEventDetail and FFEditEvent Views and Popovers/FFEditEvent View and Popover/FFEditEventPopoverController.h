//
//  FFEditEventPopoverController.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/15/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

#import "FFEvent.h"

@protocol FFEditEventPopoverControllerProtocol <NSObject>
@required
- (void)saveEditedEvent:(FFEvent *)eventNew;
- (void)deleteEvent;
@end

@interface FFEditEventPopoverController : UIPopoverController

@property (nonatomic, strong) id<FFEditEventPopoverControllerProtocol> protocol;

- (id)initWithEvent:(FFEvent *)eventInit;

@end
