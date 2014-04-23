//
//  FFMonthCellForYearCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/10/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFMonthCellForYearCell.h"

@interface FFMonthCellForYearCell ()
@property (strong, nonatomic) UIImageView *imageViewCircle;
@end

@implementation FFMonthCellForYearCell

#pragma mark - Synthesize

@synthesize labelDay;
@synthesize imageViewCircle;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initLayout {
    
    if (!labelDay) {
        
        imageViewCircle = [[UIImageView alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, self.frame.size.height)];
        [imageViewCircle setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:imageViewCircle];
        
        labelDay = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, self.frame.size.height)];
        [labelDay setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:labelDay];
    }
    
    [labelDay setText:@""];
    [labelDay setTextColor:[UIColor blackColor]];
    [imageViewCircle setImage:nil];
}

- (void)markAsCurrentDay {
    
    [labelDay setTextColor:[UIColor whiteColor]];
    [imageViewCircle setImage:[UIImage imageNamed:@"redCircle"]];
}

@end
