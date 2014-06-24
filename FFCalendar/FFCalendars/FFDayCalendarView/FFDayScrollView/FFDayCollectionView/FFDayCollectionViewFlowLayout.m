//
//  FFDayCollectionViewFlowLayout.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/23/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFDayCollectionViewFlowLayout.h"

#import "FFImportantFilesForCalendar.h"

@implementation FFDayCollectionViewFlowLayout

- (id)init {
    
    self = [super init];
    
    if (self) {
        [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    return self;
}


- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(7*([[[FFDateManager sharedManager] currentDate] numberOfWeekInMonthCount]+2)*self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}

@end
