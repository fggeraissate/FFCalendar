//
//  FFDayCalendarView.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/23/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@protocol FFDayCalendarViewProtocol <NSObject>
@required
- (void)setNewDictionary:(NSDictionary *)dict;
@end

@interface FFDayCalendarView : UIView

@property (nonatomic, strong) id<FFDayCalendarViewProtocol> protocol;
@property (nonatomic, strong) NSMutableDictionary *dictEvents;

- (void)invalidateLayout;

@end
