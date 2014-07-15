//
//  YJCalendarEvent.m
//  CalendarView
//
//  Created by 杨 佳 on 13-1-30.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import "YJCalendarEvent.h"

@implementation YJCalendarEvent

-(id)init{
    self =[super init];
    if (self) {
        self.conflictItems = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

-(NSMutableArray*)conflictItems{
    if (_conflictItems == nil) {
        _conflictItems = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _conflictItems;
}

-(NSMutableArray*)moreButtonItems{
    if (_moreButtonItems == nil) {
        _moreButtonItems = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _moreButtonItems;
}


-(void)addMoreButtonItems:(YJCalendarEvent *)item{
        // not in conflict add it
        if(NSNotFound ==[self.moreButtonItems indexOfObject:item]) {
                [self.moreButtonItems addObject:item];
        }
}


-(void)addConflictItems:(NSMutableArray *)array{
    for (YJCalendarEvent* item in array) {
        // not in conflict add it
        if (item!=self){
            if(NSNotFound ==[self.conflictItems indexOfObject:item]) {
                [self.conflictItems addObject:item];
            }
        }
    }
}



-(void)addmaxConflictItems:(YJCalendarEvent*)event inWhiteBoard:(NSMutableArray*)array{
    
    if (event.calculated) {
        return;
    }
    
    // first add the event to the whiteboard
    if (NSNotFound == [array indexOfObject:event]) {
        [array addObject:event];
        event.calculated = YES;
    }
    else{
        return;
    }

    // check it conflictItem in the whiteboard
    if ([event.conflictItems count]>0) {
        for (YJCalendarEvent* item in event.conflictItems) {
            [self addmaxConflictItems:item inWhiteBoard:array];
        }
    }
}

-(NSInteger)getMaxConflictItemInArray:(NSArray*)maxConflictItems{
    int max = 0;
    for (YJCalendarEvent* event in maxConflictItems) {
        if (max<event.conflict) {
            max=event.conflict;
        }
    }
    
    return max;
}

-(void)setConflict:(NSInteger)conflict{
    if (_conflict<conflict) {
        _conflict = conflict;
    }
}

-(void)initMaxConflictItem{
    
    if (self.calculated) {
        return;
    }

    self.maxConflictItems = [[NSMutableArray alloc] initWithCapacity:20];
    self.calculated = YES;
    [self.maxConflictItems addObject:self];
    
    if ([self.conflictItems count]>0) {
        for (YJCalendarEvent* event in self.conflictItems) {
            [self addmaxConflictItems:event inWhiteBoard:self.maxConflictItems];
        }
    }
    
    NSInteger maxConflict = [self getMaxConflictItemInArray:self.maxConflictItems];
    for (YJCalendarEvent* event in self.maxConflictItems) {
        event.maxConflicts = maxConflict;
        if (event!=self) {
            event.maxConflictItems = self.maxConflictItems;
        }
    }
}

-(void)dealloc{
    self.conflictItems = nil;
    self.bgColor = nil;
    self.titleString = nil;
    self.maxConflictItems = nil;
    self.moreButtonItems = nil;
}

@end
