//
//  FFDayCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/23/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFDayCell.h"

#import "FFHourAndMinLabel.h"
#import "FFBlueButton.h"
#import "FFImportantFilesForCalendar.h"

@interface FFDayCell ()
@property (nonatomic, strong) NSMutableArray *arrayLabelsHourAndMin;
@property (nonatomic, strong) NSMutableArray *arrayButtonsEvents;
@property (nonatomic, strong) FFBlueButton *button;
@property (nonatomic) CGFloat yCurrent;
@property (nonatomic, strong) UILabel *labelWithSameYOfCurrentHour;
@property (nonatomic, strong) UILabel *labelRed;
@end

@implementation FFDayCell

@synthesize protocol;
@synthesize date;
@synthesize arrayLabelsHourAndMin;
@synthesize arrayButtonsEvents;
@synthesize button;
@synthesize yCurrent;
@synthesize labelWithSameYOfCurrentHour;
@synthesize labelRed;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        arrayLabelsHourAndMin = [NSMutableArray new];
        arrayButtonsEvents = [NSMutableArray new];
        
        [self addLines];
    }
    return self;
}

- (void)showEvents:(NSArray *)array {
    
    [self addButtonsWithArray:array];
}

- (void)addLines {
    
    CGFloat y = 0;
    
    NSDateComponents *compNow = [NSDate componentsOfCurrentDate];
    
    for (int hour=0; hour<=23; hour++) {
        
        for (int min=0; min<=45; min=min+MINUTES_PER_LABEL) {
            
            FFHourAndMinLabel *labelHourMin = [[FFHourAndMinLabel alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, HEIGHT_CELL_MIN) date:[NSDate dateWithHour:hour min:min]];
            [labelHourMin setTextColor:[UIColor grayColor]];
            if (min == 0) {
                [labelHourMin showText];
                CGFloat width = [labelHourMin widthThatWouldFit];
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(labelHourMin.frame.origin.x+width+10, HEIGHT_CELL_MIN/2., self.frame.size.width-labelHourMin.frame.origin.x-width-20, 1.)];
                [view setAutoresizingMask:AR_WIDTH_HEIGHT];
                [view setBackgroundColor:[UIColor lightGrayCustom]];
                [labelHourMin addSubview:view];
            }
            [self addSubview:labelHourMin];
            [arrayLabelsHourAndMin addObject:labelHourMin];
            
            NSDateComponents *compLabel = [NSDate componentsWithHour:hour min:min];
            if (compLabel.hour == compNow.hour && min <= compNow.minute && compNow.minute < min+MINUTES_PER_LABEL) {
                labelRed = [self labelWithCurrentHourWithWidth:labelHourMin.frame.size.width yCurrent:labelHourMin.frame.origin.y];
                [self addSubview:labelRed];
                [labelRed setAlpha:0];
                labelWithSameYOfCurrentHour = labelHourMin;
            }
            
            y += HEIGHT_CELL_MIN;
        }
    }
}

- (void)addButtonsWithArray:(NSArray *)arrayEvents {
    
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[FFBlueButton class]]) {
            [subview removeFromSuperview];
        }
    }
    [arrayButtonsEvents removeAllObjects];
    
    [self reloadLabelRed];
    
    if (arrayEvents) {
        
        NSMutableArray *arrayFrames = [NSMutableArray new];
        NSMutableDictionary *dictButtonsWithSameFrame = [NSMutableDictionary new];
        
        for (FFEvent *event in arrayEvents) {
            
            CGFloat yTimeBegin;
            CGFloat yTimeEnd;
            
            for (FFHourAndMinLabel *label in arrayLabelsHourAndMin) {
                NSDateComponents *compLabel = [NSDate componentsOfDate:label.dateHourAndMin];
                NSDateComponents *compEventBegin = [NSDate componentsOfDate:event.dateTimeBegin];
                NSDateComponents *compEventEnd = [NSDate componentsOfDate:event.dateTimeEnd];
                
                if (compLabel.hour == compEventBegin.hour && compLabel.minute <= compEventBegin.minute && compEventBegin.minute < compLabel.minute+MINUTES_PER_LABEL) {
                    yTimeBegin = label.frame.origin.y+label.frame.size.height/2.;
                }
                if (compLabel.hour == compEventEnd.hour && compLabel.minute <= compEventEnd.minute && compEventEnd.minute < compLabel.minute+MINUTES_PER_LABEL) {
                    yTimeEnd = label.frame.origin.y+label.frame.size.height;
                }
            }
            
            FFBlueButton *_button = [[FFBlueButton alloc] initWithFrame:CGRectMake(70., yTimeBegin, self.frame.size.width-95., yTimeEnd-yTimeBegin)];
            [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_button setTitle:event.stringCustomerName forState:UIControlStateNormal];
            [_button setEvent:event];
            
            [arrayButtonsEvents addObject:_button];
            [self addSubview:_button];
            
            
            // Save Frames for next step
            NSValue *value = [NSValue valueWithCGRect:_button.frame];
            if ([arrayFrames containsObject:value]) {
                NSMutableArray *array = [dictButtonsWithSameFrame objectForKey:value];
                if (!array){
                    array = [[NSMutableArray alloc] initWithObjects:[arrayButtonsEvents objectAtIndex:[arrayFrames indexOfObject:value]], nil];

                }
                [array addObject:_button];
                [dictButtonsWithSameFrame setObject:array forKey:value];
            }
            [arrayFrames addObject:value];
        }
        
        // Recaulate frames of buttons that have the same begin and end date
        for (NSValue *value in dictButtonsWithSameFrame) {
            NSArray *array = [dictButtonsWithSameFrame objectForKey:value];
            CGFloat width = (self.frame.size.width-95.)/array.count;
            for (int i = 0; i < array.count; i++) {
                UIButton *buttonInsideArray = [array objectAtIndex:i];
                [buttonInsideArray setFrame:CGRectMake(70+i*width, buttonInsideArray.frame.origin.y, width, buttonInsideArray.frame.size.height)];
            }
        }
    }
}

