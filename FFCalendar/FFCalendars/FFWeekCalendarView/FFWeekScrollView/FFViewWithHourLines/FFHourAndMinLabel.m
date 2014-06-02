//
//  FFHourAndMinLabel.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/18/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFHourAndMinLabel.h"
#import "FFImportantFilesForCalendar.h"

@implementation FFHourAndMinLabel

#pragma mark - Synthesize

@synthesize dateHourAndMin;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame date:(NSDate *)date {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        dateHourAndMin = date;
    }
    return self;
}

- (void)showText {
    
    NSDateComponents *comp =  [NSDate componentsOfDate:dateHourAndMin];
    [self setText:[NSString stringWithFormat:@"%02d:%02d", comp.hour, comp.minute]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
