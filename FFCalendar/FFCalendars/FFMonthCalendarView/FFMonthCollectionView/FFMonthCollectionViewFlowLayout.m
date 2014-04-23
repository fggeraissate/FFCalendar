//
//  FFMonthCollectionViewFlowLayout.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/17/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFMonthCollectionViewFlowLayout.h"

@implementation FFMonthCollectionViewFlowLayout

- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(self.collectionView.frame.size.width, 3*(self.collectionView.frame.size.height));
}

@end
