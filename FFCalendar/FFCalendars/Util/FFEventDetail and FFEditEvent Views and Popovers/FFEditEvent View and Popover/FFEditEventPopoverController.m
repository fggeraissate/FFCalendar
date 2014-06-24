//
//  FFEditEventPopoverController.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/15/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFEditEventPopoverController.h"

#import "FFEditEventView.h"
#import "FFImportantFilesForCalendar.h"

@interface FFEditEventPopoverController () <FFEditEventViewProtocol>
@property (nonatomic, strong) UIViewController *popoverContent;
@property (nonatomic, strong) FFEvent *event;
@end

@implementation FFEditEventPopoverController

#pragma mark - Synthesize

@synthesize protocol;
@synthesize event;
@synthesize popoverContent;

#pragma mark - Lifecycle

- (id)initWithEvent:(FFEvent *)eventInit {
    
    if (!eventInit) {
        NSDateComponents *comp = [NSDate componentsOfCurrentDate];
        eventInit = [FFEvent new];
        eventInit.stringCustomerName = @"";
        eventInit.dateDay = [NSDate date];
        eventInit.dateTimeBegin = [NSDate dateWithHour:comp.hour min:comp.minute];
        eventInit.dateTimeEnd = [NSDate dateWithHour:comp.hour min:comp.minute+15];
    }
    
    event = eventInit;
    
    CGSize size = CGSizeMake(300., 700.);
    FFEditEventView *viewEditar = [[FFEditEventView alloc] initWithFrame:CGRectMake(0., 0., size.width, size.height) event:eventInit];
    [viewEditar setProtocol:self];
    
    popoverContent = [UIViewController new];
    popoverContent.view = viewEditar;
    popoverContent.preferredContentSize = size;
    
    self = [super initWithContentViewController:popoverContent];
    
    return self;
}

#pragma mark - FFEditEventView Protocol

- (void)saveEvent:(FFEvent *)_event {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(saveEditedEvent:)]) {
        [protocol saveEditedEvent:_event];
    }
    
    [self removeThisView:nil];
}

- (void)deleteEvent:(FFEvent *)_event {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(deleteEvent)]) {
        [protocol deleteEvent];
    }
    
    [self removeThisView:nil];
}

- (void)removeThisView:(UIView *)view {
    
    [self dismissPopoverAnimated:YES];
}

@end
