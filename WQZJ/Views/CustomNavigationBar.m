//
//  CustomNavigationBar.m
//  WQZJ
//
//  Created by J on 14-10-15.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "CustomNavigationBar.h"

#import "Define.h"

@implementation CustomNavigationBar

- (id)initWithNeedShowLeftButton:(BOOL)show
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, isOverIOS7?(StatusBarHeight + NavigationBarHeight):NavigationBarHeight)];
    if (self) {
        if (isOverIOS7) {
            UIView * blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, StatusBarHeight)];
            blackView.backgroundColor = [UIColor blackColor];
            [self addSubview:blackView];
        }
        
        UIView * navView = [[UIView alloc] initWithFrame:CGRectMake(0, isOverIOS7?StatusBarHeight:0, ScreenWidth, NavigationBarHeight)];
        navView.backgroundColor = ThemeColor;
        [self addSubview:navView];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 1, ScreenWidth, 1)];
        lineView.backgroundColor = RGBColor(55, 157, 230);
        [self addSubview:lineView];
        
        if (show) {
            UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftButton.frame = CGRectMake(10, isOverIOS7?StatusBarHeight:0 + (NavigationBarHeight - 20)/2, 14, 20);
            [leftButton setImage:[UIImage imageNamed:@"ic_back_normal.png"] forState:UIControlStateNormal];
            [leftButton setImage:[UIImage imageNamed:@"ic_back_normal.png"] forState:UIControlStateHighlighted];
            [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:leftButton];
        }
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(show?30:10, navView.frame.origin.y, ScreenWidth - 20, navView.bounds.size.height)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.shadowColor = [UIColor blackColor];
        self.titleLabel.shadowOffset = CGSizeMake(0, 1);
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [self addSubview:self.titleLabel];
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0.1);
        self.layer.shadowOpacity = 0.5;
    }
    return self;
}

- (void) leftButtonClick{
    if (self.leftBlock) {
        self.leftBlock();
    }
}

@end
