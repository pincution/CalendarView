//
//  YJCalendarMonthView.m
//  CalendarView
//
//  Created by 杨 佳 on 13-1-31.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import "YJCalendarMonthView.h"
#import "YJCalendarEventItemView.h"

#define DEFAULT_WEEKEND_DAY0 0
#define DEFAULT_WEEKEND_DAY1 1
#define DEFAULT_MAX_ROW 3
#define DEFAULT_LINEWIDTH 0.5f
#define DEFAULT_ITEM_WIDTHPADDING 2.0f
#define DEFAULT_ITEM_HEIGHTPADDING 2.0f
#define MAX_COL 6
#define MAX_ROL 7

static NSInteger cellWhiteBoard[MAX_ROL][MAX_COL]= {0};
static id eventWhiteBoard[MAX_ROL][MAX_COL] = {0};

@interface YJCalendarMonthView ()
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat cellheight;


@property (nonatomic, retain) UIView* gridView;

@end

@implementation YJCalendarMonthView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    // Initialization code
    self.backgroundColor = [UIColor blueColor];
    self.row = 6;
    self.cellheight = self.frame.size.height/self.row;
    self.cellWidth = self.frame.size.width/MAX_ROL;
    self.lineColor = [UIColor blackColor];
    self.lineWidth = DEFAULT_LINEWIDTH;
    self.workDayColor = [UIColor whiteColor];
    self.weekendDayColor = [UIColor lightGrayColor];
    self.maxRow = DEFAULT_MAX_ROW;
    self.gridView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.textColor = [UIColor blackColor];
    self.titleFontSize = 10.0f;
    
    self.itemWidthPadding = DEFAULT_ITEM_WIDTHPADDING;
    self.itemHeightPadding = DEFAULT_ITEM_HEIGHTPADDING;
    
    [self addSubview:self.gridView];
}

-(CGFloat)cellheight{
    return self.frame.size.height/self.row;
}

-(CGFloat)itemHeight{
    return (self.cellheight-self.titleFontSize)/self.maxRow;
}

-(CGPoint)getPointWithRow:(NSInteger)row col:(NSInteger)col cellNumber:(NSInteger)number{
    CGFloat x = row*self.cellWidth;
    CGFloat y = col*self.cellheight + number*self.itemHeight + self.titleFontSize;
    
    return CGPointMake(x, y);
}

-(void)clickEvent:(YJCalendarEventItemView*)view
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickEvent:)]) {
        if (view.event.isShowMore) {
            [self.delegate clickEvent:eventWhiteBoard[view.event.monthX][view.event.monthY]];
        }
        else{
            [self.delegate clickEvent:view.event];
        }
    }
}


