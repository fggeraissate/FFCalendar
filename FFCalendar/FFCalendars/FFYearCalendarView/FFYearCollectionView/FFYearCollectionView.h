//
//  FFYearCollectionView.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/6/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@protocol FFYearCollectionViewProtocol <NSObject>
@required
- (void)showMonthCalendar;
@end

@interface FFYearCollectionView : UICollectionView

@property (nonatomic, strong) id<FFYearCollectionViewProtocol> protocol;

@end
