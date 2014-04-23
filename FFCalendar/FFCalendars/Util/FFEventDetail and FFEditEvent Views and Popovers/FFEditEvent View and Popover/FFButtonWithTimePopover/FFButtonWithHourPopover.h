//
//  FFButtonWithHourPopover.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/16/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@interface FFButtonWithHourPopover : UIButton

@property (nonatomic, strong) NSDate *dateOfButton;

- (id)initWithFrame:(CGRect)frame date:(NSDate *)date;

@end
