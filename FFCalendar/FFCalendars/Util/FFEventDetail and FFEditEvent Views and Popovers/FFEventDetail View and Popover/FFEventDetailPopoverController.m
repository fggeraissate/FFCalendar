//
//  FFEventDetailPopoverController.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/15/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFEventDetailPopoverController.h"

#import "FFEventDetailView.h"

@interface FFEventDetailPopoverController () <FFEventDetailViewProtocol>
@property (nonatomic, strong) UIViewController *popoverContent;
@property (nonatomic, strong) FFEvent *event;
@end

@implementation FFEventDetailPopoverController

#pragma mark - Synthesize

@synthesize protocol;
@synthesize popoverContent;
@synthesize event;

#pragma mark - Lifecycle

- (id)initWithEvent:(FFEvent *)eventInit {
    
    event = eventInit;
    
    CGSize size = CGSizeMake(360, 130.);
    FFEventDetailView *viewDetails = [[FFEventDetailView alloc] initWithFrame:CGRectMake(0., 0., size.width, size.height) event:eventInit];
    [viewDetails setProtocol:self];
    
    popoverContent = [UIViewController new];
    popoverContent.view = viewDetails;
    popoverContent.preferredContentSize = viewDetails.frame.size;
    
    self = [super initWithContentViewController:popoverContent];
    
    return self;
}

#pragma mark - Button Actions

- (void)showEditViewWithEvent:(FFEvent *)_event {
    
    [self dismissPopoverAnimated:YES];
    
    if ([protocol respondsToSelector:@selector(showPopoverEditWithEvent:)]) {
        [protocol showPopoverEditWithEvent:_event];
    }
}
@end
