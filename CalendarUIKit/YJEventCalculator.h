//
//  YJEventCalculator.h
//  CalendarView
//
//  Created by 杨 佳 on 13-1-30.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJEventCalculator : NSObject

@property(nonatomic, assign) CGSize viewSize;
@property(nonatomic, assign) NSInteger maxRow;

@property(nonatomic, assign) CGFloat eventMinWidth;
@property(nonatomic, assign) CGFloat blockMinHeight;

@property(nonatomic, assign) CGFloat moreButtonWidth;
@property(nonatomic, assign) NSInteger totalBlock;


-(NSMutableArray*)getViewsWithEventArray:(NSArray*) eventArray;

@end
