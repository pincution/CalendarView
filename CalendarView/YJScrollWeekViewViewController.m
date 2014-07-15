//
//  YJScrollWeekViewViewController.m
//  CalendarView
//
//  Created by 杨 佳 on 13-2-1.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import "YJScrollWeekViewViewController.h"


@interface YJScrollWeekViewViewController ()
@property (nonatomic, retain) YJCalendarWeekScrollView* weekScrolView;
@end

@implementation YJScrollWeekViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.weekScrolView = [[YJCalendarWeekScrollView alloc] initWithFrame:CGRectMake(0, 0, 700, 800)];
        self.weekScrolView.delegate = self;
        self.weekScrolView.weekView.numberofDays = 7;
        self.weekScrolView.topTextHeight = 20;
        self.weekScrolView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.weekScrolView];
    }
    return self;
}


#pragma mark -
#pragma mark YJCalendarWeekViewDelegate

-(NSArray*)lineWidthArray{
    return nil;
}

-(NSArray*)eventsArray{
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:7];
    
    // first day
    NSMutableArray* firstDay = [[NSMutableArray alloc] initWithCapacity:10];
    
    YJCalendarEvent* event = [YJCalendarEvent alloc];
    event.startBlock = 3;
    event.endBlock = 3;
    event.titleString = @"111111;";
    
    [firstDay addObject:event];
    
    
    event = [YJCalendarEvent alloc];
    event.startBlock = 4;
    event.endBlock = 6;
    event.titleString = @"333333;";
    
    [firstDay addObject:event];
    
    
    event = [YJCalendarEvent alloc];
    event.startBlock = 5;
    event.endBlock = 7;
    event.titleString = @"5555;";
    [firstDay addObject:event];
    
    // hiden
    event = [YJCalendarEvent alloc];
    event.startBlock = 6;
    event.endBlock = 8;
    event.titleString = @"666;";

    [firstDay addObject:event];
    
    event = [YJCalendarEvent alloc];
    event.startBlock = 7;
    event.endBlock = 9;
    event.titleString = @"7777;";
    [firstDay addObject:event];
    
    [array addObject:firstDay];
    
    // secondday
    firstDay = [[NSMutableArray alloc] initWithCapacity:10];
    
    
    event = [YJCalendarEvent alloc];
    event.startBlock = 10;
    event.endBlock = 11;
    event.titleString = @"55555";
    [firstDay addObject:event];
    
    
    event = [YJCalendarEvent alloc];
    event.startBlock = 12;
    event.endBlock = 12;
    event.titleString = @"222222;";
    
    [firstDay addObject:event];
    
    
    event = [YJCalendarEvent alloc];
    event.startBlock = 14;
    event.endBlock = 16;
    event.titleString = @"333333;";
    
    [firstDay addObject:event];
    
    
    event = [YJCalendarEvent alloc];
    event.startBlock = 15;
    event.endBlock = 17;
    event.titleString = @"5555;";
    [firstDay addObject:event];
    
    // hiden
    event = [YJCalendarEvent alloc];
    event.startBlock = 16;
    event.endBlock = 18;
    event.titleString = @"666;";
    [firstDay addObject:event];
    
    event = [YJCalendarEvent alloc];
    event.startBlock = 17;
    event.endBlock = 19;
    event.titleString = @"7777;";
    [firstDay addObject:event];
    
    
    
    [array addObject:firstDay];
    
    
    // third day
    firstDay = [[NSMutableArray alloc] initWithCapacity:10];
    event = [YJCalendarEvent alloc];
    event.startBlock = 3;
    event.endBlock = 6;
    event.titleString = @"55555";
    [firstDay addObject:event];
    [array addObject:firstDay];
    
    // fourth day
    firstDay = [[NSMutableArray alloc] initWithCapacity:10];
    event = [YJCalendarEvent alloc];
    event.startBlock = 3;
    event.endBlock = 6;
    event.titleString = @"55555";
    [firstDay addObject:event];
    [array addObject:firstDay];
    
    // fifth day
    firstDay = [[NSMutableArray alloc] initWithCapacity:10];
    event = [YJCalendarEvent alloc];
    event.startBlock = 3;
    event.endBlock = 6;
    event.titleString = @"55555";
    [firstDay addObject:event];
    [array addObject:firstDay];
    
    // sixth day
    firstDay = [[NSMutableArray alloc] initWithCapacity:10];
    event = [YJCalendarEvent alloc];
    event.startBlock = 3;
    event.endBlock = 6;
    event.titleString = @"55555";
    [firstDay addObject:event];
    [array addObject:firstDay];
    
    
    // seventh day
    firstDay = [[NSMutableArray alloc] initWithCapacity:10];
    event = [YJCalendarEvent alloc];
    event.startBlock = 3;
    event.endBlock = 6;
    event.titleString = @"55555";
    event.bgColor = [UIColor redColor];
    [firstDay addObject:event];
    [array addObject:firstDay];
    
    return array;
}

-(void)clickEvent:(YJCalendarEvent *)event{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:event.titleString message:[NSString stringWithFormat:@"clicked %@", event.titleString] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alertView show];
}


-(NSString*)titleStringOfDay:(NSInteger)day{
    return [NSString stringWithFormat:@"星期%d",day];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)clickDismiss:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
