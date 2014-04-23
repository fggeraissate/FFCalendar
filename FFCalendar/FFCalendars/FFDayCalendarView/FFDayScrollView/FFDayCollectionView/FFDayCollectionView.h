//
//  FFDayCollectionView.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/23/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

#import "FFDayCell.h"

@protocol FFDayCollectionViewProtocol <NSObject>
- (void)updateHeader;
@end

@interface FFDayCollectionView : UICollectionView

@property (nonatomic, strong) id<FFDayCollectionViewProtocol> protocol;
@property (nonatomic, strong) NSMutableDictionary *dictEvents;

@end
