//
//  FFButtonWithHourPopover.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/16/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFButtonWithHourPopover.h"

#import "FFHourPopoverController.h"
#import "FFImportantFilesForCalendar.h"

@interface FFButtonWithHourPopover () <FFHourPopoverControllerProtocol>
@property (nonatomic, strong) FFHourPopoverController *popoverControllerDate;
@end

@implementation FFButtonWithHourPopover

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
    
    if (self) {
        dateOfButton = date;
        [self setTitle:[NSDate stringTimeOfDate:date] forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark - Button Action

- (IBAction)buttonAction:(id)sender {
    
    popoverControllerDate = [[FFHourPopoverController alloc] initWithDate:dateOfButton];
    [popoverControllerDate setProtocol:self];
    
    [popoverControllerDate presentPopoverFromRect:self.frame
                                           inView:[super superview]
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
}

#pragma mark - FFDatePopoverController Protocol

- (void)valueChanged:(NSDate *)newDate {
    
    dateOfButton = newDate;
    
    [self setTitle:[NSDate stringTimeOfDate:dateOfButton] forState:UIControlStateNormal];
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
