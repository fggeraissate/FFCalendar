//
//  NSDate+FFDaysCount.m
//  FFCalendar
//
//  Created by Felipe Rocha on 14/02/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "NSDate+FFDaysCount.h"
#import "FFImportantFilesForCalendar.h"

@implementation NSDate (FFDaysCount)

-(NSDate*)lastDayOfMonth {
    
    NSInteger dayCount = [self numberOfDaysInMonthCount];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSDateComponents *comp = [calendar components:
                              NSYearCalendarUnit |
                              NSMonthCalendarUnit |
                              NSDayCalendarUnit fromDate:self];
    
    [comp setDay:dayCount];
    
    return [calendar dateFromComponents:comp];
}

-(NSInteger)numberOfDaysInMonthCount {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
//    [calendar setTimeZone:[NSTimeZone timeZoneWithName:TIMEZONE]];
    
    NSRange dayRange = [calendar rangeOfUnit:NSDayCalendarUnit
                                      inUnit:NSMonthCalendarUnit
                                     forDate:self];
    
    return dayRange.length;
}

- (NSInteger)numberOfWeekInMonthCount {
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange weekRange = [calender rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    return weekRange.length;
}


- (NSDateComponents *)componentsOfDate{
    
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday | NSHourCalendarUnit |
            NSMinuteCalendarUnit fromDate:self];
}

#pragma mark - Methods Statics

+ (NSDateComponents *)componentsOfCurrentDate {
    
    return [NSDate componentsOfDate:[NSDate date]];
}

+ (NSDateComponents *)componentsOfDate:(NSDate *)date {
    
    return [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth| NSHourCalendarUnit |
            NSMinuteCalendarUnit fromDate:date];
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [NSDate componentsWithYear:year month:month day:day];
    
    return [calendar dateFromComponents:components];
}

+ (NSDate *)dateWithHour:(NSInteger)hour min:(NSInteger)min {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [NSDate componentsWithHour:hour min:min];
    
    return [calendar dateFromComponents:components];
}

+ (NSString *)stringTimeOfDate:(NSDate *)date {
    
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    [dateFormater setDateFormat:@"HH:mm"];
    
    return [dateFormater stringFromDate:date];
}

+ (NSString *)stringDayOfDate:(NSDate *)date {
    
    NSDateComponents *comp = [NSDate componentsOfDate:date];
    
    //    return [NSString stringWithFormat:@"%@, %i/%i/%i", [dictWeekNumberName objectForKey:[NSNumber numberWithInt:comp.weekday]], comp.day, comp.month, comp.year];
    return [NSString stringWithFormat:@"%@, %@ %li, %li", [dictWeekNumberName objectForKey:[NSNumber numberWithLong:comp.weekday]], [arrayMonthNameAbrev objectAtIndex:comp.month-1], (long)comp.day, (long)comp.year];
}

+ (NSDateComponents *)componentsWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    
    return components;
}

+ (NSDateComponents *)componentsWithHour:(NSInteger)hour min:(NSInteger)min {
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hour];
    [components setMinute:min];
    
    return components;
}

+ (BOOL)isTheSameDateTheCompA:(NSDateComponents *)compA compB:(NSDateComponents *)compB {
    
    return ([compA day]==[compB day] && [compA month]==[compB month ]&& [compA year]==[compB year]);
}

+ (BOOL)isTheSameTimeTheCompA:(NSDateComponents *)compA compB:(NSDateComponents *)compB {
    
    return ([compA hour]==[compB hour] && [compA minute]==[compB minute]);
}

@end
