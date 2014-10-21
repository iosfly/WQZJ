//
//  CustomDatePickerView.h
//  WQZJ
//
//  Created by J on 14-10-16.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinglePickerView.h"

@interface CustomDatePickerView : UIView
{
    UIView * infoBottomView;
    UIView * titleView;
    SinglePickerView * singleYear;
    SinglePickerView * singleMonth;
    SinglePickerView * singleDay;
}

- (id)initWithYear:(int)year month:(int)month day:(int)day;
- (void) show;

@end
