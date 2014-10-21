//
//  SinglePickerView.h
//  WQZJ
//
//  Created by J on 14-10-16.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinglePickerView : UIView
{
    UILabel * topLabel;
    UILabel * middleLabel;
    UILabel * bottomLabel;
    int maxNum;
    int minNum;
    float lastTouchY;
    BOOL type;//0 year 1 month 2 day
}

- (id)initWithOrigin:(CGPoint)origin maxNumber:(int)max minNumber:(int)min datetype:(int)datetype currentNum:(int)num;

@end
