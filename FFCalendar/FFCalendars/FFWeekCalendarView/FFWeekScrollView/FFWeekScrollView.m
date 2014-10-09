//
//  FFWeekScrollView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/21/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFWeekScrollView.h"

#import "FFViewWithHourLines.h"
#import "FFImportantFilesForCalendar.h"

@interface FFWeekScrollView () <UIScrollViewDelegate>
@property (nonatomic, strong) FFViewWithHourLines *viewWithHourLines;
@end

@implementation FFWeekScrollView

#pragma mark - Synthesize

@synthesize dictEvents;
@synthesize labelWithActualHour;
@synthesize labelGrayWithActualHour;
@synthesize viewWithHourLines;
@synthesize collectionViewWeek;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setAutoresizingMask:AR_WIDTH_HEIGHT];
    }
    return self;
}

- (void)setDictEvents:(NSMutableDictionary *)_dictEvents {
    
    dictEvents = _dictEvents;
    
    if (!viewWithHourLines) {
        
        viewWithHourLines = [[FFViewWithHourLines alloc] initWithFrame:CGRectMake(0, 0, 80., self.frame.size.height)];
        [self addSubview:viewWithHourLines];
        
        collectionViewWeek = [[FFWeekCollectionView alloc] initWithFrame:CGRectMake(viewWithHourLines.frame.size.width,viewWithHourLines.frame.origin.y,self.frame.size.width-viewWithHourLines.frame.size.width,viewWithHourLines.totalHeight+HEIGHT_CELL_HOUR)collectionViewLayout:[UICollectionViewFlowLayout new]];
        [self scrollToPage:(int)[NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]].weekOfMonth+1];
        [self addSubview:collectionViewWeek];
        
        labelWithActualHour = [viewWithHourLines labelWithCurrentHourWithWidth:self.frame.size.width];
        [labelWithActualHour setFrame:CGRectMake(labelWithActualHour.frame.origin.x, labelWithActualHour.frame.origin.y+viewWithHourLines.frame.origin.y, labelWithActualHour.frame.size.width, labelWithActualHour.frame.size.height)];
        [self addSubview:labelWithActualHour];
        labelGrayWithActualHour = viewWithHourLines.labelWithSameYOfCurrentHour;
        [labelGrayWithActualHour setAlpha:0.];
        
        [self setContentSize:CGSizeMake(self.frame.size.width, collectionViewWeek.frame.origin.y+collectionViewWeek.frame.size.height-HEIGHT_CELL_HOUR)];
        [self scrollRectToVisible:CGRectMake(0., labelWithActualHour.frame.origin.y, self.frame.size.width, self.frame.size.height) animated:YES];
    }
    
    [collectionViewWeek setDictEvents:dictEvents];
    [collectionViewWeek reloadData];
}

- (void)showlabelsWithActualHourWithAlpha:(BOOL)show {
    
    [viewWithHourLines reloadLabelRedAndShow:show];
    
    [labelWithActualHour setFrame:CGRectMake(labelWithActualHour.frame.origin.x, labelWithActualHour.frame.origin.y+viewWithHourLines.frame.origin.y, labelWithActualHour.frame.size.width, labelWithActualHour.frame.size.height)];
    
    labelGrayWithActualHour = viewWithHourLines.labelWithSameYOfCurrentHour;
    
    if (show) {
        [self scrollRectToVisible:CGRectMake(self.frame.origin.x, labelWithActualHour.frame.origin.y, self.frame.size.width, self.frame.size.height) animated:YES];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)scrollToPage:(int)_intPage {
//    NSInteger intIndex = 7*_intPage-1;
//    [collectionViewWeek scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:intIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    [collectionViewWeek setContentOffset:CGPointMake((_intPage-1)*collectionViewWeek.frame.size.width, 0.)];
}

@end
