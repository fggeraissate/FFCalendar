//
//  NSDate+FFDaysCount.h
//  FFCalendar
//
//  Created by Felipe Rocha on 14/02/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <Foundation/Foundation.h>

@interface NSDate (FFDaysCount)

- (NSDate *)lastDayOfMonth;
- (NSInteger)numberOfDaysInMonthCount;
- (NSInteger)numberOfWeekInMonthCount;
- (NSDateComponents *)componentsOfDate;


+ (NSString *)stringDayOfDate:(NSDate *)date;
+ (NSString *)stringTimeOfDate:(NSDate *)date;
+ (NSDateComponents *)componentsOfCurrentDate;
+ (NSDateComponents *)componentsOfDate:(NSDate *)date;
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSDate *)dateWithHour:(NSInteger)hour min:(NSInteger)min;
+ (NSDateComponents *)componentsWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSDateComponents *)componentsWithHour:(NSInteger)hour min:(NSInteger)min;
+ (BOOL)isTheSameDateTheCompA:(NSDateComponents *)compA compB:(NSDateComponents *)compB;
+ (BOOL)isTheSameTimeTheCompA:(NSDateComponents *)compA compB:(NSDateComponents *)compB;

@end
