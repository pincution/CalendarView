//
//  YJCalendarWeekScrollView.m
//  CalendarView
//
//  Created by 杨 佳 on 13-2-1.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import "YJCalendarWeekScrollView.h"
#import "YJCalendarWeekView.h"

#define DEFAULT_LABEL_HEIGHT 15
#define DEFAULT_WEEKVIEW_HEIGHT 1000
#define DEFAULT_TITLE_FONT [UIFont systemFontOfSize:16]
#define DEFAULT_TITLE_COLOR [UIColor grayColor]
@interface YJCalendarWeekScrollView ()

@property (nonatomic, retain) UIScrollView* scrollView;

@end

@implementation YJCalendarWeekScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.topTextHeight = DEFAULT_LABEL_HEIGHT;
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topTextHeight, self.frame.size.width, self.frame.size.height-self.topTextHeight)];
        self.scrollView.scrollEnabled = YES;
        
        self.weekView = [[YJCalendarWeekView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, DEFAULT_WEEKVIEW_HEIGHT)];
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width, DEFAULT_WEEKVIEW_HEIGHT);
        self.weekView.delegate = self;
        self.weekView.dataSource = self;
        self.titleColor = DEFAULT_TITLE_COLOR;
        
        [self.scrollView addSubview:self.weekView];
        
        [self addSubview:self.scrollView];
    }
    return self;
}


-(void)setTopTextHeight:(CGFloat)topTextHeight{
    _topTextHeight = topTextHeight;
    CGRect scrollRect = CGRectMake(0, topTextHeight, self.frame.size.width, self.frame.size.height-_topTextHeight);
    self.scrollView.frame = scrollRect;
}

-(void)setWeekViewSize:(CGSize)weekViewSize{
    _weekViewSize = weekViewSize;
    
    self.scrollView.contentSize = weekViewSize;
    self.weekView.frame = CGRectMake(0, 0, weekViewSize.width, weekViewSize.height);
}

-(NSArray*)eventsArray{
    if (self.delegate) {
        return [self.delegate eventsArray];
    }
    return nil;
}

-(NSArray*)lineWidthArray{
    if (self.delegate) {
        return [self.delegate lineWidthArray];
    }
    return nil;
}

-(void)clickEvent:(YJCalendarEvent *)event{
    if (self.delegate) {
        [self.delegate clickEvent:event];
    }
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // 画出文字时间
	for (int i=0; i < self.weekView.numberofDays; i++) {
        
        NSString* title = @"";
    
        [self.titleColor set];
        
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(titleStringOfDay:)]) {
            title = [self.delegate titleStringOfDay:i];
        }
        
		CGSize sizeNecessary = [title sizeWithFont:DEFAULT_TITLE_FONT];
        CGFloat cellWidth = (self.weekView.frame.size.width-self.weekView.linePadding)/self.weekView.numberofDays;
        CGFloat x = self.weekView.linePadding+(cellWidth)*i;
        CGFloat y = 0;
        
        x +=(cellWidth - sizeNecessary.width)/2;
        
		CGRect rect = CGRectMake(x,
								 y,
								 sizeNecessary.width,
								 sizeNecessary.height);
        
		[title drawInRect: rect
                    withFont:DEFAULT_TITLE_FONT
               lineBreakMode:UILineBreakModeTailTruncation
                   alignment:UITextAlignmentLeft];
	}
    
    [super drawRect:rect];
}


@end
