//
//  FFButtonAddEventWithPopover.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/25/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFButtonAddEventWithPopover.h"

#import "FFAddEventPopoverController.h"

@interface FFButtonAddEventWithPopover () <FFAddEventPopoverControllerProtocol>
@property (nonatomic, strong) FFAddEventPopoverController *popoverControllerAdd;
@end

@implementation FFButtonAddEventWithPopover

#pragma mark - Synthesize

@synthesize popoverControllerAdd;
@synthesize protocol;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:30.]];
        [self setTitle:@"+" forState:UIControlStateNormal];
        
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - Button Action

- (IBAction)buttonAction:(id)sender {
    
    popoverControllerAdd = [[FFAddEventPopoverController alloc] initPopover];
    [popoverControllerAdd setProtocol:self];
        
    [popoverControllerAdd presentPopoverFromRect:self.frame inView:[super superview] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

#pragma mark - FFAddEventPopoverController Protocol

- (void)addNewEvent:(FFEvent *)eventNew {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(addNewEvent:)]) {
        [protocol addNewEvent:eventNew];
    }
    
}

@end
