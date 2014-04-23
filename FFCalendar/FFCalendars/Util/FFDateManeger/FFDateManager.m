//
//  FFDateManager.m
//  FFCalendar
//
//  Created by Felipe Rocha on 19/02/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFDateManager.h"

@implementation FFDateManager

@synthesize currentDate;

+ (id)sharedManager {
    static FFDateManager *sharedDateManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDateManager = [[self alloc] init];
    });
    return sharedDateManager;
}

- (id)init {
    if (self = [super init]) {
        currentDate = [NSDate new];
    }
    return self;
}

- (void)dealloc {
}

- (void)setCurrentDate:(NSDate *)_currentDate {
    
    currentDate = _currentDate;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DATE_MANAGER_DATE_CHANGED object:_currentDate];
}

@end
