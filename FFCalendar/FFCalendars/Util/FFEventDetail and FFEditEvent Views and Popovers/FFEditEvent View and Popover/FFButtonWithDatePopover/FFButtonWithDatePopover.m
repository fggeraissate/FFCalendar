//
//  FFButtonWithDatePopover.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/16/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFButtonWithDatePopover.h"

#import "FFDatePopoverController.h"
#import "FFImportantFilesForCalendar.h"

@interface FFButtonWithDatePopover () <FFDatePopoverControllerProtocol>
@property (nonatomic, strong) FFDatePopoverController *popoverControllerDate;
@end

@implementation FFButtonWithDatePopover

#pragma mark - Synthesize

@synthesize popoverControllerDate;
@synthesize dateOfButton;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame date:(NSDate *)date {
    
    self = [self initWithFrame:frame];
    
    NSDateComponents *compDate = date.componentsOfDate;
    
    if (self) {
        dateOfButton = [NSDate dateWithYear:compDate.year month:compDate.month day:compDate.day];
        [self setTitle:[NSDate stringDayOfDate:date] forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark - Button Action

- (IBAction)buttonAction:(id)sender {
    
    popoverControllerDate = [[FFDatePopoverController alloc] initWithDate:dateOfButton];
    [popoverControllerDate setProtocol:self];
        
    [popoverControllerDate presentPopoverFromRect:self.frame
                                                  inView:[super superview]
                                permittedArrowDirections:UIPopoverArrowDirectionAny
                                                animated:YES];
}

#pragma mark - FFDatePopoverController Protocol

- (void)valueChanged:(NSDate *)newDate {
    
    NSDateComponents *compNewDate = newDate.componentsOfDate;
    
    dateOfButton = [NSDate dateWithYear:compNewDate.year month:compNewDate.month day:compNewDate.day];
    
    [self setTitle:[NSDate stringDayOfDate:dateOfButton] forState:UIControlStateNormal];
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
