//
//  UILabel+FFCustomMethods.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/18/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "UILabel+FFCustomMethods.h"

@implementation UILabel (FFCustomMethods)

- (void)widthToFit {
    
    self.numberOfLines = 0;
    
    CGRect textRect = [self.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    
    CGRect labelRect = self.frame;
    labelRect.size.width = textRect.size.width;
    
    [self setFrame:labelRect];
}

- (CGFloat)widthThatWouldFit {
    
    self.numberOfLines = 0;
    
    CGRect textRect = [self.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    
    return textRect.size.width;
}

@end
