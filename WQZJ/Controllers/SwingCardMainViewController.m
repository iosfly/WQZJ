//
//  SwingCardMainViewController.m
//  WQZJ
//
//  Created by J on 14-10-19.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "SwingCardMainViewController.h"

@interface SwingCardMainViewController ()

@end

@implementation SwingCardMainViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=self;
    [self.view addSubview:calendar];
    
    [self drawDate:calendar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animate{
    [self drawDate:calendarView];
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);
}

- (void) drawDate:(VRGCalendarView *)calendar{
    [calendar markDates:@[@(15),@(20)]
             withColors:[NSArray arrayWithObjects:[UIColor redColor],[UIColor orangeColor], nil]];
}

@end
