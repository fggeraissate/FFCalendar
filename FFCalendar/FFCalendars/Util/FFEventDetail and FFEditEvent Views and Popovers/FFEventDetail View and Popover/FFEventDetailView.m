//
//  FFEventDetailView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/19/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFEventDetailView.h"

#import "FFImportantFilesForCalendar.h"

@interface FFEventDetailView ()
@property (nonatomic, strong) FFEvent *event;
@property (nonatomic, strong) UILabel *labelCustomerName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) UILabel *labelHours;
@end

@implementation FFEventDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Synthesize

@synthesize protocol;
@synthesize event;
@synthesize buttonEditPopover;
@synthesize labelCustomerName;
@synthesize labelDate;
@synthesize labelHours;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame event:(FFEvent *)_event
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        event = _event;
        
        [self.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
        [self.layer setBorderWidth:2.];
        
        [self addButtonEditPopoverWithViewSize:frame.size];
        [self addLabelCustomerNameWithViewSize:frame.size];
        [self addLabelDateWithViewSize:frame.size];
        [self addLabelHoursWithViewSize:frame.size];
    }
    return self;
}


- (id)initWithEvent:(FFEvent *)eventInit {
    
    CGSize size = CGSizeMake(320., 70.);
    
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    if (self) {
        
        event = eventInit;
        
        [self.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
        [self.layer setBorderWidth:2.];
        
        [self addButtonEditPopoverWithViewSize:size];
        [self addLabelCustomerNameWithViewSize:size];
        [self addLabelDateWithViewSize:size];
        [self addLabelHoursWithViewSize:size];
    }
    return self;
}

#pragma mark - Button Actions

- (IBAction)buttonEditPopoverAction:(id)sender {
    
    if ([protocol respondsToSelector:@selector(showEditViewWithEvent:)]) {
        [protocol showEditViewWithEvent:event];
    }
}

#pragma mark - Add Subviews

- (void)addButtonEditPopoverWithViewSize:(CGSize)sizeView {
    
    CGFloat width = 50;
    CGFloat height = BUTTON_HEIGHT;
    CGFloat gap = 30;
    
    buttonEditPopover = [[UIButton alloc] initWithFrame:CGRectMake(sizeView.width-width-gap, 22, width, height)];
    [buttonEditPopover setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonEditPopover setTitle:@"Edit" forState:UIControlStateNormal];
    [buttonEditPopover.titleLabel setFont:[UIFont boldSystemFontOfSize:buttonEditPopover.titleLabel.font.pointSize]];
    [buttonEditPopover addTarget:self action:@selector(buttonEditPopoverAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonEditPopover setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    
    [self addSubview:buttonEditPopover];
}

- (void)addLabelCustomerNameWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelCustomerName = [[UILabel alloc] initWithFrame:CGRectMake(gap, buttonEditPopover.frame.origin.y, sizeView.width-3*gap-buttonEditPopover.frame.size.width, buttonEditPopover.frame.size.height)];
    [labelCustomerName setText:event.stringCustomerName];
    [labelCustomerName setFont:[UIFont boldSystemFontOfSize:labelCustomerName.font.pointSize]];
    
    [self addSubview:labelCustomerName];
}

- (void)addLabelDateWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelDate = [[UILabel alloc] initWithFrame:CGRectMake(gap, labelCustomerName.frame.origin.y+labelCustomerName.frame.size.height, 180., labelCustomerName.frame.size.height)];
    [labelDate setText:[NSDate stringDayOfDate:event.dateDay]];
    [labelDate setTextColor:[UIColor grayColor]];
    [labelDate setFont:[UIFont systemFontOfSize:labelCustomerName.font.pointSize-3]];
    
    [self addSubview:labelDate];
}

- (void)addLabelHoursWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    CGFloat x = labelDate.frame.origin.x + labelDate.frame.size.width+gap;
    
    labelHours = [[UILabel alloc] initWithFrame:CGRectMake(x, labelDate.frame.origin.y, sizeView.width-x-gap, labelDate.frame.size.height)];
    [labelHours setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    [labelHours setText:[NSString stringWithFormat:@"%@ - %@", [NSDate stringTimeOfDate:event.dateTimeBegin], [NSDate stringTimeOfDate:event.dateTimeEnd]]];
    [labelHours setTextAlignment:NSTextAlignmentRight];
    [labelHours setTextColor:[UIColor grayColor]];
    [labelHours setFont:labelDate.font];
    
    [self addSubview:labelHours];
}

@end
