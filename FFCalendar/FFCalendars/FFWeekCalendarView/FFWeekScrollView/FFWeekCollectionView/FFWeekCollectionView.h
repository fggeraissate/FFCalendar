//
//  FFWeekCollectionView.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/21/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@protocol FFWeekCollectionViewProtocol <NSObject>
@required
- (void)collectionViewDidScroll;
- (void)showHourLine:(BOOL)show;
- (void)setNewDictionary:(NSDictionary *)dict;
@end

@interface FFWeekCollectionView : UICollectionView

@property (nonatomic, strong) id<FFWeekCollectionViewProtocol> protocol;
@property (nonatomic, strong) NSMutableDictionary *dictEvents;

@end
