//
//  FFSearchBarWithAutoComplete.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/18/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFSearchBarWithAutoComplete.h"

#import "FFImportantFilesForCalendar.h"

@interface FFSearchBarWithAutoComplete () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray *arrayWithAllClients;
@end

@implementation FFSearchBarWithAutoComplete

#pragma mark - Synthesize

@synthesize arrayWithAllClients;
@synthesize arrayOfTableView;
@synthesize tableViewCustom;
@synthesize stringClientName;
@synthesize numCustomerID;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        arrayOfTableView = [NSMutableArray new];
        arrayWithAllClients = [NSMutableArray arrayWithArray:@[ @[@1, @"Customer A"], @[@2, @"Customer B"], @[@3, @"Customer C"], @[@4, @"Customer D"], @[@5, @"Customer E"] ]];
        
        tableViewCustom = [UITableView new];
        [tableViewCustom registerClass:[UITableViewCell class] forCellReuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL];
        [tableViewCustom setDataSource:self];
        [tableViewCustom setDelegate:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
     
        [self setDelegate:self];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        [self setPlaceholder:@"Customer"];
        [[UITextField appearanceWhenContainedIn:[FFSearchBarWithAutoComplete class], nil] setFont:[UIFont systemFontOfSize:18.]];
        [[UITextField appearanceWhenContainedIn:[FFSearchBarWithAutoComplete class], nil] setTextAlignment:NSTextAlignmentCenter];
    }
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setStringClientName:(NSString *)_stringClientName {
    
    stringClientName = _stringClientName;
    
    [self setText:_stringClientName];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - NSNotificationCenter Method

- (void)keyboardShown:(NSNotification *)note {
    
    if (!tableViewCustom.superview) {
        [self.superview addSubview:tableViewCustom];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    long intRows = [arrayOfTableView count];
    
    CGFloat height = 4*BUTTON_HEIGHT;
    if (intRows < 4) {
        height = intRows*BUTTON_HEIGHT;
    }
    [tableViewCustom setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width, height)];
    
    return intRows;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_IDENTIFIER_MONTH_CELL];
    if (cell == nil) {
        cell = [[ UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSE_IDENTIFIER_MONTH_CELL];
    }
    [cell setBackgroundColor:[UIColor lightGrayCustom]];
    
    NSArray *arrayCell = [arrayOfTableView objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [arrayCell objectAtIndex:1];
    
    return cell;
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *arrayCell = [arrayOfTableView objectAtIndex:indexPath.row];
    
    [self setStringClientName:[arrayCell objectAtIndex:1]];
    [self setNumCustomerID:[arrayCell objectAtIndex:0]];
    
    [self setText:[arrayCell objectAtIndex:1]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self closeKeyboardAndTableView];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    numCustomerID = nil;
    [arrayOfTableView removeAllObjects];
    
    if ([searchText length] != 0) {
        [self updateArrayOfTableViewWithText:searchText];
        
    }
    
    [tableViewCustom reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self closeKeyboardAndTableView];
}

#pragma mark - close Keyboard and TableView

- (void)closeKeyboardAndTableView {
    
    [self resignFirstResponder];
    [arrayOfTableView removeAllObjects];
    [tableViewCustom removeFromSuperview];
    [tableViewCustom reloadData];
}

#pragma mark - Update Array Of TableView

- (void)updateArrayOfTableViewWithText:(NSString *)searchText {
    
    for ( NSArray *arrayCell in arrayWithAllClients) {
        NSString *string = [arrayCell objectAtIndex:1];
        NSRange r = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (r.location != NSNotFound) {
            [arrayOfTableView addObject:arrayCell];
        }
    }
    
}

@end
