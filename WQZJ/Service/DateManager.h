//
//  DateManager.h
//  WQZJ
//
//  Created by J on 14-10-17.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateManager : NSObject

@property(nonatomic, assign) int currentYear;
@property(nonatomic, assign) int currentMonth;
@property(nonatomic, assign) int currentDay;

+ (DateManager *) shareDateManager;

+ (int) currentYear;
+ (int) currentMonth;
+ (int) currentDay;
+ (void) setCurrentYear:(int)year;
+ (void) setCurrentMonth:(int)month;
+ (void) setCurrentDay:(int)day;

@end
