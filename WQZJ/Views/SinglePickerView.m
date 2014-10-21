//
//  SinglePickerView.m
//  WQZJ
//
//  Created by J on 14-10-16.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "SinglePickerView.h"

#import "DateManager.h"

#import "Define.h"

@implementation SinglePickerView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"YearChanged" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MonthChanged" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DayChanged" object:nil];
}

- (id)initWithOrigin:(CGPoint)origin maxNumber:(int)max minNumber:(int)min datetype:(int)datetype currentNum:(int)num
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, 50, 212)];
    if (self) {
        
        if (datetype == 1) {
            maxNum = 12;
            minNum = 1;
        }else{
            maxNum = max;
            minNum = min;
        }
        
        type = datetype;
        
        for (int i = 0; i < 2; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((self.bounds.size.width - 26)/2, i*(self.bounds.size.height - 15), 26, 15);
            [button setImage:[UIImage imageNamed:i == 0?@"date_top_nor.png":@"date_bottom_nor.png"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:i == 0?@"date_top_sel.png":@"date_bottom_sel.png"] forState:UIControlStateHighlighted];
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            UIView * blueLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 15 + (i+1)*((self.bounds.size.height - 30 - 8)/3), self.bounds.size.width, 4)];
            blueLineView.backgroundColor = ThemeColor;
            [self addSubview:blueLineView];
        }
        
        int topNum = num - 1;
        if (topNum < minNum) {
            topNum = maxNum;
        }
        topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.bounds.size.width, (self.bounds.size.height - 30 - 8)/3)];
        topLabel.backgroundColor = [UIColor clearColor];
        topLabel.text = type == 1?[NSString stringWithFormat:@"%d月",topNum]:[NSString stringWithFormat:@"%d",topNum];
        topLabel.textColor = [UIColor lightGrayColor];
        topLabel.textAlignment = NSTextAlignmentCenter;
        topLabel.font = [UIFont systemFontOfSize:14.0f];
        
        middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 + 4 + (self.bounds.size.height - 30 - 8)/3, self.bounds.size.width, (self.bounds.size.height - 30 - 8)/3)];
        middleLabel.backgroundColor = [UIColor clearColor];
        middleLabel.text = type == 1?[NSString stringWithFormat:@"%d月",num]:[NSString stringWithFormat:@"%d",num];
        middleLabel.textColor = [UIColor blackColor];
        middleLabel.textAlignment = NSTextAlignmentCenter;
        middleLabel.font = [UIFont systemFontOfSize:14.0f];
        
        int bottomNum = num + 1;
        if (bottomNum > maxNum) {
            bottomNum = minNum;
        }
        bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 + 8 + (self.bounds.size.height - 30 - 8)/3*2, self.bounds.size.width, (self.bounds.size.height - 30 - 8)/3)];
        bottomLabel.backgroundColor = [UIColor clearColor];
        bottomLabel.text = type == 1?[NSString stringWithFormat:@"%d月",bottomNum]:[NSString stringWithFormat:@"%d",bottomNum];
        bottomLabel.textColor = [UIColor lightGrayColor];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        bottomLabel.font = [UIFont systemFontOfSize:14.0f];
        
        [self addSubview:topLabel];
        [self addSubview:middleLabel];
        [self addSubview:bottomLabel];
        
//        if (type == 0) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yearChanged:) name:@"YearChanged" object:nil];
//        }else if (type == 1){
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monthChanged:) name:@"MonthChanged" object:nil];
//        }else if (type == 2){
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dayChanged:) name:@"DayChanged" object:nil];
//        }
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    lastTouchY = point.y;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
        
    if (point.y - lastTouchY > 1) {//down
        lastTouchY = point.y;
        [self moveDown];
    }else if (lastTouchY - point.y > 1){//up
        lastTouchY = point.y;
        [self moveUp];
    }
}

#pragma mark - ButtonClick

- (void) buttonClick:(UIButton *)button{
    if (button.tag == 0) {
        //up
        [self moveUp];
    }else{
        //down
        [self moveDown];
    }
}

#pragma mark - Utils

- (void) moveUp{
    int midNum = -1;
    topLabel.text = middleLabel.text;
    middleLabel.text = bottomLabel.text;
    NSString * str;
    if (type == 1) {
        midNum = [[middleLabel.text stringByReplacingOccurrencesOfString:@"月" withString:@""] intValue];
        str = [bottomLabel.text stringByReplacingOccurrencesOfString:@"月" withString:@""];
    }else{
        midNum = middleLabel.text.intValue;
        str = bottomLabel.text;
    }
    
    int num = str.intValue;
    num++;
    if (num > maxNum) {
        num = minNum;
    }
    bottomLabel.text = type == 1?[NSString stringWithFormat:@"%d月",num]:[NSString stringWithFormat:@"%d",num];
    
    //year month day
    if (type == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YearChanged" object:[NSNumber numberWithInt:midNum]];
        [DateManager setCurrentYear:midNum];
    }else if (type == 1){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MonthChanged" object:[NSNumber numberWithInt:midNum]];
        [DateManager setCurrentMonth:midNum];
    }else if (type == 2){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DayChanged" object:[NSNumber numberWithInt:midNum]];
        [DateManager setCurrentDay:midNum];
    }
}

