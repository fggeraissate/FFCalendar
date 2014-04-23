//
//  FFDayScrollView.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/23/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

#import "FFDayCollectionView.h"

@interface FFDayScrollView : UIScrollView 

@property (nonatomic, strong) NSMutableDictionary *dictEvents;
@property (nonatomic, strong) FFDayCollectionView *collectionViewDay;
@property (nonatomic, strong) UILabel *labelWithActualHour;

@end
