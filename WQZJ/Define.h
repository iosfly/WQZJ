//
//  Define.h
//  Health
//
//  Created by J on 14-9-14.
//  Copyright (c) 2014年 lu. All rights reserved.
//

//屏幕尺寸
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBounds CGRectMake(0, 0, ScreenWidth, ScreenHeight)
#define ScreenCenter CGPointMake(ScreenWidth/2, ScreenHeight/2)

#define NavigationBarHeight 44
#define TabbarHeight 40
#define StatusBarHeight 20
#define KeyboardHeight 216

//实际像素
#define realSize [[UIScreen mainScreen] currentMode].size

#define isOverIOS7 ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)

#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define ThemeColor RGBColor(77, 176, 246)

#define ServiceUrl @""
