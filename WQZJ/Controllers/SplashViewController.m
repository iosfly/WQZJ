//
//  SplashViewController.m
//  WQZJ
//
//  Created by J on 14-10-19.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "SplashViewController.h"
#import "WorkMainViewController.h"
#import "Define.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

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
    
    UIImage * splashImage = [UIImage imageNamed:@"splash.jpg"];
    float splashHeight = splashImage.size.height * ScreenWidth / splashImage.size.width;
    float splashY = isOverIOS7?(ScreenHeight - splashHeight):(ScreenHeight - splashHeight - StatusBarHeight);
    UIImageView * splashIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, splashY, ScreenWidth, splashHeight)];
    [splashIv setImage:[UIImage imageNamed:@"splash.jpg"]];
    [self.view addSubview:splashIv];
    
    float viewHeight = isOverIOS7?ScreenHeight:(ScreenHeight - StatusBarHeight);
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    UILabel * versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, viewHeight - 40, ScreenWidth, 40)];
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.text = [@"v" stringByAppendingString:app_Version];
    versionLabel.textColor = [UIColor blackColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:versionLabel];
    
    [self performSelector:@selector(loadWorkMainViewController) withObject:nil afterDelay:2];
}

- (void) loadWorkMainViewController{
    if (isOverIOS7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    
    WorkMainViewController * work = [[WorkMainViewController alloc] initWithNibName:@"WorkMainViewController" bundle:nil];
    [self.navigationController pushViewController:work animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
