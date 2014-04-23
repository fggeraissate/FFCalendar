//
//  FFHourPopoverController.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/16/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFHourPopoverController.h"

@interface FFHourPopoverController () <UIPickerViewDelegate>
@property (nonatomic, strong) UIViewController *popoverContent;
@property (nonatomic, strong) UIDatePicker *datePickerView;
@end

@implementation FFHourPopoverController

#pragma mark - Synthesize

@synthesize protocol;
@synthesize popoverContent;
@synthesize datePickerView;

#pragma mark - Lifecycle

- (id)initWithDate:(NSDate *)date {
    
    datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, datePickerView.frame.size.width, datePickerView.frame.size.height)];
    [datePickerView setDatePickerMode:UIDatePickerModeTime];
    [datePickerView addTarget:self action:@selector(valueOfPickerChanged:) forControlEvents:UIControlEventValueChanged];
    [datePickerView setDate:date];
    
    popoverContent = [UIViewController new];
    popoverContent.view = datePickerView;
    popoverContent.preferredContentSize = datePickerView.frame.size;
    
    self = [super initWithContentViewController:popoverContent];
    
    return self;
}

- (IBAction)valueOfPickerChanged:(id)sender {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(valueChanged:)]) {
        [protocol valueChanged:datePickerView.date];
    }
}

@end
