//
//  YJSevenDaysViewController.m
//  CalendarView
//
//  Created by 杨 佳 on 13-1-31.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import "YJSevenDaysViewController.h"

#import "YJWeekViewController.h"
#import "YJCalendarWeekView.h"

@interface YJSevenDaysViewController ()

@property (nonatomic, retain) YJCalendarWeekView* weekView;

@end

@implementation YJSevenDaysViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.weekView = [[YJCalendarWeekView alloc] initWithFrame:CGRectMake(0, 0, 500, 600)];
    self.weekView.lineColor = [UIColor darkGrayColor];
    self.weekView.delegate = self;
    self.weekView.dataSource = self;
    self.weekView.linePadding = 50.0;
    self.weekView.numberofDays = 7;
    
    [self.view addSubview:self.weekView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)clickDismiss:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
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
    event.startBlock = 3;
    event.endBlock = 3;
    event.titleString = @"222222;";
    
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
    event.endBlock = 13;
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
    [firstDay addObject:event];
    [array addObject:firstDay];
    
    return array;
}

-(void)clickEvent:(YJCalendarEvent *)event{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:event.titleString message:[NSString stringWithFormat:@"clicked %@", event.titleString] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end