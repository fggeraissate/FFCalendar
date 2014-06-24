//
//  FFAddEventPopoverController.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/25/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFAddEventPopoverController.h"

#import "FFGuestsTableView.h"
#import "FFSearchBarWithAutoComplete.h"
#import "FFButtonWithDatePopover.h"
#import "FFButtonWithHourPopover.h"
#import "FFImportantFilesForCalendar.h"
//#import "SVProgressHUD.h"

@interface FFAddEventPopoverController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIViewController *popoverContent;
@property (nonatomic, strong) FFEvent *event;
@property (nonatomic, strong) UIButton *buttonCancel;
@property (nonatomic, strong) UIButton *buttonDone;
@property (nonatomic, strong) UILabel *labelEventName;
@property (nonatomic, strong) FFSearchBarWithAutoComplete *searchBarCustom;
@property (nonatomic, strong) FFButtonWithDatePopover *buttonDate;
@property (nonatomic, strong) FFButtonWithHourPopover *buttonTimeBegin;
@property (nonatomic, strong) FFButtonWithHourPopover *buttonTimeEnd;
@property (nonatomic, strong) FFGuestsTableView *tableViewGuests;
@end

@implementation FFAddEventPopoverController

#pragma mark - Synthesize

@synthesize protocol;
@synthesize event;
@synthesize popoverContent;
@synthesize buttonDone;
@synthesize buttonCancel;
@synthesize labelEventName;
@synthesize searchBarCustom;
@synthesize buttonDate;
@synthesize buttonTimeBegin;
@synthesize buttonTimeEnd;
@synthesize tableViewGuests;

#pragma mark - Lifecycle

- (id)initPopover {
    
    NSDateComponents *comp = [NSDate componentsOfCurrentDate];
    event = [FFEvent new];
    event.stringCustomerName = @"";
    event.dateDay = [NSDate date];
    event.dateTimeBegin = [NSDate dateWithHour:comp.hour min:comp.minute];
    event.dateTimeEnd = [NSDate dateWithHour:comp.hour min:comp.minute+15.];
    event.arrayWithGuests = nil;
    
    popoverContent = [UIViewController new];
    popoverContent.view = [self customViewViewFrame:CGRectMake(0., 0., 300., 700.)];
    popoverContent.preferredContentSize = CGSizeMake(300., 700.);
    
    self = [super initWithContentViewController:popoverContent];
    
    return self;
}

#pragma mark - Button Actions

- (IBAction)buttonCancelAction:(id)sender {
    
    [self dismissPopoverAnimated:YES];
}

- (IBAction)buttonDoneAction:(id)sender {
    
    //    [[SVProgressHUD sharedView] setTintColor:[UIColor blackColor]];
    //    [[SVProgressHUD sharedView] setBackgroundColor:[UIColor lighterGrayCustom]];
    
    FFEvent *eventNew = [FFEvent new];
    eventNew.stringCustomerName = searchBarCustom.stringClientName;
    eventNew.numCustomerID = searchBarCustom.numCustomerID;
    eventNew.dateDay = buttonDate.dateOfButton;
    eventNew.dateTimeBegin = buttonTimeBegin.dateOfButton;
    eventNew.dateTimeEnd = buttonTimeEnd.dateOfButton;
    eventNew.arrayWithGuests = tableViewGuests.arrayWithSelectedItens;
    
    NSString *stringError;
    
    if (!eventNew.numCustomerID) {
        stringError = @"Please select a customer.";
    } else if (![self isTimeBeginEarlier:eventNew.dateTimeBegin timeEnd:eventNew.dateTimeEnd]) {
        stringError = @"Start time must occur earlier than end time.";
    } else if (eventNew.arrayWithGuests.count == 0) {
        stringError = @"Please select a guest.";
    }
    
    if (stringError) {
        [[[UIAlertView alloc] initWithTitle:nil message:stringError delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        //        [SVProgressHUD showErrorWithStatus:stringError];
    } else if (protocol != nil && [protocol respondsToSelector:@selector(addNewEvent:)]) {
        [protocol addNewEvent:eventNew];
        [self buttonCancelAction:nil];
    }
}

- (BOOL)isTimeBeginEarlier:(NSDate *)dateBegin timeEnd:(NSDate *)dateEnd {
    
    BOOL boolIsRight = YES;
    
    NSDateComponents *compDateBegin = [NSDate componentsOfDate:dateBegin];
    NSDateComponents *compDateEnd = [NSDate componentsOfDate:dateEnd];
    
    if ((compDateBegin.hour > compDateEnd.hour) || (compDateBegin.hour == compDateEnd.hour && compDateBegin.minute >= compDateEnd.minute)) {
        boolIsRight = NO;
    }
    
    return boolIsRight;
}

#pragma mark - Set Popover Custom View

- (UIView *)customViewViewFrame:(CGRect)frame {
    
    UIView *viewCustom = [[UIView alloc] initWithFrame:frame];
    
    [viewCustom setBackgroundColor:[UIColor lightGrayCustom]];
    [viewCustom.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
    [viewCustom.layer setBorderWidth:2.];
    
    [self addButtonCancelWithCustomView:viewCustom];
    [self addButtonDoneWithCustomView:viewCustom];
    [self addSearchBarWithCustomView:viewCustom];
    [self addButtonDateWithCustomView:viewCustom];
    [self addButtonTimeBeginWithCustomView:viewCustom];
    [self addButtonTimeEndWithCustomView:viewCustom];
    [self addtableViewGuestsWithCustomView:viewCustom];
    
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [gesture setDelegate:self];
    [viewCustom addGestureRecognizer:gesture];
    
    return viewCustom;
}

#pragma mark - Add Subviews

- (void)addButtonCancelWithCustomView:(UIView *)customView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, customView.frame.size.width, BUTTON_HEIGHT+30)];
    [view setBackgroundColor:[UIColor lighterGrayCustom]];
    [customView addSubview:view];
    
    buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self customLayoutOfButton:buttonCancel withTitle:@"Cancel" action:@selector(buttonCancelAction:) frame:CGRectMake(20, 0, 80, BUTTON_HEIGHT+30)];
    [view addSubview:buttonCancel];
}

