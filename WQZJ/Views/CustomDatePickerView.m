//
//  CustomDatePickerView.m
//  WQZJ
//
//  Created by J on 14-10-16.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "CustomDatePickerView.h"

#import "DateManager.h"

#import "Define.h"

@implementation CustomDatePickerView

- (id)initWithYear:(int)year month:(int)month day:(int)day
{
    self = [super initWithFrame:ScreenBounds];
    if (self) {
        
        [DateManager shareDateManager];
        [DateManager setCurrentYear:year];
        [DateManager setCurrentMonth:month];
        [DateManager setCurrentDay:day];
        
        UIView * bottomView = [[UIView alloc] initWithFrame:self.bounds];
        bottomView.backgroundColor = [UIColor blackColor];
        bottomView.alpha = 0.5;
        [self addSubview:bottomView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTap)];
        [bottomView addGestureRecognizer:tap];
        
        
        float titleViewHeight = 48.0f;
        infoBottomView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width - 280)/2, 20 + (self.bounds.size.height - 20 - 392)/2, 280, 392)];
        infoBottomView.backgroundColor = [UIColor whiteColor];
        infoBottomView.layer.cornerRadius = 2.0f;
        infoBottomView.clipsToBounds = YES;
        [self addSubview:infoBottomView];
        
        titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, infoBottomView.bounds.size.width, titleViewHeight)];
        titleView.backgroundColor = ThemeColor;
        [infoBottomView addSubview:titleView];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleView.bounds.size.width - 20, titleView.bounds.size.height)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = @"选择日期";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.shadowColor = [UIColor blackColor];
        titleLabel.shadowOffset = CGSizeMake(0, 1);
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [titleView addSubview:titleLabel];
        
        singleYear = [[SinglePickerView alloc] initWithOrigin:CGPointMake(34, 40 + titleView.bounds.size.height) maxNumber:9999 minNumber:1970 datetype:0 currentNum:year];
        [infoBottomView addSubview:singleYear];
        
        singleMonth = [[SinglePickerView alloc] initWithOrigin:CGPointMake(115, 40 + titleView.bounds.size.height) maxNumber:12 minNumber:1 datetype:1 currentNum:month];
        [infoBottomView addSubview:singleMonth];
        
        int maxDays = 0;
        
        if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
            maxDays = 31;
        }else if (month == 2){
            if (year%4 == 0) {
                maxDays = 29;
            }else{
                maxDays = 28;
            }
        }else{
            maxDays = 30;
        }
        
        singleDay = [[SinglePickerView alloc] initWithOrigin:CGPointMake(196, 40 + titleView.bounds.size.height) maxNumber:maxDays minNumber:1 datetype:2 currentNum:day];
        [infoBottomView addSubview:singleDay];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 340, infoBottomView.bounds.size.width, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.alpha = 0.5;
        [infoBottomView addSubview:lineView];
        
        UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(13, 348, 120, 36);
        [cancelButton setImage:[UIImage imageNamed:@"btn_gray_nor.png"] forState:UIControlStateNormal];
        [cancelButton setImage:[UIImage imageNamed:@"btn_blue_sel.png"] forState:UIControlStateHighlighted];
        [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [infoBottomView addSubview:cancelButton];
        
        UILabel * cancelLabel = [[UILabel alloc] initWithFrame:cancelButton.frame];
        cancelLabel.backgroundColor = [UIColor clearColor];
        cancelLabel.text = @"取消";
        cancelLabel.textColor = [UIColor grayColor];
        cancelLabel.textAlignment = NSTextAlignmentCenter;
        [infoBottomView addSubview:cancelLabel];
        
        UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(148, 348, 120, 36);
        [sureButton setImage:[UIImage imageNamed:@"btn_blue_nor.png"] forState:UIControlStateNormal];
        [sureButton setImage:[UIImage imageNamed:@"btn_blue_sel.png"] forState:UIControlStateHighlighted];
        [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [infoBottomView addSubview:sureButton];
        
        UILabel * sureLabel = [[UILabel alloc] initWithFrame:sureButton.frame];
        sureLabel.backgroundColor = [UIColor clearColor];
        sureLabel.text = @"确定";
        sureLabel.textColor = [UIColor whiteColor];
        sureLabel.textAlignment = NSTextAlignmentCenter;
        [infoBottomView addSubview:sureLabel];
    }
    return self;
}

- (void)bottomViewTap{
    [self dismiss];
}

- (void) show{
    self.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
}

- (void) dismiss{
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 

- (void) cancelButtonClick{
    [self dismiss];
}

- (void) sureButtonClick{
    [self dismiss];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DateChanged" object:nil];
}

@end
