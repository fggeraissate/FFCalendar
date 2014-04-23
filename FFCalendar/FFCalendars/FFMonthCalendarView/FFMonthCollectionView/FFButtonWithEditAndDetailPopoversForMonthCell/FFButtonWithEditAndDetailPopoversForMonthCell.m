//
//  FFButtonWithEditAndDetailPopoversForMonthCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/15/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFButtonWithEditAndDetailPopoversForMonthCell.h"

#import "FFEventDetailPopoverController.h"
#import "FFEditEventPopoverController.h"

@interface FFButtonWithEditAndDetailPopoversForMonthCell () <FFEventDetailPopoverControllerProtocol, FFEditEventPopoverControllerProtocol>
@property (nonatomic, strong) FFEventDetailPopoverController *popoverControllerDetails;
@property (nonatomic, strong) FFEditEventPopoverController *popoverControllerEditar;
@end

@implementation FFButtonWithEditAndDetailPopoversForMonthCell

#pragma mark - Synthesize

@synthesize protocol;
@synthesize event;
@synthesize popoverControllerDetails;
@synthesize popoverControllerEditar;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:12.]];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        
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

- (void)setEvent:(FFEvent *)_event {
    
    event = _event;
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark - Button Action

- (IBAction)buttonAction:(id)sender {
    
    if (event) {
        
        popoverControllerDetails = [[FFEventDetailPopoverController alloc] initWithEvent:event];
        [popoverControllerDetails setProtocol:self];
        
        [popoverControllerDetails presentPopoverFromRect:self.frame
                                           inView:[super superview]
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
    }
}

#pragma mark - FFEventDetailPopoverController Protocol

- (void)showPopoverEditWithEvent:(FFEvent *)_event {
    
    popoverControllerEditar = [[FFEditEventPopoverController alloc] initWithEvent:_event];
    [popoverControllerEditar setProtocol:self];
    
    [popoverControllerEditar presentPopoverFromRect:self.frame
                                              inView:[super superview]
                            permittedArrowDirections:UIPopoverArrowDirectionAny
                                            animated:YES];
}

#pragma mark - FFEditEventPopoverController Protocol

- (void)saveEditedEvent:(FFEvent *)eventNew {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(saveEditedEvent:ofButton:)]) {
        [protocol saveEditedEvent:eventNew ofButton:self];
    }
}

- (void)deleteEvent {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(deleteEventOfButton:)]) {
        [protocol deleteEventOfButton:self];
    }
}

@end
