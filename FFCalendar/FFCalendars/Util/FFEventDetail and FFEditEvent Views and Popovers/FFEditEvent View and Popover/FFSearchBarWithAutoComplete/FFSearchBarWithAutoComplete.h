//
//  FFSearchBarWithAutoComplete.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/18/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

@interface FFSearchBarWithAutoComplete : UISearchBar

@property (nonatomic, strong, readonly) NSMutableArray *arrayOfTableView;
@property (nonatomic, strong) NSString *stringClientName;
@property (nonatomic, strong) NSNumber *numCustomerID;
@property (nonatomic, strong) UITableView *tableViewCustom;

- (void)closeKeyboardAndTableView;

@end
