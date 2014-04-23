//
//  FFCalendarViewController.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 12/02/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFCalendarViewController.h"

#import "FFCalendar.h"

@interface FFCalendarViewController () <FFButtonAddEventWithPopoverProtocol, FFYearCalendarViewProtocol, FFMonthCalendarViewProtocol, FFWeekCalendarViewProtocol, FFDayCalendarViewProtocol>
@property (nonatomic, strong) NSMutableDictionary *dictEvents;
@property (nonatomic, strong) UILabel *labelWithMonthAndYear;
@property (nonatomic, strong) NSArray *arrayButtons;
@property (nonatomic, strong) NSArray *arrayCalendars;
@property (nonatomic, strong) FFEditEventPopoverController *popoverControllerEditar;
@property (nonatomic, strong) FFYearCalendarView *viewCalendarYear;
@property (nonatomic, strong) FFMonthCalendarView *viewCalendarMonth;
@property (nonatomic, strong) FFWeekCalendarView *viewCalendarWeek;
@property (nonatomic, strong) FFDayCalendarView *viewCalendarDay;
@end

@implementation FFCalendarViewController

#pragma mark - Synthesize

@synthesize protocol;
@synthesize arrayWithEvents;
@synthesize dictEvents;
@synthesize labelWithMonthAndYear;
@synthesize arrayButtons;
@synthesize arrayCalendars;
@synthesize popoverControllerEditar;
@synthesize viewCalendarYear;
@synthesize viewCalendarMonth;
@synthesize viewCalendarWeek;
@synthesize viewCalendarDay;

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];

    [self customNavigationBarLayout];
    
    [self buttonTodayAction:nil];
    
    [self addSubviews];
    
    [self bringCalendarToFrontAndSelectButton:[arrayButtons objectAtIndex:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FFDateManager Notification

- (void)dateChanged:(NSNotification *)notification {
    
    NSDateComponents *comp = [NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]];
    
    [labelWithMonthAndYear setText:[NSString stringWithFormat:@"%@ %i", [arrayMonthName objectAtIndex:comp.month-1], comp.year]];
}


#pragma mark - Init dictEvents

- (void)setArrayWithEvents:(NSMutableArray *)_arrayWithEvents {
    
    arrayWithEvents = _arrayWithEvents;
    
    dictEvents = [NSMutableDictionary new];
    
    for (FFEvent *event in _arrayWithEvents) {
        NSDateComponents *comp = [NSDate componentsOfDate:event.dateDay];
        NSDate *newDate = [NSDate dateWithYear:comp.year month:comp.month day:comp.day];
        NSMutableArray *array = [dictEvents objectForKey:newDate];
        if (!array) {
            array = [NSMutableArray new];
            [dictEvents setObject:array forKey:newDate];
        }
        [array addObject:event];
    }
}

#pragma mark - Custom NavigationBar

- (void)customNavigationBarLayout {
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor cinzaSuperClaro]];
    
    // --------------- //
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 30.;
    
    FFRedAndWhiteButton *buttonYear = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30.)];
    [buttonYear addTarget:self action:@selector(buttonYearAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonYear setTitle:@"year" forState:UIControlStateNormal];
    UIBarButtonItem *barButtonYear = [[UIBarButtonItem alloc] initWithCustomView:buttonYear];
    
    FFRedAndWhiteButton *buttonMonth = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30.)];
    [buttonMonth addTarget:self action:@selector(buttonMonthAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonMonth setTitle:@"month" forState:UIControlStateNormal];
    UIBarButtonItem *barButtonMonth = [[UIBarButtonItem alloc] initWithCustomView:buttonMonth];
    
    FFRedAndWhiteButton *buttonWeek = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30.)];
    [buttonWeek addTarget:self action:@selector(buttonWeekAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonWeek setTitle:@"week" forState:UIControlStateNormal];
    UIBarButtonItem *barButtonWeek = [[UIBarButtonItem alloc] initWithCustomView:buttonWeek];
    
    FFRedAndWhiteButton *buttonDay = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30.)];
    [buttonDay addTarget:self action:@selector(buttonDayAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonDay setTitle:@"day" forState:UIControlStateNormal];
    UIBarButtonItem *barButtonDay = [[UIBarButtonItem alloc] initWithCustomView:buttonDay];
    
    FFButtonAddEventWithPopover *buttonAdd = [[FFButtonAddEventWithPopover alloc] initWithFrame:CGRectMake(0., 0., 30., 44)];
    [buttonAdd setProtocol:self];
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithCustomView:buttonAdd];
    
    arrayButtons = @[buttonYear, buttonMonth, buttonWeek, buttonDay];
    
    [self.navigationItem setRightBarButtonItems:@[barButtonAdd, fixedItem, barButtonYear, barButtonMonth, barButtonWeek, barButtonDay]];
    
    // --------------- //
    
    FFRedAndWhiteButton *buttonToday = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30)];
    [buttonToday addTarget:self action:@selector(buttonTodayAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonToday setTitle:@"today" forState:UIControlStateNormal];
    UIBarButtonItem *barButtonToday = [[UIBarButtonItem alloc] initWithCustomView:buttonToday];
    
    labelWithMonthAndYear = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., 170., 30)];
    [labelWithMonthAndYear setTextColor:[UIColor redColor]];
    [labelWithMonthAndYear setFont:buttonToday.titleLabel.font];
    UIBarButtonItem *barButtonLabel = [[UIBarButtonItem alloc] initWithCustomView:labelWithMonthAndYear];
    
    [self.navigationItem setLeftBarButtonItems:@[barButtonLabel, fixedItem, barButtonToday]];
}

