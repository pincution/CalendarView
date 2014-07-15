//
//  YJCalendarDayView.m
//  CalendarView
//
//  Created by 杨 佳 on 13-1-30.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import "YJCalendarDayView.h"
#import "YJEventCalculator.h"
#import "YJCalendarEventItemView.h"

static NSString const * const HOURS_AM_PM[] = {
	@" 12 AM", @" 1 AM", @" 2 AM", @" 3 AM", @" 4 AM", @" 5 AM", @" 6 AM", @" 7 AM", @" 8 AM", @" 9 AM", @" 10 AM", @" 11 AM",
	@" Noon", @" 1 PM", @" 2 PM", @" 3 PM", @" 4 PM", @" 5 PM", @" 6 PM", @" 7 PM", @" 8 PM", @" 9 PM", @" 10 PM", @" 11 PM", @" 12 PM"
};

static NSString const * const HOURS_24[] = {
	@" 0:00", @" 1:00", @" 2:00", @" 3:00", @" 4:00", @" 5:00", @" 6:00", @" 7:00", @" 8:00", @" 9:00", @" 10:00", @" 11:00",
	@" 12:00", @" 13:00", @" 14:00", @" 15:00", @" 16:00", @" 17:00", @" 18:00", @" 19:00", @" 20:00", @" 21:00", @" 22:00", @" 23:00", @" 24:00"
};

#define MORE_BUTTON_WIDTH 10
#define DEFAULT_MAX_ROW 5
#define DEFAULT_LINE_ALPHA 1.0f
#define DEFAULT_MOREEVENTWIDTH 10.0f
#define DEFAULT_LINE_PADDING 50.f

@interface YJCalendarDayView()

@property (nonatomic, assign) NSInteger totalLine;
@property (nonatomic, assign) CGFloat eventMinHeight;
@property (nonatomic, assign) CGRect gridRect;

@property (nonatomic, retain) UIView* gridView;
@property (nonatomic, retain) NSArray* itemViews;
@property (nonatomic, assign) CGFloat eventMinWidth;
@end



@implementation YJCalendarDayView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    // Initialization code
    self.backgroundColor = [UIColor blueColor];
    self.textColor = [UIColor blackColor];
    self.lineColor = [UIColor darkGrayColor];
    self.minitumMinitus = YJEventBlockMiniumMinitusHalfHour;
    self.lineAlpha = DEFAULT_LINE_ALPHA;
    self.linePadding = DEFAULT_LINE_PADDING;
    
    self.gridRect = CGRectMake(self.linePadding, 0, self.frame.size.width, self.frame.size.height);
    self.gridView = [[UIView alloc] initWithFrame:self.gridRect];
    self.maxRow = DEFAULT_MAX_ROW;
    _moreEventWidth = DEFAULT_MOREEVENTWIDTH;
}

-(void)setMaxRow:(NSInteger)maxRow{
    _maxRow = maxRow;
}

-(void)setMinitumMinitus:(YJEventBlockMiniumMinitus)minitumMinitus{
    _minitumMinitus = minitumMinitus;
    if (_minitumMinitus == YJEventBlockMiniumMinitusOneHour) {
        _oneBlockHeight = self.frame.size.height/24;
        self.totalLine = 24;
    }
    else if (_minitumMinitus == YJEventBlockMiniumMinitusHalfHour){
        _oneBlockHeight = self.frame.size.height/48;
        self.totalLine = 48;
    }
    else if (_minitumMinitus == YJEventBlockMiniumMinitusOneFifteenMinitus){
        _oneBlockHeight = self.frame.size.height/96;
        self.totalLine = 96;
    }
    else if (_minitumMinitus == YJEventBlockMiniumMinitusOneMiniuts){
        _oneBlockHeight = self.frame.size.height/(24*60);
        self.totalLine = 24*60;
    }
}

- (BOOL)timeIs24HourFormat {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterNoStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	NSString *dateString = [formatter stringFromDate:[NSDate date]];
	NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
	NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
	BOOL is24Hour = amRange.location == NSNotFound && pmRange.location == NSNotFound;
	return is24Hour;
}

