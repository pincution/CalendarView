//
//  YJEventCalculator.m
//  CalendarView
//
//  Created by 杨 佳 on 13-1-30.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import "YJEventCalculator.h"
#import "YJCalendarEvent.h"
#import "YJCalendarEventItemView.h"

@implementation YJEventCalculator

-(void)initEventUseBlock:(NSMutableArray*)block{
    if ([block count]>0) {
        for (YJCalendarEvent* event in block) {
            [event addConflictItems:block];
            event.conflict = [block count];
        }
    }
}

-(void)addEventToBlockArray:(NSMutableArray*)blockList withEvent:(YJCalendarEvent*)event{
    [blockList addObject:event];
}

-(void)initBlocksArray:(NSMutableArray*)array withEvent:(YJCalendarEvent*)event{
    for (int i=event.startBlock; i<event.endBlock+1; i++) {
        NSMutableArray* blocks = [array objectAtIndex:i];
        [self addEventToBlockArray:blocks withEvent:event];
    }
}

-(BOOL)checkIntersection:(CGRect)rect1 rect2:(CGRect)rect2{
    CGRect result = CGRectIntersection(rect1, rect2);
    
    if (CGRectIsNull(result)) {
        return NO;
    }
    
    if (result.size.width<2 || result.size.height <2) {
        return NO;
    }
    
    return YES;
}


-(BOOL)checkRect:(CGRect)rect  conflictWithFrameArray:(NSMutableArray*)array{
    
    for (NSValue* rectValue in array) {
        CGRect rectItem = [rectValue CGRectValue];
        if ([self checkIntersection:rect rect2:rectItem]) {
            return YES;
        }
    }
   
    return NO;
}

-(void)addEvent:(YJCalendarEvent*)event withFrame:(CGRect)frame inArray:(NSMutableArray*)array{
    YJCalendarEventItemView* view =[[YJCalendarEventItemView alloc] initWithFrame:frame];
    
//    NSInteger r = rand()%255;
//    NSInteger g = rand()%255;
//    NSInteger b = rand()%255;
//    
//    view.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
    view.event = event;
    [array addObject:view];
}


-(NSMutableArray*)getViewsWithEventArray:(NSArray*) eventArray{
    
    // returned array
    NSMutableArray* viewArray = [[NSMutableArray alloc] initWithCapacity:[eventArray count]];
    
    
    // calculate the times
    NSMutableArray* blocksArray = [[NSMutableArray alloc] initWithCapacity:(self.totalBlock+10)];

    for (int i=0; i<self.totalBlock+10; i++) {
        NSMutableArray* arrayItem = [[NSMutableArray alloc] initWithCapacity:10];
        [blocksArray addObject:arrayItem];
    }
    
    // init the blocks array
    for (YJCalendarEvent* event in eventArray) {
        [self initBlocksArray:blocksArray withEvent:event];
    }
    
    // initEveryEvent
    for (NSMutableArray*block in blocksArray) {
        [self initEventUseBlock:block];
    }
        
    // init max conflict
    for (YJCalendarEvent* event in eventArray) {
        [event initMaxConflictItem];
    }

    // draw events
    NSMutableArray* framesArray = [[NSMutableArray alloc] initWithCapacity:[eventArray count]];
    
    BOOL bHasMoreButton = NO;
    
    YJCalendarEvent* moreEvent = nil;
    NSMutableArray* prevConflictItem = nil;
    
    for(int i=0; i<[eventArray count]; i++){
        CGRect eventFrame = CGRectMake(0, 0, 0, 0);
        YJCalendarEvent* event = [eventArray objectAtIndex:i];
        eventFrame.size.width = (self.viewSize.width -self.moreButtonWidth) /event.maxConflicts;
        if (eventFrame.size.width<self.eventMinWidth) {
            eventFrame.size.width = self.eventMinWidth;
        }
        eventFrame.size.height = (event.endBlock-event.startBlock+1)*self.blockMinHeight;
        
        eventFrame.origin.y = event.startBlock*self.blockMinHeight;

        // check conflicted
        BOOL outOfRect = NO;
        int j=0;
        for (j=0;j<self.maxRow+1; j++) {
            
            if (![self checkRect:eventFrame conflictWithFrameArray:framesArray]) {
                break;
            }
            else{
                eventFrame.origin.x += eventFrame.size.width;
            }
        }
        
        if (eventFrame.origin.x+eventFrame.size.width > self.viewSize.width) {
            outOfRect = YES;
        }
        
        
        if (outOfRect) {
            // show more button
            if (!bHasMoreButton) {
                bHasMoreButton = YES;
                moreEvent = event;
                eventFrame.origin.x = self.viewSize.width-self.moreButtonWidth;
                eventFrame.size.width = self.moreButtonWidth;

                prevConflictItem = event.maxConflictItems;
                
                event.isShowMore = YES;
                
                // add view to viewArray
                [self addEvent:event withFrame:eventFrame inArray:viewArray];
                [framesArray addObject:[NSValue valueWithCGRect:eventFrame]];
                
//                [event.moreButtonItems addObject:event];
                [event addMoreButtonItems:event];
            }
            else{
                // 不是和上面的一组的
                if (NSNotFound == [moreEvent.maxConflictItems indexOfObject:event]) {
                    bHasMoreButton = YES;
                    moreEvent = event;
                    eventFrame.origin.x = self.viewSize.width-self.moreButtonWidth;
                    eventFrame.size.width = self.moreButtonWidth;

                    prevConflictItem = event.maxConflictItems;
                    
                    event.isShowMore = YES;
                    
                    // add view to viewArray
                    [self addEvent:event withFrame:eventFrame inArray:viewArray];
                    [framesArray addObject:[NSValue valueWithCGRect:eventFrame]];
                    
                    [event addMoreButtonItems:event];
                }
                else{
                    [moreEvent addMoreButtonItems:event];
                }
            }
        }
        else{
            // add view to viewArray
            [self addEvent:event withFrame:eventFrame inArray:viewArray];
            [framesArray addObject:[NSValue valueWithCGRect:eventFrame]];
            prevConflictItem = event.maxConflictItems;
        }
        
    }

    return viewArray;
}

@end
