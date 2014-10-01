FFCalendar
==========
A study of iOS Yearly, Monthly, Weekly and Daily Calendars.

<img src="https://raw.githubusercontent.com/fggeraissate/FFCalendar/master/FFCalendar/FFCalendars/Util/Images/YearlyCalendar.png" alt="Yearly Calendar for iOS" width="300" height="401"/>
<img src="https://raw.githubusercontent.com/fggeraissate/FFCalendar/master/FFCalendar/FFCalendars/Util/Images/MonthlyCalendar.png" alt="Monthly Calendar for iOS" width="300" height="401"/>
<img src="https://raw.githubusercontent.com/fggeraissate/FFCalendar/master/FFCalendar/FFCalendars/Util/Images/WeeklyCalendar.png" alt="Weekly Calendar for iOS" width="300" height="401"/>
<img src="https://raw.githubusercontent.com/fggeraissate/FFCalendar/master/FFCalendar/FFCalendars/Util/Images/DailyCalendar.png" alt="Daily Calendar for iOS" width="300" height="401"/>

## Limitations
- For iPad only
- Works on iOS 7 and above

## Usage
Basic usage is implemented in `FFCalendarViewController`. First you should import `FFCalendar.h` in `FFCalendarViewController`. Then, subclass `FFYearCalendarView`, `FFMonthCalendarView`, `FFWeekCalendarView` and `FFDayCalendarView`. Also set the respective protocols, they will always provide the last modified dictionary (which I called `dictEvents`), and hence, they will help to update the others calendars. 

The `dictEvents` is formed by events (`FFEvent`) and their dates. Inside `FFEvent` you will find:
- `stringCustomerName`: the name of the customer
- `dateDay`: informs the day, month and year when the event will happen
- `dateTimeBegin`: the hour and minute when the event will begin
- `dateTimeEnd`: the hour and minute when the event will end
- `arrayWithGuests`: an array with all selected guests.

On the other hand, if you enjoyed the `FFCalendarViewController`'s view as it is, you can just add it as a single subview, like following: 

```python
- (void)displayFFCalendar {

    FFCalendarViewController *calendarVc = [FFCalendarViewController new];
    [calendarVc setProtocol:self];
    [calendarVc setArrayWithEvents:[self arrayWithEvents]];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:calendarVc];
    navigationController.view.frame = CGRectMake(0., 0., self.view.frame.size.width, self.view.frame.size.height);

    [self addChildViewController:navigationController];
    [self.view addSubview:navigationController.view];
    [navigationController didMoveToParentViewController:self];
}

- (NSMutableArray *)arrayWithEvents {

    FFEvent *event1 = [FFEvent new];
    [event1 setStringCustomerName: @"Customer A"];
    [event1 setNumCustomerID:@1];
    [event1 setDateDay:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year month:[NSDate componentsOfCurrentDate].month day:[NSDate componentsOfCurrentDate].day]];
    [event1 setDateTimeBegin:[NSDate dateWithHour:10 min:00]];
    [event1 setDateTimeEnd:[NSDate dateWithHour:15 min:13]];
    [event1 setArrayWithGuests:[NSMutableArray arrayWithArray:@[@[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 7", @"email7@email.com"]]]];
    
    return [NSMutableArray arrayWithArray:@[event1];
}
```

## License
`FFCalendar` is available under the [MIT license](https://github.com/fggeraissate/FFCalendar/blob/master/LICENSE).

## Contact
Contact me at: http://fernandasportfolio.tumblr.com/contato

