//
//  FFHourAndMinLabel.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/18/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@interface FFHourAndMinLabel : UILabel

@property (nonatomic, strong) NSDate *dateHourAndMin;

- (id)initWithFrame:(CGRect)frame date:(NSDate *)date;
- (void)showText;

@end
