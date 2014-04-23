//
//  FFCalendarViewController.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 12/02/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@protocol FFCalendarViewControllerProtocol <NSObject>
@required
- (void)arrayUpdatedWithAllEvents:(NSMutableArray *)arrayUpdated;
@end

@interface FFCalendarViewController : UIViewController

@property (nonatomic, strong) id <FFCalendarViewControllerProtocol> protocol;
@property (nonatomic, strong) NSMutableArray *arrayWithEvents;

@end
