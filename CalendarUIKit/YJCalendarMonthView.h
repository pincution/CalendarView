//
//  YJCalendarMonthView.h
//  CalendarView
//
//  Created by 杨 佳 on 13-1-31.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCalendarEvent.h"

@protocol YJCalendarMonthViewDataSource <NSObject>
@required
-(NSArray*)eventsArray;
-(NSString*)cellTitleForX:(NSInteger)x y:(NSInteger)y;
@optional

-(BOOL)rowIsWeekend:(NSInteger)row;

@end

@protocol YJCalendarMonthViewDelegate <NSObject>
-(void)clickEvent:(YJCalendarEvent*)event;
@end


@interface YJCalendarMonthView : UIView

@property (nonatomic, retain) UIColor* textColor;
@property (nonatomic, retain) UIColor* lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, retain) UIColor* workDayColor;
@property (nonatomic, retain) UIColor* weekendDayColor;
@property (nonatomic, assign) UIColor* rightPadding;
@property (nonatomic, assign) IBOutlet id<YJCalendarMonthViewDataSource> dataSource;
@property (nonatomic, assign) IBOutlet id<YJCalendarMonthViewDelegate> delegate;
@property (nonatomic, assign) CGFloat  itemHeight;
@property (nonatomic, assign) CGFloat  titleFontSize;

@property (nonatomic, assign) CGFloat itemWidthPadding;
@property (nonatomic, assign) CGFloat itemHeightPadding;

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, assign) NSInteger maxRow;

@end