- (void)addSubviews {
    
    viewCalendarYear = [[FFYearCalendarView alloc] initWithFrame:CGRectMake(0., 0., self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-self.navigationController.navigationBar.frame.origin.y)];
    [viewCalendarYear setProtocol:self];
    [self.view addSubview:viewCalendarYear];
    
    viewCalendarMonth = [[FFMonthCalendarView alloc] initWithFrame:CGRectMake(0., 0., self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-self.navigationController.navigationBar.frame.origin.y)];
    [viewCalendarMonth setProtocol:self];
    [viewCalendarMonth setDictEvents:dictEvents];
    [self.view addSubview:viewCalendarMonth];
    
    viewCalendarWeek = [[FFWeekCalendarView alloc] initWithFrame:CGRectMake(0., 0., self.view.frame.size.width, self.view.frame.size.height)];
    [viewCalendarWeek setProtocol:self];
    [viewCalendarWeek setDictEvents:dictEvents];
    [self.view addSubview:viewCalendarWeek];
    
    viewCalendarDay = [[FFDayCalendarView alloc] initWithFrame:CGRectMake(0., 0., self.view.frame.size.width, self.view.frame.size.height)];
    [viewCalendarDay setProtocol:self];
    [viewCalendarDay setDictEvents:dictEvents];
    [self.view addSubview:viewCalendarDay];
    
    arrayCalendars = @[viewCalendarYear, viewCalendarMonth, viewCalendarWeek, viewCalendarDay];
}

#pragma mark - Button Action

- (IBAction)buttonYearAction:(id)sender {
    
    [self bringCalendarToFrontAndSelectButton:sender];
}

- (IBAction)buttonMonthAction:(id)sender {
    
    [self bringCalendarToFrontAndSelectButton:sender];
}

- (IBAction)buttonWeekAction:(id)sender {
    
    [self bringCalendarToFrontAndSelectButton:sender];
}

- (IBAction)buttonDayAction:(id)sender {
    
    [self bringCalendarToFrontAndSelectButton:sender];
}

- (void)bringCalendarToFrontAndSelectButton:(UIButton *)buttonSelected {
    
    [self.view bringSubviewToFront:[arrayCalendars objectAtIndex:[arrayButtons indexOfObject:buttonSelected]]];
    
    for (UIButton *button in arrayButtons) {
        button.selected = (button == buttonSelected);
    }
}

- (IBAction)buttonTodayAction:(id)sender {
    
    [[FFDateManager sharedManager] setCurrentDate:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year
                                                               month:[NSDate componentsOfCurrentDate].month
                                                                 day:[NSDate componentsOfCurrentDate].day]];
}

#pragma mark - FFButtonAddEventWithPopover Protocol

- (void)addNewEvent:(FFEvent *)eventNew {
    
    NSMutableArray *arrayNew = [dictEvents objectForKey:eventNew.dateDay];
    if (!arrayNew) {
        arrayNew = [NSMutableArray new];
        [dictEvents setObject:arrayNew forKey:eventNew.dateDay];
    }
    [arrayNew addObject:eventNew];
    
    [self setNewDictionary:dictEvents];
}

#pragma mark - FFMonthCalendarView, FFWeekCalendarView and FFDayCalendarView Protocols

- (void)setNewDictionary:(NSDictionary *)dict {
    
    dictEvents = (NSMutableDictionary *)dict;
    
    [viewCalendarMonth setDictEvents:dictEvents];
    [viewCalendarWeek setDictEvents:dictEvents];
    [viewCalendarDay setDictEvents:dictEvents];
    
    [self arrayUpdatedWithAllEvents];
}

#pragma mark - Sending Updated Array to FFCalendarViewController Protocol

- (void)arrayUpdatedWithAllEvents {
    
    NSMutableArray *arrayNew = [NSMutableArray new];
    
    NSArray *arrayKeys = dictEvents.allKeys;
    for (NSDate *date in arrayKeys) {
        NSArray *arrayOfDate = [dictEvents objectForKey:date];
        for (FFEvent *event in arrayOfDate) {
            [arrayNew addObject:event];
        }
    }
    
    if (protocol != nil && [protocol respondsToSelector:@selector(arrayUpdatedWithAllEvents:)]) {
        [protocol arrayUpdatedWithAllEvents:arrayNew];
    }
}

#pragma mark - FFYearCalendarView Protocol

- (void)showMonthCalendar {
    
    [self bringCalendarToFrontAndSelectButton:[arrayButtons objectAtIndex:1]];
}

@end
