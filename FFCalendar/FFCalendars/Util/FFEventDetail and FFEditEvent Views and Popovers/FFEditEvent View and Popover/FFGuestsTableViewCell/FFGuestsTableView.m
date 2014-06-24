//
//  FFGuestsTableView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/28/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFGuestsTableView.h"

#import "FFGuestsTableViewCell.h"
#import "FFImportantFilesForCalendar.h"

@interface FFGuestsTableView () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *arrayWithAllContacts;
@end

@implementation FFGuestsTableView

#pragma mark - Synthesize

@synthesize arrayWithAllContacts;
@synthesize arrayWithSelectedItens;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setDelegate:self];
        [self setDataSource:self];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self registerClass: [FFGuestsTableViewCell class] forCellReuseIdentifier:REUSE_IDENTIFIER_DAY_CELL];
        
        [self setAllowsMultipleSelection:YES];
        
        [self updateArrayWithAllContacts];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrayWithAllContacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = REUSE_IDENTIFIER_DAY_CELL;
    FFGuestsTableViewCell *cell = (FFGuestsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    [cell initStyle];
    
    [cell setArray:[arrayWithAllContacts objectAtIndex:indexPath.row]];
    
    if (arrayWithSelectedItens != nil && [arrayWithSelectedItens containsObject:[arrayWithAllContacts objectAtIndex:indexPath.row]]) {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!arrayWithSelectedItens) {
        arrayWithSelectedItens = [NSMutableArray new];
    }
    
    [arrayWithSelectedItens addObject:[arrayWithAllContacts objectAtIndex:indexPath.row]];
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (arrayWithSelectedItens) {
        [arrayWithSelectedItens removeObject:[arrayWithAllContacts objectAtIndex:indexPath.row]];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
    }
}

#pragma mark - Set Method

- (void)setArrayWithSelectedItens:(NSMutableArray *)_arrayWithSelectedItens {
    
    arrayWithSelectedItens = [_arrayWithSelectedItens mutableCopy];
}

#pragma mark - Update ArrayWithAllContacts

- (void)updateArrayWithAllContacts {
    
    arrayWithAllContacts = @[@[@111, @"Guest 1", @"email1@mail.com"], @[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 3", @"email3@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 6", @"email6@email.com"], @[@111, @"Guest 7", @"email7@email.com"]];
}

@end
