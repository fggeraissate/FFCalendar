//
//  FFWeekHeaderCollectionView.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/26/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@protocol FFWeekHeaderCollectionViewProtocol <NSObject>
@required
- (void)headerDidScroll;
- (void)showHourLine:(BOOL)show;
@end

@interface FFWeekHeaderCollectionView : UICollectionView

@property id<FFWeekHeaderCollectionViewProtocol> protocol;

@end
