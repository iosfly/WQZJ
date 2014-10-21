//
//  AppDelegate.m
//  WQZJ
//
//  Created by J on 14-10-19.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "AppDelegate.h"
#import "EmptyViewController.h"
#import "SplashViewController.h"
#import "StatisticsMainViewController.h"
#import "Define.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self loadMainViewController];
    
    return YES;
}

- (void) loadMainViewController{
    EmptyViewController * empty = [[EmptyViewController alloc] init];
    SplashViewController * splash = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
    StatisticsMainViewController * statistics = [[StatisticsMainViewController alloc] initWithNibName:@"StatisticsMainViewController" bundle:nil];
    
    UINavigationController * emptyNav = [[UINavigationController alloc] initWithRootViewController:empty];
    empty.hidesBottomBarWhenPushed = YES;
    emptyNav.navigationBarHidden = YES;
    
    UINavigationController * statisticsNav = [[UINavigationController alloc] initWithRootViewController:statistics];
    statistics.hidesBottomBarWhenPushed = YES;
    statisticsNav.navigationBarHidden = YES;
    
    UITabBarController * tabBarViewController = [[UITabBarController alloc] init];
    tabBarViewController.viewControllers = [NSArray arrayWithObjects:emptyNav, statisticsNav, nil];
    self.window.rootViewController = tabBarViewController;
    
    [empty.navigationController pushViewController:splash animated:NO];
}

@end
