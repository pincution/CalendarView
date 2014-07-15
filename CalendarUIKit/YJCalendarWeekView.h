//
//  YJCalendarWeekView.h
//  CalendarView
//
//  Created by 杨 佳 on 13-1-31.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCalendarDayView.h"

@protocol YJCalendarWeekViewDataSource <NSObject>
@required
-(NSArray*)eventsArray;
-(NSArray*)lineWidthArray;

@optional

@end

@protocol YJCalendarWeekViewDelegate <NSObject>
-(void)clickEvent:(YJCalendarEvent*)event;
@end

@interface YJCalendarWeekView : UIView

@property (nonatomic, assign, readonly) double oneBlockHeight;

@property (nonatomic, assign) YJEventBlockMiniumMinitus minitumMinitus;

@property (nonatomic, assign) IBOutlet id<YJCalendarWeekViewDataSource> dataSource;
@property (nonatomic, assign) IBOutlet id<YJCalendarWeekViewDelegate> delegate;

@property (nonatomic, retain) UIColor* textColor;
@property (nonatomic, retain) UIColor* lineColor;

@property (nonatomic, assign) CGFloat linePadding;
@property (nonatomic, assign) CGFloat lineAlpha;

@property (nonatomic, assign) NSInteger maxRow;

@property (nonatomic, assign) CGFloat moreEventWidth;

@property (nonatomic, assign) NSInteger numberofDays;

@property (nonatomic, assign) CGFloat itemWidthPadding;
@property (nonatomic, assign) CGFloat itemHeightPadding;


@end
