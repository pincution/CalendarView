//
//  YJCalendarWeekScrollView.h
//  CalendarView
//
//  Created by 杨 佳 on 13-2-1.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCalendarWeekView.h"

@protocol YJCalendarWeekScrollViewDelegate <NSObject>

@required
-(NSArray*)eventsArray;
-(NSArray*)lineWidthArray;
-(void)clickEvent:(YJCalendarEvent*)event;
-(NSString*)titleStringOfDay:(NSInteger)day;

@end

@interface YJCalendarWeekScrollView : UIView<YJCalendarWeekViewDataSource, YJCalendarWeekViewDelegate>

@property (nonatomic, assign) CGFloat topTextHeight;


@property (nonatomic, retain) YJCalendarWeekView* weekView;
@property (nonatomic, assign) id<YJCalendarWeekScrollViewDelegate> delegate;
@property (nonatomic, retain) UIColor* titleColor;


@property (nonatomic, assign) CGSize weekViewSize;

@end
