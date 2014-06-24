//
//  FFRedAndWhiteButton.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/23/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFRedAndWhiteButton.h"

#import "FFImportantFilesForCalendar.h"

@implementation FFRedAndWhiteButton

- (id)initWithFrame:(CGRect)frame
{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        // Initialization code
        
        [self setFrame:frame];
        
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
        
        [self.layer setBorderColor:[UIColor redColor].CGColor];
        [self.layer setBorderWidth:1.];
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

- (void)setSelected:(BOOL)_selected {

    self.selected = _selected;
    
    if(_selected) {
        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
    } else {
        [self.layer setBorderColor:[UIColor redColor].CGColor];
    }
}

@end