- (void)addButtonDoneWithCustomView:(UIView *)customView {
    
    buttonDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [self customLayoutOfButton:buttonDone withTitle:@"Done" action:@selector(buttonDoneAction:) frame:CGRectMake(buttonCancel.superview.frame.size.width-80-10, buttonCancel.frame.origin.y, 80, buttonCancel.frame.size.height)];
    [buttonCancel.superview addSubview:buttonDone];
}

- (void)addSearchBarWithCustomView:(UIView *)customView {
    
    searchBarCustom = [[FFSearchBarWithAutoComplete alloc] initWithFrame:CGRectMake(0,buttonCancel.superview.frame.origin.y+buttonCancel.superview.frame.size.height+ BUTTON_HEIGHT, customView.frame.size.width, BUTTON_HEIGHT)];
    [customView addSubview:searchBarCustom];
}

- (void)addButtonDateWithCustomView:(UIView *)customView {
    
    buttonDate = [[FFButtonWithDatePopover alloc] initWithFrame:CGRectMake(0, searchBarCustom.frame.origin.y+searchBarCustom.frame.size.height+2, customView.frame.size.width, BUTTON_HEIGHT) date:event.dateDay];
    [customView addSubview:buttonDate];
}

- (void)addButtonTimeBeginWithCustomView:(UIView *)customView {
    
    buttonTimeBegin = [[FFButtonWithHourPopover alloc] initWithFrame:CGRectMake(0, buttonDate.frame.origin.y+buttonDate.frame.size.height+BUTTON_HEIGHT, customView.frame.size.width, BUTTON_HEIGHT) date:event.dateTimeBegin];
    [customView addSubview:buttonTimeBegin];
}

- (void)addButtonTimeEndWithCustomView:(UIView *)customView {
    
    buttonTimeEnd = [[FFButtonWithHourPopover alloc] initWithFrame:CGRectMake(0, buttonTimeBegin.frame.origin.y+buttonTimeBegin.frame.size.height+2, customView.frame.size.width, BUTTON_HEIGHT) date:event.dateTimeEnd];
    [customView addSubview:buttonTimeEnd];
}

- (void)addtableViewGuestsWithCustomView:(UIView *)customView {
    
    CGFloat y = buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+BUTTON_HEIGHT;
    
    tableViewGuests = [[FFGuestsTableView alloc] initWithFrame:CGRectMake(0, y, customView.frame.size.width,customView.frame.size.height-y)];
    [customView addSubview:tableViewGuests];
}

#pragma mark - Button Layout

- (void)customLayoutOfButton:(UIButton *)button withTitle:(NSString *)title action:(SEL)action frame:(CGRect)frame {
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize]];
    [button setFrame:frame];
    [button setContentMode:UIViewContentModeScaleAspectFit];
}

#pragma mark - Tap Gesture

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    
    [searchBarCustom closeKeyboardAndTableView];
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    CGPoint point = [gestureRecognizer locationInView:popoverContent.view];
    
    return !(searchBarCustom.arrayOfTableView.count != 0 && CGRectContainsPoint(searchBarCustom.tableViewCustom.frame, point)) &&
    CGRectContainsPoint(tableViewGuests.frame, point) && searchBarCustom.tableViewCustom.superview;
}


@end