-(void)layoutSubviews{
    
    UIView* destView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    //layout title
    for (int row=0; row<MAX_ROL; row++) {
        for (int col =0; col<self.row; col++) {
            cellWhiteBoard[row][col] = 0;
            eventWhiteBoard[row][col] = nil;
            CGRect rect = CGRectZero;
            rect.origin.x = self.cellWidth*row;
            rect.origin.y = self.cellheight*col;
            rect.size.width = self.cellWidth;
            rect.size.height = self.titleFontSize;
            
            UILabel* titleView= [[UILabel alloc] initWithFrame:rect];
            NSString* title = @"title";
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(cellTitleForX:y:)]) {
                title = [self.dataSource cellTitleForX:row y:col];
            }
            titleView.text = title;
            titleView.textAlignment = UITextAlignmentCenter;
            titleView.backgroundColor = [UIColor clearColor];
            titleView.font = [UIFont systemFontOfSize:self.titleFontSize];
            [destView addSubview:titleView];
        }
    }
    
    NSArray* daysArray = nil;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(eventsArray)]) {
        daysArray = [self.dataSource eventsArray];
    }
    
    // draw event item
    if (daysArray && [daysArray count] >0) {
        for(int i=0; i<[daysArray count]; i++){
            YJCalendarEvent* event = [daysArray objectAtIndex:i];
            // show item
            if(cellWhiteBoard[event.monthX][event.monthY]<self.maxRow-1)
            {
                CGPoint point = [self getPointWithRow:event.monthX col:event.monthY cellNumber:cellWhiteBoard[event.monthX][event.monthY]];
                CGSize size = CGSizeMake(self.cellWidth, self.itemHeight);
                
                CGRect rect = CGRectZero;
                rect.origin = point;
                rect.size = size;
                
                rect.origin.x +=self.itemWidthPadding;
                rect.origin.y +=self.itemHeightPadding;
                rect.size.height -=self.itemHeightPadding*2;
                rect.size.width -=self.itemWidthPadding*2;
                
                YJCalendarEventItemView* itemView = [[YJCalendarEventItemView alloc] initWithFrame:rect];
                [itemView addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
                itemView.event = event;
                [destView addSubview:itemView];
                
            }
            else if(cellWhiteBoard[event.monthX][event.monthY] == self.maxRow-1)
            {
                CGPoint point = [self getPointWithRow:event.monthX col:event.monthY cellNumber:self.maxRow-1];
                CGSize size = CGSizeMake(self.cellWidth, self.itemHeight);
                
                CGRect rect = CGRectZero;
                rect.origin = point;
                rect.size = size;
                
                rect.origin.x +=self.itemWidthPadding;
                rect.origin.y +=self.itemHeightPadding;
                rect.size.height -=self.itemHeightPadding*2;
                rect.size.width -=self.itemWidthPadding*2;
                
                YJCalendarEventItemView* itemView = [[YJCalendarEventItemView alloc] initWithFrame:rect];
                [itemView addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
                itemView.event = event;
                [destView addSubview:itemView];
                eventWhiteBoard[event.monthX][event.monthY] = event;
                [event addMoreButtonItems:event];
            }
            else if(cellWhiteBoard[event.monthX][event.monthY]==self.maxRow){
                CGPoint point = [self getPointWithRow:event.monthX col:event.monthY cellNumber:self.maxRow-1];
                CGSize size = CGSizeMake(self.cellWidth, self.itemHeight);
                
                CGRect rect = CGRectZero;
                rect.origin = point;
                rect.size = size;
                
                rect.origin.x +=self.itemWidthPadding;
                rect.origin.y +=self.itemHeightPadding;
                rect.size.height -=self.itemHeightPadding*2;
                rect.size.width -=self.itemWidthPadding*2;
                
                YJCalendarEventItemView* itemView = [[YJCalendarEventItemView alloc] initWithFrame:rect];
                [itemView addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
                event.titleString = @"...........";
                itemView.event = event;
                [destView addSubview:itemView];
                event.isShowMore = YES;
                
                if (eventWhiteBoard[event.monthX][event.monthY]) {
                    [eventWhiteBoard[event.monthX][event.monthY] addMoreButtonItems:event];
                    [eventWhiteBoard[event.monthX][event.monthY] setIsShowMore:YES];
                }
                
            }
            
            cellWhiteBoard[event.monthX][event.monthY]++;
        }

    }
           
    if(self.gridView)
    {
        [self.gridView removeFromSuperview];
        self.gridView = nil;
        self.gridView = destView;
        [self addSubview:self.gridView];
    }
}

-(CGColorRef)cellBgcolor:(NSInteger)row{
    BOOL bWeekend = NO;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(rowIsWeekend:)]) {
        bWeekend = [self.dataSource rowIsWeekend:row];
    }else{
        if (row == DEFAULT_WEEKEND_DAY0 || row ==DEFAULT_WEEKEND_DAY1) {
            bWeekend = YES;
        }
    }
    
    if (bWeekend) {
        return [self.weekendDayColor CGColor];
    }
    else{
        return [self.workDayColor CGColor];
    }
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [self.lineColor CGColor]);
    for (int row=0; row<MAX_ROL; row++) {
        for (int col =0; col<self.row; col++) {
            
            CGContextBeginPath(context);

            CGRect rect = CGRectMake(row*self.cellWidth, col*self.cellheight, self.cellWidth, self.cellheight);
            
            CGContextSetFillColorWithColor(context, [self cellBgcolor:row] );
            CGContextFillRect(context, rect);
            CGContextSetLineWidth(context, 1.0);
            CGContextAddRect(context, rect);
            
            CGContextClosePath(context);
            CGContextSaveGState(context);
            CGContextDrawPath(context, kCGPathFillStroke);
            CGContextRestoreGState(context);
        }
    }

    
    [super drawRect:rect];
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