- (void) moveDown{
    int midNum = -1;
    bottomLabel.text = middleLabel.text;
    middleLabel.text = topLabel.text;
    NSString * str;
    if (type == 1) {
        midNum = [[middleLabel.text stringByReplacingOccurrencesOfString:@"月" withString:@""] intValue];
        str = [topLabel.text stringByReplacingOccurrencesOfString:@"月" withString:@""];
    }else{
        midNum = middleLabel.text.intValue;
        str = topLabel.text;
    }
    int num = str.intValue;
    num--;
    if (num < minNum) {
        num = maxNum;
    }
    topLabel.text = type == 1?[NSString stringWithFormat:@"%d月",num]:[NSString stringWithFormat:@"%d",num];
    
    //year month day
    if (type == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YearChanged" object:[NSNumber numberWithInt:midNum]];
        [DateManager setCurrentYear:midNum];
    }else if (type == 1){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MonthChanged" object:[NSNumber numberWithInt:midNum]];
        [DateManager setCurrentMonth:midNum];
    }else if (type == 2){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DayChanged" object:[NSNumber numberWithInt:midNum]];
        [DateManager setCurrentDay:midNum];
    }
}

#pragma mark - Notification

- (void) yearChanged:(NSNotification *)notificaton{
    id obj = [notificaton object];
    int num = [obj intValue];
    [DateManager setCurrentYear:num];
    
    if (type == 2 && [DateManager currentMonth] == 2) {
        
        BOOL isforthYear = NO;
        if ([DateManager currentYear]%4 == 0) {
            maxNum = 29;
            isforthYear = YES;
        }else{
            maxNum = 28;
        }
        
        if (topLabel.text.intValue == 27) {
            if (isforthYear) {
                bottomLabel.text = @"29";
            }else{
                bottomLabel.text = @"1";
            }
        }else if (topLabel.text.intValue == 28) {
            if (isforthYear) {
                middleLabel.text = @"29";
                bottomLabel.text = @"1";
            }else{
                middleLabel.text = @"1";
                bottomLabel.text = @"2";
            }
        }else if (topLabel.text.intValue == 29) {
            if (isforthYear) {
                middleLabel.text = @"1";
                bottomLabel.text = @"2";
            }else{
                topLabel.text = @"28";
                middleLabel.text = @"1";
                bottomLabel.text = @"2";
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DayChanged" object:[NSNumber numberWithInt:middleLabel.text.intValue]];
        [DateManager setCurrentDay:middleLabel.text.intValue];
    }
}

- (void) monthChanged:(NSNotification *)notificaton{
    id obj = [notificaton object];
    int num = [obj intValue];
    [DateManager setCurrentMonth:num];
    if (type == 2) {
        if (num == 1 || num == 3 || num == 5 || num == 7 || num == 8 || num == 10 || num == 12) {
            maxNum = 31;
            
            if (bottomLabel.text.intValue == 1) {
                middleLabel.text = @"31";
                topLabel.text = @"30";
            }else if (middleLabel.text.intValue == 1) {
                topLabel.text = @"31";
                bottomLabel.text = @"2";
            }
        }else if (num == 2){
            
            BOOL isforthYear = NO;
            if ([DateManager currentYear]%4 == 0) {
                maxNum = 29;
                isforthYear = YES;
            }else{
                maxNum = 28;
            }
            
            if (topLabel.text.intValue == 27) {
                if (isforthYear) {
                    bottomLabel.text = @"29";
                }else{
                    bottomLabel.text = @"1";
                }
            }else if (topLabel.text.intValue == 28) {
                if (isforthYear) {
                    middleLabel.text = @"29";
                    bottomLabel.text = @"1";
                }else{
                    middleLabel.text = @"1";
                    bottomLabel.text = @"2";
                }
            }else if (topLabel.text.intValue == 29 || topLabel.text.intValue == 30 || topLabel.text.intValue == 31) {
                if (isforthYear) {
                    topLabel.text = @"29";
                    middleLabel.text = @"1";
                    bottomLabel.text = @"2";
                }else{
                    topLabel.text = @"28";
                    middleLabel.text = @"1";
                    bottomLabel.text = @"2";
                }
            }
            
        }else{
            maxNum = 30;
            
            if (bottomLabel.text.intValue == 1) {
                topLabel.text = @"29";
                middleLabel.text = @"30";
            }else if (middleLabel.text.intValue == 1) {
                topLabel.text = @"30";
                bottomLabel.text = @"2";
            }
        }
    }
}

- (void) dayChanged:(NSNotification *)notificaton{
    id obj = [notificaton object];
    int num = [obj intValue];
    [DateManager setCurrentDay:num];
}

@end
