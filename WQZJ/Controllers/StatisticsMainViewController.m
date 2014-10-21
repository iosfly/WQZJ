//
//  StatisticsMainViewController.m
//  WQZJ
//
//  Created by J on 14-10-19.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "StatisticsMainViewController.h"

#import "CustomNavigationBar.h"
#import "CustomTabbarView.h"

#import "Define.h"

@interface StatisticsMainViewController ()

@end

@implementation StatisticsMainViewController

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
    CustomTabbarView * tabbarView = [[CustomTabbarView alloc] initWithOrigin:CGPointMake(0, tabbarViewFrameY) highlightIndex:1];
    tabbarView.leftBlock = ^(){
        self.tabBarController.selectedIndex = 0;
    };
    [self.view addSubview:tabbarView];
    
    CGRect infoFrame = self.infoView.frame;
    infoFrame.origin.y = navigationBar.bounds.size.height;
    self.infoView.frame = infoFrame;
    [self.view addSubview:self.infoView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
