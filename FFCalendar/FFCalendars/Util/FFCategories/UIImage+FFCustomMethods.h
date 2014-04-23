//
//  UIImage+FFCustomMethods.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/18/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@interface UIImage (FFCustomMethods)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize;

@end
