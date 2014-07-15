//
//  YJCalendarDayView.h
//  CalendarView
//
//  Created by 杨 佳 on 13-1-30.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCalendarEvent.h"

typedef NS_ENUM(NSInteger, YJEventBlockMiniumMinitus) {
    YJEventBlockMiniumMinitusOneHour,
    YJEventBlockMiniumMinitusHalfHour,
    YJEventBlockMiniumMinitusOneFifteenMinitus,
    YJEventBlockMiniumMinitusOneMiniuts
};


@protocol YJCalendarDayViewDataSource <NSObject>
@required
-(NSArray*)eventsArray;
-(NSArray*)lineWidthArray;
@optional

@end

@protocol YJCalendarDayViewDelegate <NSObject>
-(void)clickEvent:(YJCalendarEvent*)event;
@end



@interface YJCalendarDayView : UIView

@property (nonatomic, assign, readonly) double oneBlockHeight;

@property (nonatomic, assign) YJEventBlockMiniumMinitus minitumMinitus;

@property (nonatomic, assign) IBOutlet id<YJCalendarDayViewDataSource> dataSource;
@property (nonatomic, assign) IBOutlet id<YJCalendarDayViewDelegate> delegate;

@property (nonatomic, retain) UIColor* textColor;
@property (nonatomic, retain) UIColor* lineColor;

@property (nonatomic, assign) CGFloat linePadding;
@property (nonatomic, assign) CGFloat lineAlpha;

@property (nonatomic, assign) NSInteger maxRow;

@property (nonatomic, assign) CGFloat moreEventWidth;

@end
