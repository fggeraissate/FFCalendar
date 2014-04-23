//
//  FFEventDetailView.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/19/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

#import "FFEvent.h"

@protocol FFEventDetailViewProtocol <NSObject>
@required
- (void)showEditViewWithEvent:(FFEvent *)_event;
@end

@interface FFEventDetailView : UIView

@property (nonatomic, strong) id<FFEventDetailViewProtocol> protocol;
@property (nonatomic, strong) UIButton *buttonEditPopover;

- (id)initWithFrame:(CGRect)frame event:(FFEvent *)_event;

@end
