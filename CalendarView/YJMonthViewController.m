//
//  YJMonthViewController.m
//  CalendarView
//
//  Created by 杨 佳 on 13-1-31.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import "YJMonthViewController.h"
#import "YJCalendarMonthView.h"
@interface YJMonthViewController ()

@property (nonatomic, retain) YJCalendarMonthView* monthView;

@end

@implementation YJMonthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.monthView = [[YJCalendarMonthView alloc] initWithFrame:CGRectMake(0, 0, 600, 400)];
        self.monthView.lineColor = [UIColor redColor];
        self.monthView.dataSource = self;
        self.monthView.delegate = self;
        [self.view addSubview:self.monthView];
    }
    return self;
}
- (IBAction)clickDismiss:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark YJCalendarMonthViewDelegate
-(NSArray*)eventsArray{
    NSMutableArray* mutalbeArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    YJCalendarEvent* event = [YJCalendarEvent alloc];
    event.monthX = 0;
    event.monthY = 0;
    event.titleString = @"strinjre;";
    [mutalbeArray addObject:event];
     
    event = [YJCalendarEvent alloc];
    event.monthX = 0;
    event.monthY = 0;
    event.titleString = @"111;";
    
    [mutalbeArray addObject:event];
    
    event = [YJCalendarEvent alloc];
    event.monthX = 0;
    event.monthY = 0;
    event.titleString = @"222222;";
    
    [mutalbeArray addObject:event];
    
    event = [YJCalendarEvent alloc];
    event.monthX = 0;
    event.monthY = 0;
    event.titleString = @"33333;";
    
    [mutalbeArray addObject:event];
    
    
    
    event = [YJCalendarEvent alloc];
    event.monthX = 0;
    event.monthY = 1;
    event.titleString = @"33333;";
    
    [mutalbeArray addObject:event];
    
    
    event = [YJCalendarEvent alloc];
    event.monthX = 0;
    event.monthY = 2;
    event.titleString = @"33333;";
    
    [mutalbeArray addObject:event];
    
    
    event = [YJCalendarEvent alloc];
    event.monthX = 1;
    event.monthY = 0;
    event.titleString = @"33333;";
    
    [mutalbeArray addObject:event];
    
    event = [YJCalendarEvent alloc];
    event.monthX = 2;
    event.monthY = 0;
    event.titleString = @"33333;";
    
    [mutalbeArray addObject:event];
    
    event = [YJCalendarEvent alloc];
    event.monthX = 3;
    event.monthY = 0;
    event.titleString = @"33333;";
    
    [mutalbeArray addObject:event];

    event = [YJCalendarEvent alloc];
    event.monthX = 4;
    event.monthY = 0;
    event.titleString = @"33333;";
    [mutalbeArray addObject:event];
    
    event = [YJCalendarEvent alloc];
    event.monthX = 5;
    event.monthY = 0;
    event.titleString = @"33333;";
    
    [mutalbeArray addObject:event];
    
    
    event = [YJCalendarEvent alloc];
    event.monthX = 6;
    event.monthY = 0;
    event.titleString = @"33333;";
    
    [mutalbeArray addObject:event];
    
    event = [YJCalendarEvent alloc];
    event.monthX = 0;
    event.monthY = 0;
    event.titleString = @"4444;";
    
    [mutalbeArray addObject:event];
    
    
    
    event = [YJCalendarEvent alloc];
    event.monthX = 2;
    event.monthY = 2;
    event.titleString = @"5555;";
    
    [mutalbeArray addObject:event];
    
    
    
    event = [YJCalendarEvent alloc];
    event.monthX = 3;
    event.monthY = 3;
    event.titleString = @"666;";
    
    [mutalbeArray addObject:event];
    
    return mutalbeArray;
}

-(NSString*)cellTitleForX:(NSInteger)x y:(NSInteger)y{
    return [NSString stringWithFormat:@"%d:%d",x, y];
}

-(void)clickEvent:(YJCalendarEvent *)event{
    
    if (event.isShowMore) {
        for (YJCalendarEvent* item in event.moreButtonItems) {
            NSLog(@"%@", item.titleString);
        }
    }
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:event.titleString message:[NSString stringWithFormat:@"clicked %@", event.titleString] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alertView show];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
