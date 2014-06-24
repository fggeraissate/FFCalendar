//
//  EditView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/19/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFEditEventView.h"

#import "FFButtonWithDatePopover.h"
#import "FFButtonWithHourPopover.h"
#import "FFSearchBarWithAutoComplete.h"
#import "FFGuestsTableView.h"
#import "FFImportantFilesForCalendar.h"
//#import "SVProgressHUD.h"

@interface FFEditEventView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) FFEvent *event;
@property (nonatomic, strong) UIButton *buttonCancel;
@property (nonatomic, strong) UIButton *buttonDone;
@property (nonatomic, strong) UIButton *buttonDelete;
@property (nonatomic, strong) UILabel *labelEventName;
@property (nonatomic, strong) FFSearchBarWithAutoComplete *searchBarCustom;
@property (nonatomic, strong) FFButtonWithDatePopover *buttonDate;
@property (nonatomic, strong) FFButtonWithHourPopover *buttonTimeBegin;
@property (nonatomic, strong) FFButtonWithHourPopover *buttonTimeEnd;
@property (nonatomic, strong) FFGuestsTableView *tableViewGuests;
@end

@implementation FFEditEventView

#pragma mark - Synthesize

@synthesize protocol;
@synthesize event;
@synthesize buttonDone;
@synthesize buttonCancel;
@synthesize buttonDelete;
@synthesize labelEventName;
@synthesize searchBarCustom;
@synthesize buttonDate;
@synthesize buttonTimeBegin;
@synthesize buttonTimeEnd;
@synthesize tableViewGuests;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

- (id)initWithFrame:(CGRect)frame event:(FFEvent *)_event {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        event = _event;
        
        [self setBackgroundColor:[UIColor lightGrayCustom]];
        [self.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
        [self.layer setBorderWidth:2.];
        
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [gesture setDelegate:self];
        [self addGestureRecognizer:gesture];

        [self addButtonCancel];
        [self addButtonDone];
        [self addSearchBar];
        [self addButtonDate];
        [self addButtonTimeBegin];
        [self addButtonTimeEnd];
        [self addButtonDelete];
        [self addtableViewGuests];
    }
    return self;
}

#pragma mark - Button Actions

- (IBAction)buttonCancelAction:(id)sender {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(removeThisView:)]) {
        [protocol removeThisView:self];
    }
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
    } else if (protocol != nil && [protocol respondsToSelector:@selector(saveEvent:)]) {
        [protocol saveEvent:eventNew];
        [self buttonDeleteAction:nil];
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

- (IBAction)buttonDeleteAction:(id)sender {
    
    if (protocol != nil && [protocol respondsToSelector:@selector(deleteEvent:)]) {
        [protocol deleteEvent:event];
    }
    
   [self buttonCancelAction:nil];
}

#pragma mark - Tap Gesture

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    
    [searchBarCustom closeKeyboardAndTableView];
}

#pragma mark - Add Subviews

- (void)addButtonCancel {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BUTTON_HEIGHT+30)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [view setBackgroundColor:[UIColor lighterGrayCustom]];
    [self addSubview:view];
    
    buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonCancel setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
    [self customLayoutOfButton:buttonCancel withTitle:@"Cancel" action:@selector(buttonCancelAction:) frame:CGRectMake(20, 0, 80, BUTTON_HEIGHT+30)];
    [view addSubview:buttonCancel];
}

- (void)addButtonDone {
    
    buttonDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonDone setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    [self customLayoutOfButton:buttonDone withTitle:@"Done" action:@selector(buttonDoneAction:) frame:CGRectMake(buttonCancel.superview.frame.size.width-80-10, buttonCancel.frame.origin.y, 80, buttonCancel.frame.size.height)];
    [buttonCancel.superview addSubview:buttonDone];
}

- (void)addSearchBar {
    
    searchBarCustom = [[FFSearchBarWithAutoComplete alloc] initWithFrame:CGRectMake(0,buttonCancel.superview.frame.origin.y+buttonCancel.superview.frame.size.height+ BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT)];
    [searchBarCustom setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [searchBarCustom setStringClientName:event.stringCustomerName];
    [searchBarCustom setNumCustomerID:event.numCustomerID];
    [self addSubview:searchBarCustom];
}

- (void)addButtonDate {
    
    buttonDate = [[FFButtonWithDatePopover alloc] initWithFrame:CGRectMake(0, searchBarCustom.frame.origin.y+searchBarCustom.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT) date:event.dateDay];
    [buttonDate setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:buttonDate];
}

- (void)addButtonTimeBegin {
    
    buttonTimeBegin = [[FFButtonWithHourPopover alloc] initWithFrame:CGRectMake(0, buttonDate.frame.origin.y+buttonDate.frame.size.height+BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT) date:event.dateTimeBegin];
    [buttonTimeBegin setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:buttonTimeBegin];
}

- (void)addButtonTimeEnd {
    
    buttonTimeEnd = [[FFButtonWithHourPopover alloc] initWithFrame:CGRectMake(0, buttonTimeBegin.frame.origin.y+buttonTimeBegin.frame.size.height+2, self.frame.size.width, BUTTON_HEIGHT) date:event.dateTimeEnd];
    [buttonTimeEnd setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:buttonTimeEnd];
}

- (void)addButtonDelete {
    
    buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonDelete setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [self customLayoutOfButton:buttonDelete withTitle:@"Delete Event" action:@selector(buttonDeleteAction:) frame:CGRectMake(0, self.frame.size.height-2*BUTTON_HEIGHT, self.frame.size.width, 2*BUTTON_HEIGHT)];
    [buttonDelete setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:buttonDelete];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, buttonDelete.frame.origin.y-BUTTON_HEIGHT, self.frame.size.width, BUTTON_HEIGHT)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [self addSubview:view];
}

- (void)addtableViewGuests {
    
    CGFloat y = buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+BUTTON_HEIGHT;
    
    tableViewGuests = [[FFGuestsTableView alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width,buttonDelete.frame.origin.y-y-BUTTON_HEIGHT)];
    [tableViewGuests setAutoresizingMask:AR_WIDTH_HEIGHT];
    [tableViewGuests setArrayWithSelectedItens:event.arrayWithGuests];
    [self addSubview:tableViewGuests];
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

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    CGPoint point = [gestureRecognizer locationInView:self];
    
    return !(searchBarCustom.arrayOfTableView.count != 0 && CGRectContainsPoint(searchBarCustom.tableViewCustom.frame, point)) &&
    CGRectContainsPoint(tableViewGuests.frame, point) && searchBarCustom.tableViewCustom.superview;
}

@end
