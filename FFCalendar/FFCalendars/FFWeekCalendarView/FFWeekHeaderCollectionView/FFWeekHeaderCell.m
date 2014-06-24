//
//  FFWeekHeaderCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/26/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFWeekHeaderCell.h"
#import "FFImportantFilesForCalendar.h"

@implementation FFWeekHeaderCell

@synthesize label;
@synthesize imageView;
@synthesize date;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, self.frame.size.height)];
        [imageView setAutoresizingMask:AR_LEFT_RIGHT];
        [imageView setContentMode:UIViewContentModeCenter];
        [self addSubview:imageView];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, self.frame.size.height)];
        [label setAutoresizingMask:AR_LEFT_RIGHT];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label];
    }
    return self;
}

- (void)cleanCell {
    
    [imageView setImage:nil];
    [label setText:@""];
    [label setTextColor:[UIColor blackColor]];
    date = nil;
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
