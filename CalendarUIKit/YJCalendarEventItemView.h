//
//  YJCalendarEventItem.h
//  CalendarView
//
//  Created by 杨 佳 on 13-1-30.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCalendarEvent.h"

@interface YJCalendarEventItemView : UIControl

@property(nonatomic,retain) YJCalendarEvent* event;
@property(nonatomic,assign) float fontSize;
@property(nonatomic, retain) UILabel* Label;

@end
