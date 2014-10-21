//
//  WorkMainViewController.m
//  WQZJ
//
//  Created by J on 14-10-19.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "WorkMainViewController.h"

#import "AttendanceMainViewController.h"
#import "SwingCardMainViewController.h"
#import "NotificationMainViewController.h"
#import "WorkDailyMainViewController.h"
#import "ManageCustomerMainViewController.h"
#import "VisitCustomerMainViewController.h"
#import "VisitPlanMainViewController.h"
#import "ManageOrderFormMainViewController.h"
#import "ApplicationFeeMainViewController.h"
#import "SettingMainViewController.h"

#import "CustomNavigationBar.h"
#import "CustomTabbarView.h"


#import "Define.h"

@interface WorkMainViewController ()

@end

@implementation WorkMainViewController

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
    
    [self loadSubviews];
}

- (void) loadSubviews{
    if (isOverIOS7) {
        self.edgesForExtendedLayout = NO;
    }
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_home.png"]];
    
    CustomNavigationBar * navigationBar = [[CustomNavigationBar alloc] initWithNeedShowLeftButton:NO];
    navigationBar.titleLabel.text = @"外勤专家";
    [self.view addSubview:navigationBar];
    
    float tabbarViewFrameY = isOverIOS7?(ScreenHeight - TabbarHeight):(ScreenHeight - StatusBarHeight - TabbarHeight);
    CustomTabbarView * tabbarView = [[CustomTabbarView alloc] initWithOrigin:CGPointMake(0, tabbarViewFrameY) highlightIndex:0];
    tabbarView.rightBlock = ^(){
        self.tabBarController.selectedIndex = 1;
    };
    [self.view addSubview:tabbarView];
    
    CGRect menuFrame = self.buttonMenuView.frame;
    [self.view addSubview:self.buttonMenuView];
    menuFrame.origin.y = navigationBar.bounds.size.height;
    self.buttonMenuView.frame = menuFrame;
    
    if (ScreenHeight <= 480) {
        for (UIView * view in self.buttonMenuView.subviews) {
            view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                    UIViewAutoresizingFlexibleWidth |
                                    UIViewAutoresizingFlexibleRightMargin |
                                    UIViewAutoresizingFlexibleTopMargin |
                                    UIViewAutoresizingFlexibleHeight |
                                    UIViewAutoresizingFlexibleBottomMargin;
        }
        
        float menuHeight = ScreenHeight - StatusBarHeight - NavigationBarHeight - TabbarHeight;
        float menuWidth = menuHeight * menuFrame.size.width / menuFrame.size.height;
        menuFrame.size = CGSizeMake(menuWidth, menuHeight);
        menuFrame.origin.x = (ScreenWidth - menuWidth)/2;
        self.buttonMenuView.frame  = menuFrame;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ButtonClick

- (IBAction)attendanceCardButtonClick:(id)sender {
    
}

- (IBAction)notificationButtonClick:(id)sender {
    NotificationMainViewController * notification = [[NotificationMainViewController alloc] initWithNibName:@"NotificationMainViewController" bundle:nil];
    [self.navigationController pushViewController:notification animated:YES];
}

- (IBAction)workDailyButtonClick:(id)sender {
    WorkDailyMainViewController * workDaily = [[WorkDailyMainViewController alloc] initWithNibName:@"WorkDailyMainViewController" bundle:nil];
    [self.navigationController pushViewController:workDaily animated:YES];
}

- (IBAction)manageCustomerButtonClick:(id)sender {
    ManageCustomerMainViewController * manageCustomer = [[ManageCustomerMainViewController alloc] initWithNibName:@"ManageCustomerMainViewController" bundle:nil];
    [self.navigationController pushViewController:manageCustomer animated:YES];
}

- (IBAction)visitCustomerButtonClick:(id)sender {
    VisitCustomerMainViewController * visitCustomer = [[VisitCustomerMainViewController alloc] initWithNibName:@"VisitCustomerMainViewController" bundle:nil];
    [self.navigationController pushViewController:visitCustomer animated:YES];
}

- (IBAction)visitPlanButtonClick:(id)sender {
    VisitPlanMainViewController * visitPlan = [[VisitPlanMainViewController alloc] initWithNibName:@"VisitPlanMainViewController" bundle:nil];
    [self.navigationController pushViewController:visitPlan animated:YES];
}

- (IBAction)manageOrderFormButtonClick:(id)sender {
    ManageOrderFormMainViewController * manageOrderForm = [[ManageOrderFormMainViewController alloc] initWithNibName:@"ManageOrderFormMainViewController" bundle:nil];
    [self.navigationController pushViewController:manageOrderForm animated:YES];
}

- (IBAction)applicationFeeButtonClick:(id)sender {
    ApplicationFeeMainViewController * applicationFee = [[ApplicationFeeMainViewController alloc] initWithNibName:@"ApplicationFeeMainViewController" bundle:nil];
    [self.navigationController pushViewController:applicationFee animated:YES];
}

- (IBAction)settingButtonClick:(id)sender {
    SettingMainViewController * setting = [[SettingMainViewController alloc] initWithNibName:@"SettingMainViewController" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];
}

@end
