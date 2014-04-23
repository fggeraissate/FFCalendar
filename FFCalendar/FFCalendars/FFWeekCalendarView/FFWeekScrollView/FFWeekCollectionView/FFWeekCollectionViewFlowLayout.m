//
//  FFWeekCollectionViewFlowLayout.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/22/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFWeekCollectionViewFlowLayout.h"

@implementation FFWeekCollectionViewFlowLayout

- (id)init {
    
    self = [super init];
    
    if (self) {
        [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    return self;
}


- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(([[[FFDateManager sharedManager] currentDate] numberOfWeekInMonthCount]+2)*self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}

@end
