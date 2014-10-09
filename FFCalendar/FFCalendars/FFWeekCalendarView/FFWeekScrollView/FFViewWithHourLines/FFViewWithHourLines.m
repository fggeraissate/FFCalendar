//
//  FFViewWithHourLines.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/21/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFViewWithHourLines.h"

#import "FFHourAndMinLabel.h"
#import "FFImportantFilesForCalendar.h"

@interface FFViewWithHourLines ()
@property (nonatomic, strong) NSMutableArray *arrayLabelsHourAndMin;
@property (nonatomic, strong) FFHourAndMinLabel *labelRed;
@property (nonatomic) CGFloat yCurrent;
@end

@implementation FFViewWithHourLines

#pragma mark - Synthesize

@synthesize arrayLabelsHourAndMin;
@synthesize yCurrent;
@synthesize totalHeight;
@synthesize labelWithSameYOfCurrentHour;
@synthesize labelRed;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setAutoresizingMask:AR_WIDTH_HEIGHT];
        
        arrayLabelsHourAndMin = [NSMutableArray new];
        
        CGFloat y = 0;
        
        NSDateComponents *compNow = [NSDate componentsOfCurrentDate];
        
        for (int hour=0; hour<=23; hour++) {
            
            for (int min=0; min<=45; min=min+MINUTES_PER_LABEL) {
                
                FFHourAndMinLabel *labelHourMin = [[FFHourAndMinLabel alloc] initWithFrame:CGRectMake(10, y, self.frame.size.width-10, HEIGHT_CELL_MIN) date:[NSDate dateWithHour:hour min:min]];
                [labelHourMin setTextColor:[UIColor grayColor]];
                if (min == 0) {
                    [labelHourMin showText];
                    CGFloat width = [labelHourMin widthThatWouldFit];
                    
                    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(labelHourMin.frame.origin.x+width, HEIGHT_CELL_MIN/2., self.frame.size.width-labelHourMin.frame.origin.x-width, 1.)];
                    [view setBackgroundColor:[UIColor lightGrayCustom]];
                    [labelHourMin addSubview:view];
                }
                [self addSubview:labelHourMin];
                [arrayLabelsHourAndMin addObject:labelHourMin];
                
                NSDateComponents *compLabel = [NSDate componentsWithHour:hour min:min];
                if (compLabel.hour == compNow.hour && min <= compNow.minute && compNow.minute < min+MINUTES_PER_LABEL) {
                    yCurrent = y;
                    [labelHourMin setAlpha:0];
                    labelWithSameYOfCurrentHour = labelHourMin;
                }
                
                y += HEIGHT_CELL_MIN;
            }
        }
        
        totalHeight = y;
    }
    return self;
}

- (void)reloadLabelRedAndShow:(BOOL)show {
    
    [labelWithSameYOfCurrentHour setAlpha:1];
    
    NSDateComponents *compNow = [NSDate componentsOfCurrentDate];

    if (show) {

        for (FFHourAndMinLabel *label in arrayLabelsHourAndMin) {
            NSDateComponents *compLabel = [NSDate componentsOfDate:label.dateHourAndMin];

            if (compLabel.hour == compNow.hour && compLabel.minute <= compNow.minute && compNow.minute < compLabel.minute+MINUTES_PER_LABEL) {
                CGRect frame = labelRed.frame;
                frame.origin.y = label.frame.origin.y;
                [labelRed setFrame:frame];
                [(FFHourAndMinLabel *)labelRed setDateHourAndMin:[NSDate date]];
                [(FFHourAndMinLabel *)labelRed showText];

                labelWithSameYOfCurrentHour = label;
                
                yCurrent = label.frame.origin.y;
                
                break;
            }
        }
    }

    [labelRed setAlpha:show];
    [labelWithSameYOfCurrentHour setAlpha:!show];
}


- (UILabel *)labelWithCurrentHourWithWidth:(CGFloat)_width {
    
    labelRed = [[FFHourAndMinLabel alloc] initWithFrame:CGRectMake(10, yCurrent, _width-10, HEIGHT_CELL_MIN) date:[NSDate date]];
    [labelRed setTextColor:[UIColor redColor]];
    [labelRed showText];
    
    CGFloat width = [labelRed widthThatWouldFit];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(labelRed.frame.origin.x+width, HEIGHT_CELL_MIN/2., _width-labelRed.frame.origin.x-width, 1.)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [view setBackgroundColor:[UIColor redColor]];
    [labelRed addSubview:view];
    
    return labelRed;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
