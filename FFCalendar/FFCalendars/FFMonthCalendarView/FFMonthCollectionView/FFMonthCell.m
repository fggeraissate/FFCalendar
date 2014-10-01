//
//  FFMonthCell.m
//  FFCalendar
//
//  Created by Felipe Rocha on 14/02/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFMonthCell.h"

#import "FFButtonWithEditAndDetailPopoversForMonthCell.h"
#import "FFImportantFilesForCalendar.h"

@interface FFMonthCell () <FFButtonWithEditAndDetailPopoversForMonthCellProtocol>
@property (nonatomic, strong) NSMutableArray *arrayButtons;
@end

@implementation FFMonthCell

#pragma mark - Synthesize

@synthesize protocol;
@synthesize arrayButtons;
@synthesize arrayEvents;
@synthesize labelDay;
@synthesize imageViewCircle;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

- (void)initLayout {
    
    if (!imageViewCircle) {
        imageViewCircle = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-32.-3., 3., 32., 32.)];
        [imageViewCircle setAutoresizingMask:AR_LEFT_BOTTOM];
        [self addSubview:imageViewCircle];
        
        labelDay = [[UILabel alloc] initWithFrame:CGRectMake((imageViewCircle.frame.size.width-20.)/2., (imageViewCircle.frame.size.height-20.)/2., 20., 20.)];
        [labelDay setAutoresizingMask:AR_LEFT_BOTTOM];
        [labelDay setTextAlignment:NSTextAlignmentCenter];
        [imageViewCircle addSubview:labelDay];
    }
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.labelDay setText:@""];
    [self.labelDay setTextColor:[UIColor blackColor]];
    [self.imageViewCircle setImage:nil];
    
    for (UIButton *button in arrayButtons) {
        [button removeFromSuperview];
    }
}

#pragma mark - Custom Layouts

- (void)markAsWeekend {
    
    [self setBackgroundColor:[UIColor lighterGrayCustom]];
    [self.labelDay setTextColor:[UIColor grayColor]];
}

- (void)markAsCurrentDay {
    
    [self.labelDay setTextColor:[UIColor whiteColor]];
    [self.imageViewCircle setImage:[UIImage imageNamed:@"redCircle"]];
}

#pragma mark - Showing Events

- (void)setArrayEvents:(NSMutableArray *)_array {
    
    arrayEvents = _array;
    arrayButtons = [NSMutableArray new];
    
    if ([arrayEvents count] > 0) {
        
        int maxNumOfButtons = 4;
        CGFloat yFirstButton = imageViewCircle.frame.origin.y+imageViewCircle.frame.size.height;
        CGFloat height = (self.frame.size.height-yFirstButton)/maxNumOfButtons;
        
        int buttonOfNumber = 0;
        for (int i = 0; i < [arrayEvents count] ; i++) {
            
            buttonOfNumber++;
            FFButtonWithEditAndDetailPopoversForMonthCell *button = [[FFButtonWithEditAndDetailPopoversForMonthCell alloc] initWithFrame:CGRectMake(0, yFirstButton+(buttonOfNumber-1)*height, self.frame.size.width, height)];
            [button setAutoresizingMask:AR_TOP_BOTTOM | UIViewAutoresizingFlexibleWidth];
            [self addSubview:button];
            [arrayButtons addObject:button];
            
            if ((buttonOfNumber == maxNumOfButtons) && ([arrayEvents count] - maxNumOfButtons > 0)) {
                [button setTitle:[NSString stringWithFormat:@"%lu more...", (long)[arrayEvents count] - maxNumOfButtons] forState:UIControlStateNormal];
                break;
            } else {
                FFEvent *event = [arrayEvents objectAtIndex:i];
                [button setTitle:event.stringCustomerName forState:UIControlStateNormal];
                [button setEvent:event];
                [button setProtocol:self];
            }
        }
    }
}

#pragma mark - FFButtonWithEditAndDetailPopoversForMonthCell Protocol

- (void)saveEditedEvent:(FFEvent *)eventNew ofButton:(UIButton *)button {
    
    long i = [arrayButtons indexOfObject:button];
    
    if (protocol != nil && [protocol respondsToSelector:@selector(saveEditedEvent:ofCell:atIndex:)]) {
        [protocol saveEditedEvent:eventNew ofCell:self atIndex:i];
    }
}

- (void)deleteEventOfButton:(UIButton *)button {
    
    long i = [arrayButtons indexOfObject:button];
    
    if (protocol != nil && [protocol respondsToSelector:@selector(deleteEventOfCell:atIndex:)]) {
        [protocol deleteEventOfCell:self atIndex:i];
    }
}

@end
