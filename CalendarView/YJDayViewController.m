//
//  YJDayViewController.m
//  CalendarView
//
//  Created by 杨 佳 on 13-1-30.
//  Copyright (c) 2013年 yangjia. All rights reserved.
//

#import "YJDayViewController.h"
#import "YJCalendarDayView.h"
#import "YJCalendarEvent.h"

@interface YJDayViewController ()

@property (nonatomic, retain) YJCalendarDayView* dayView;

@end

@implementation YJDayViewController

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
    self.dayView = [[YJCalendarDayView alloc] initWithFrame:CGRectMake(0, 0, 500, 600)];
    self.dayView.lineColor = [UIColor darkGrayColor];
    self.dayView.delegate = self;
    self.dayView.dataSource = self;
    self.dayView.linePadding = 50.0;
    
    [self.view addSubview:self.dayView];
    [super viewDidLoad];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload{
    self.dayView = nil;
    [super viewDidUnload];
}

- (IBAction)dismiss:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark YJDayViewDelegate

-(NSArray*)lineWidthArray{
    NSArray* array = @[@1.0f, @0.5f];
    return array;
}

-(double)minimunMinutesInBlock{
    return 60;
}

-(NSArray*)eventsArray{
    NSMutableArray* mutalbeArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    YJCalendarEvent* event = [YJCalendarEvent alloc];
    event.startBlock = 0;
    event.endBlock = 0;
    event.titleString = @"strinjre;";
    
    event = [YJCalendarEvent alloc];
    event.startBlock = 3;
    event.endBlock = 3;
    event.titleString = @"222222;";
    
    [mutalbeArray addObject:event];
    
    
    event = [YJCalendarEvent alloc];
    event.startBlock = 4;
    event.endBlock = 6;
    event.titleString = @"333333;";
    
    [mutalbeArray addObject:event];
    
    
    event = [YJCalendarEvent alloc];
    event.startBlock = 5;
    event.endBlock = 7;
    event.titleString = @"5555;";
    [mutalbeArray addObject:event];
    
    // hiden
    event = [YJCalendarEvent alloc];
    event.startBlock = 6;
    event.endBlock = 8;
    event.titleString = @"666;";
    [mutalbeArray addObject:event];
    
    event = [YJCalendarEvent alloc];
    event.startBlock = 7;
    event.endBlock = 9;
    event.titleString = @"7777;";
    [mutalbeArray addObject:event];
    
    

    return mutalbeArray;
}

-(void)clickEvent:(YJCalendarEvent *)event{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:event.titleString message:[NSString stringWithFormat:@"clicked %@", event.titleString] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alertView show];
}

@end