- (void)reloadLabelRed {
    
    [labelWithSameYOfCurrentHour setAlpha:1];
    
    NSDateComponents *compNow = [NSDate componentsOfCurrentDate];
    BOOL boolIsToday = [NSDate isTheSameDateTheCompA:[NSDate componentsOfCurrentDate] compB:[NSDate componentsOfDate:date]];
    
    if (boolIsToday) {
        
        for (FFHourAndMinLabel *label in arrayLabelsHourAndMin) {
            NSDateComponents *compLabel = [NSDate componentsOfDate:label.dateHourAndMin];
            
            if (compLabel.hour == compNow.hour && compLabel.minute <= compNow.minute && compNow.minute < compLabel.minute+MINUTES_PER_LABEL) {
                CGRect frame = labelRed.frame;
                frame.origin.y = label.frame.origin.y;
                [labelRed setFrame:frame];
                [(FFHourAndMinLabel *)labelRed setDateHourAndMin:[NSDate date]];
                [(FFHourAndMinLabel *)labelRed showText];
                
                labelWithSameYOfCurrentHour = label;
                break;
            }
        }
    }
    
    [labelRed setAlpha:boolIsToday];
    [labelWithSameYOfCurrentHour setAlpha:!boolIsToday];
}

- (UILabel *)labelWithCurrentHourWithWidth:(CGFloat)_width yCurrent:(CGFloat)_yCurrent {
    
    FFHourAndMinLabel *label = [[FFHourAndMinLabel alloc] initWithFrame:CGRectMake(.0, _yCurrent, _width, HEIGHT_CELL_MIN) date:[NSDate date]];
    [label showText];
    [label setTextColor:[UIColor redColor]];
    CGFloat width = [label widthThatWouldFit];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(label.frame.origin.x+width+10., HEIGHT_CELL_MIN/2., _width-label.frame.origin.x-width-20., 1.)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [view setBackgroundColor:[UIColor redColor]];
    [label addSubview:view];
    
    return label;
}

#pragma mark - Button Action

- (IBAction)buttonAction:(id)sender {
    
    button = (FFBlueButton *)sender;
    
    if (protocol != nil && [protocol respondsToSelector:@selector(showViewDetailsWithEvent:cell:)]) {
        [protocol showViewDetailsWithEvent:button.event cell:self];
    }
}

//#pragma mark - FFEventDetailPopoverController Protocol
//
//- (void)showPopoverEditWithEvent:(Event *)_event {
//    
//    popoverControllerEditar = [[FFEditEventPopoverController alloc] initWithEvent:_event];
//    [popoverControllerEditar setProtocol:self];
//    
//    [popoverControllerEditar presentPopoverFromRect:button.frame
//                                             inView:self
//                           permittedArrowDirections:UIPopoverArrowDirectionAny
//                                           animated:YES];
//}
//
//#pragma mark - FFEditEventPopoverController Protocol
//
//- (void)saveEditedEvent:(Event *)eventNew {
//    
//    if (protocol != nil && [protocol respondsToSelector:@selector(saveEditedEvent:ofCell:atIndex:)]) {
//        [protocol saveEditedEvent:eventNew ofCell:self atIndex:[arrayButtonsEvents indexOfObject:button]];
//    }
//}
//
//- (void)deleteEvent {
//
//    if (protocol != nil && [protocol respondsToSelector:@selector(deleteEventOfCell:atIndex:)]) {
//        [protocol deleteEventOfCell:self atIndex:[arrayButtonsEvents indexOfObject:button]];
//    }
//}

@end
