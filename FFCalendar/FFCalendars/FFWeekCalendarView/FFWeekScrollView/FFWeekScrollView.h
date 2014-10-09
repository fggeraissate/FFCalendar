//
//  FFWeekScrollView.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/21/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

#import "FFWeekCollectionView.h"

@interface FFWeekScrollView : UIScrollView

@property (nonatomic, strong) NSMutableDictionary *dictEvents;
@property (nonatomic, strong) FFWeekCollectionView *collectionViewWeek;
@property (nonatomic, strong) UILabel *labelWithActualHour;
@property (nonatomic, strong) UILabel *labelGrayWithActualHour;

- (void)showlabelsWithActualHourWithAlpha:(BOOL)show;

@end
