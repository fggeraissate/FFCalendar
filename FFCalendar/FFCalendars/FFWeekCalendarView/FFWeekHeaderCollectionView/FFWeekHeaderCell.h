//
//  FFWeekHeaderCell.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/26/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@interface FFWeekHeaderCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSDate *date;

- (void)cleanCell;

@end
