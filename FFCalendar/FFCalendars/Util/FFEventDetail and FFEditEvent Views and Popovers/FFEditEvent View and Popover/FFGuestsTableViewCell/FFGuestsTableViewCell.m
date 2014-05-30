//
//  FFGuestsTableViewCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/28/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFGuestsTableViewCell.h"

@interface FFGuestsTableViewCell ()
@property (nonatomic, strong) UILabel *labelNome;
@property (nonatomic, strong) UILabel *labelEmail;
@end

@implementation FFGuestsTableViewCell

@synthesize array;
@synthesize labelNome;
@synthesize labelEmail;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initStyle {
    
    [self setAccessoryType:UITableViewCellAccessoryNone];
    
    if (!labelNome) {
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height/5.;
        
        labelNome = [[UILabel alloc] initWithFrame:CGRectMake(0., 5., width, 2.5*height-5)];
        [labelNome setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        //        [labelNome setBackgroundColor:[UIColor redColor]];
        [labelNome setTextAlignment:NSTextAlignmentCenter];
        [labelNome setFont:[UIFont systemFontOfSize:16.]];
        [self addSubview:labelNome];
        
        labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(0., 5+labelNome.frame.size.height, width, 2*height)];
        [labelEmail setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        //        [labelEmail setBackgroundColor:[UIColor blueColor]];
        [labelEmail setTextAlignment:NSTextAlignmentCenter];
        [labelEmail setFont:[UIFont systemFontOfSize:13.]];
        [self addSubview:labelEmail];
    }
    
    [labelNome setText:@""];
    [labelEmail setText:@""];
}

- (void)setArray:(NSArray *)_array {
    
    array = _array;
    
    [labelNome setText:[_array objectAtIndex:1]];
    [labelEmail setText:[_array objectAtIndex:2]];
}

@end
