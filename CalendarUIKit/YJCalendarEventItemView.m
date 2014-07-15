//
//  YJCalendarEventItem.m
//  CalendarView
//
//  Created by 杨 佳 on 13-1-30.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import "YJCalendarEventItemView.h"
#import <QuartzCore/QuartzCore.h>
#define DEFAULT_CORNER_RADIUS 6
#define DEFAULT_FONE_SIZE 12
#define DEFAULT_BG_COLOR [UIColor lightGrayColor]
@implementation YJCalendarEventItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = DEFAULT_BG_COLOR;
        self.layer.cornerRadius = DEFAULT_CORNER_RADIUS;
        self.layer.masksToBounds = YES;
        self.fontSize =DEFAULT_FONE_SIZE;
        self.Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.Label.backgroundColor = [UIColor clearColor];
        self.Label.textAlignment = UITextAlignmentCenter;
        self.Label.textColor = [UIColor whiteColor];
        [self addSubview:self.Label];
    }
    return self;
}

-(void)setEvent:(YJCalendarEvent *)event{
    _event = event;
    self.Label.text = event.titleString;
    if (event.bgColor) {
        self.backgroundColor = event.bgColor;
    }
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
//    CGSize size = [self.event.titleString sizeWithFont:[UIFont systemFontOfSize:self.fontSize]];
//    
//    float x = (rect.size.width - size.width)/2;
//    if (x<0) {
//        x = DEFAULT_CORNER_RADIUS;
//    }
//    
//    float width = rect.size.width - 2*DEFAULT_CORNER_RADIUS;
//    
//    float y = (rect.size.height - size.height)/2;
//    
//    CGRect textRect = CGRectMake(x, y, width, self.fontSize);
//    
//    [self.event.titleString drawInRect:textRect withFont:[UIFont systemFontOfSize:self.fontSize]];
    
    [super drawRect:rect];
}


@end
