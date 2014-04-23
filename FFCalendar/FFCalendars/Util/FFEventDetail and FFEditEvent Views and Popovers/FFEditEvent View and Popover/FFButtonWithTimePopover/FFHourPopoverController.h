//
//  FFHourPopoverController.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/16/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@protocol FFHourPopoverControllerProtocol <NSObject>
@required
- (void) valueChanged:(NSDate *)newDate;
@end

@interface FFHourPopoverController : UIPopoverController

@property (nonatomic, strong) id<FFHourPopoverControllerProtocol> protocol;

- (id)initWithDate:(NSDate *)date;


@end
