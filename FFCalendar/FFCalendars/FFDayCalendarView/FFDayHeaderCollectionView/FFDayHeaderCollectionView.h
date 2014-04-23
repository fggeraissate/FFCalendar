//
//  FFDayHeaderCollectionView.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/26/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@protocol FFDayHeaderCollectionViewProtocol <NSObject>
@required
- (void)daySelected:(NSDate *)date;
@end

@interface FFDayHeaderCollectionView : UICollectionView

@property (nonatomic, strong) id<FFDayHeaderCollectionViewProtocol> protocol;

- (void)scrollToDate:(NSDate *)date;

@end
