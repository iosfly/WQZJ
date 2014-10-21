//
//  DateManager.m
//  WQZJ
//
//  Created by J on 14-10-17.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "DateManager.h"

static DateManager * shareDateManager;

@implementation DateManager

+ (DateManager *) shareDateManager
{
    @synchronized(self)
    {
        if (!shareDateManager)
        {
            shareDateManager = [[self alloc] init];
        }
    }
    return shareDateManager;
}

- (id) init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (int) currentYear{
    return [DateManager shareDateManager].currentYear;
}

+ (int) currentMonth{
    return [DateManager shareDateManager].currentMonth;
}

+ (int) currentDay{
    return [DateManager shareDateManager].currentDay;
}

+ (void) setCurrentYear:(int)year{
    [DateManager shareDateManager].currentYear = year;
}

+ (void) setCurrentMonth:(int)month{
    [DateManager shareDateManager].currentMonth = month;
}

+ (void) setCurrentDay:(int)day{
    [DateManager shareDateManager].currentDay = day;
}

@end
