//
//  FFYearCollectionViewFlowLayout.m
//  FFCalendar
//
//  Created by Hive on 3/18/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFYearCollectionViewFlowLayout.h"

@implementation FFYearCollectionViewFlowLayout

- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(self.collectionView.frame.size.width, 3*(self.collectionView.frame.size.height));
}


@end
