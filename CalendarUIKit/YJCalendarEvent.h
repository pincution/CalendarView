//
//  YJCalendarEvent.h
//  CalendarView
//
//  Created by 杨 佳 on 13-1-30.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJCalendarEvent : NSObject


@property (nonatomic, retain) NSString* titleString;


@property (nonatomic, assign) BOOL allDayEvent;
@property (nonatomic, assign) NSInteger monthX;
@property (nonatomic, assign) NSInteger monthY;

@property (nonatomic, assign) NSInteger startBlock;
@property (nonatomic, assign) NSInteger endBlock;

@property (nonatomic, assign) BOOL calculated;

@property (nonatomic, assign) NSInteger maxConflicts;

@property (nonatomic, retain) NSMutableArray* conflictItems;
@property (nonatomic, retain) NSMutableArray* maxConflictItems;
@property (nonatomic, retain) NSMutableArray* moreButtonItems;

@property (nonatomic, assign) BOOL isShowMore;

@property (nonatomic, assign) NSInteger conflict;

@property (nonatomic, assign) UIColor* bgColor;

@property (nonatomic, assign) id event;



-(void)addConflictItems:(NSMutableArray*)array;
-(void)addMoreButtonItems:(YJCalendarEvent *)item;
-(void)initMaxConflictItem;

@end