-(CGFloat)getLineWidthWithLineNumber:(NSInteger)line{
    NSArray* array = nil;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(lineWidthArray)]) {
        array = [self.dataSource lineWidthArray];
    }
    if(!array){
        array = @[@1.0f,@1.0f];
    }

    NSInteger index = line%[array count];
    NSNumber* number = [array objectAtIndex:index];
        
    return [number floatValue];
}


-(void)refreshGridView{
    
    NSArray* eventsArray = nil;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(eventsArray)]) {
        eventsArray = [self.dataSource eventsArray];
    }
    
    if (!eventsArray || [eventsArray count] <=0) {
        return;
    }
    

    YJEventCalculator* calculator = [[YJEventCalculator alloc] init];
    
    CGSize size = self.gridRect.size;
    size.width -= self.linePadding;
    calculator.viewSize = size;
    calculator.maxRow = self.maxRow;
    calculator.blockMinHeight = self.eventMinHeight;
    calculator.eventMinWidth =self.eventMinWidth;
    calculator.totalBlock = self.totalLine;
    calculator.moreButtonWidth = self.moreEventWidth;

    
    NSMutableArray* viewsArray = [calculator getViewsWithEventArray:eventsArray];

    if(self.gridView)
    {
        [self.gridView removeFromSuperview];
        self.gridView = nil;
        
        self.gridView = [[UIView alloc] initWithFrame:self.gridRect];
        self.gridView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.gridView];
    }
    
    for (YJCalendarEventItemView* view in viewsArray) {
        [view addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.gridView addSubview:view];
    }

}


-(void)clickEvent:(YJCalendarEventItemView*)view
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickEvent:)]) {
        [self.delegate clickEvent:view.event];
    }
}

-(void)setLinePadding:(CGFloat)linePadding{
    _linePadding = linePadding;
    CGRect rect = self.gridRect;
    rect.origin.x = _linePadding;
    self.gridRect = rect;
}

-(CGFloat)eventMinHeight{
    return self.gridRect.size.height/self.totalLine;
}

-(CGFloat)eventMinWidth{
    return (self.gridRect.size.width - MORE_BUTTON_WIDTH)/self.maxRow;
}

-(void)layoutSubviews{
    [self refreshGridView];
    [super layoutSubviews];
}


- (void)drawRect:(CGRect)rect {
	register unsigned int i;
    
    
	const NSString *const *HOURS = ([self timeIs24HourFormat] ? HOURS_24 : HOURS_AM_PM);
	
	[[UIColor blackColor] set];
    
    float cellHeight = self.frame.size.height/24;
    
    // 画出文字时间
	for (i=0; i < 24; i++) {
        
		CGSize sizeNecessary = [HOURS[i] sizeWithFont:[UIFont systemFontOfSize:16]];
		CGRect rect = CGRectMake(CGRectGetMinX(self.bounds),
								 (cellHeight * i)- (sizeNecessary.height / 2.f),
								 sizeNecessary.width,
								 sizeNecessary.height);
		
        if (i==0) {
            rect.origin.y +=5;
        }
        
		[HOURS[i] drawInRect: rect
                    withFont:[UIFont systemFontOfSize:16]
               lineBreakMode:UILineBreakModeTailTruncation
                   alignment:UITextAlignmentLeft];
	}
    
    // 画线
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [self.lineColor CGColor]);
    
    CGFloat paddingX = self.linePadding;
    
    for (i=0; i<self.totalLine; i++) {
        CGFloat lineHeight = i*_oneBlockHeight;
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, paddingX, lineHeight);
        CGContextSetLineWidth(context, [self getLineWidthWithLineNumber:i]);
        CGContextSetAlpha(context, self.alpha);
        CGContextAddLineToPoint(context, self.frame.size.width, lineHeight);
        
        CGContextClosePath(context);
        CGContextSaveGState(context);
        CGContextDrawPath(context, kCGPathFillStroke);
        CGContextRestoreGState(context);
    }
    
    [super drawRect:rect];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
