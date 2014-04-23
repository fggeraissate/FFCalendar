//
//  EditView.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/19/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

#import "FFEvent.h"

@protocol FFEditEventViewProtocol <NSObject>
@required
- (void)saveEvent:(FFEvent *)_event;
- (void)deleteEvent:(FFEvent *)_event;
- (void)removeThisView:(UIView *)view;
@end

@interface FFEditEventView : UIView

@property (nonatomic, strong) id<FFEditEventViewProtocol> protocol;

- (id)initWithFrame:(CGRect)frame event:(FFEvent *)_event;

@end
