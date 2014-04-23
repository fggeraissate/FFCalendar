//
//  FFEvent.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/16/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <Foundation/Foundation.h>

@interface FFEvent : NSObject

@property (nonatomic, strong) NSString *stringCustomerName;
@property (nonatomic, strong) NSNumber *numCustomerID;
@property (nonatomic, strong) NSDate *dateDay;
@property (nonatomic, strong) NSDate *dateTimeBegin;
@property (nonatomic, strong) NSDate *dateTimeEnd;
@property (nonatomic, strong) NSMutableArray *arrayWithGuests;

@end
