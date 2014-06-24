//
//  FFDayHeaderCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/26/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFDayHeaderCell.h"

#import "FFImportantFilesForCalendar.h"

@implementation FFDayHeaderCell

@synthesize button;
@synthesize date;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        button = [[FFDayHeaderButton alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, self.frame.size.height)];
        [self addSubview:button];
        
        [self setAutoresizingMask:AR_LEFT_RIGHT | UIViewAutoresizingFlexibleWidth];
    }
    return self;
}

- (void)setDate:(NSDate *)_date {
    
    date = _date;
    [button setDate:_date];
}

@end
