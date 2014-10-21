//
//  ManageOrderFormMainViewController.m
//  WQZJ
//
//  Created by J on 14-10-19.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "ManageOrderFormMainViewController.h"

#import "CustomNavigationBar.h"

@interface ManageOrderFormMainViewController ()

@end

@implementation ManageOrderFormMainViewController

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
    
    CustomNavigationBar * navigationBar = [[CustomNavigationBar alloc] initWithNeedShowLeftButton:YES];
    navigationBar.titleLabel.text = @"订单管理";
    navigationBar.leftBlock = ^(){
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:navigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
