//
//  CustomAlertView.m
//  Test
//
//  Created by Peter on 14-10-20.
//  Copyright (c) 2014年 etangdu. All rights reserved.
//

#import "CustomAlertView.h"

#import "Define.h"

@implementation CustomAlertView

- (id)initWithTitle:(NSString *)title
               text:(NSString *)text
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rightTitle
{
    self = [super initWithFrame:ScreenBounds];
    if (self) {
        
        //半透明黑色背景
        UIView * blackAlphaView = [[UIView alloc] initWithFrame:self.bounds];
        blackAlphaView.backgroundColor = [UIColor blackColor];
        blackAlphaView.alpha = 0.5;
        [self addSubview:blackAlphaView];
        
        UITapGestureRecognizer * blackTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackAlphaViewTap)];
        [blackAlphaView addGestureRecognizer:blackTap];
        
        CGSize textSize;
        
//        if (isOverIOS7) {
//            textSize = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
//        }else{
            textSize = [text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(280, MAXFLOAT)];
//        }
        float textLabelHeight = textSize.height + 72;
        float titleLabelHeight = 47;
        float bottomHeight = 51;
        CGSize buttonSize = CGSizeMake(120, 36);
        
        float bottomViewHeight = textLabelHeight + bottomHeight;
        if (title) {
            bottomViewHeight += titleLabelHeight;
        }
        
        //展示信息的底部view
        UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width - 280)/2, (ScreenHeight - StatusBarHeight - bottomViewHeight)/2, 280, bottomViewHeight)];
        bottomView.backgroundColor = [UIColor whiteColor];
        bottomView.layer.cornerRadius = 2.0f;
        bottomView.clipsToBounds = YES;
        [self addSubview:bottomView];
        
        
        //顶部标题
        if (title) {
            //顶部蓝色背景
            UIView * titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottomView.bounds.size.width, titleLabelHeight)];
            titleBgView.backgroundColor = ThemeColor;
            [bottomView addSubview:titleBgView];
            
            //蓝色线
            UIView * darkBlueLineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleBgView.bounds.size.height - 1, titleBgView.bounds.size.width, 1)];
            darkBlueLineView.backgroundColor = RGBColor(55, 157, 230);
            [bottomView addSubview:darkBlueLineView];
            
            //标题文字
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleBgView.bounds.size.width - 20, titleLabelHeight)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.text = title;
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.shadowColor = [UIColor blackColor];
            titleLabel.shadowOffset = CGSizeMake(0, 1);
            titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            titleLabel.minimumScaleFactor = 0.5;
            titleLabel.adjustsFontSizeToFitWidth = YES;
            [bottomView addSubview:titleLabel];
        }
        
        //中间内容
        UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, title?titleLabelHeight:0, bottomView.bounds.size.width - 20, textLabelHeight)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.text = text;
        textLabel.textColor = [UIColor blackColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:17.0f];
        textLabel.numberOfLines = 100000;
        [bottomView addSubview:textLabel];
        
        //灰色线
        UIView * darkGrayLineView = [[UIView alloc] initWithFrame:CGRectMake(0, textLabel.frame.origin.y + textLabel.bounds.size.height - 1, bottomView.bounds.size.width, 1)];
        darkGrayLineView.backgroundColor = [UIColor lightGrayColor];
        darkGrayLineView.alpha = 0.5;
        [bottomView addSubview:darkGrayLineView];
        
        //下面按钮
        int buttonCount = 0;
        if (leftTitle && rightTitle) {
            buttonCount = 2;
        }else if (leftTitle || rightTitle){
            buttonCount = 1;
        }
        
        if (buttonCount == 0) {
            NSLog(@"警告！没有按钮标题");
        }
        
        float buttonSpace = (bottomView.bounds.size.width - buttonSize.width * 2)/3;
        
        //左边按钮
        if (buttonCount == 2) {
            UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftButton.frame = CGRectMake(buttonSpace, textLabel.frame.origin.y + textLabel.bounds.size.height + (bottomHeight - buttonSize.height)/2, buttonSize.width, buttonSize.height);
            [leftButton setImage:[UIImage imageNamed:@"btn_short_gray_normal.png"] forState:UIControlStateNormal];
            [leftButton setImage:[UIImage imageNamed:@"btn_short_blue_pressed.png"] forState:UIControlStateHighlighted];
            [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:leftButton];
            
            UILabel * leftLabel = [[UILabel alloc] initWithFrame:leftButton.frame];
            leftLabel.backgroundColor = [UIColor clearColor];
            leftLabel.text = leftTitle;
            leftLabel.textColor = [UIColor blackColor];
            leftLabel.textAlignment = NSTextAlignmentCenter;
            leftLabel.font = [UIFont systemFontOfSize:18.0f];
            [bottomView addSubview:leftLabel];
        }
        
        //右边按钮
        if (rightTitle || buttonCount == 1) {
            if (!rightTitle) {
                rightTitle = leftTitle;
            }
            
            float rightButtonFrameX = buttonCount == 2?(bottomView.bounds.size.width - buttonSpace - buttonSize.width):((bottomView.bounds.size.width - buttonSize.width)/2);
            UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
            rightButton.frame = CGRectMake(rightButtonFrameX,
                                          textLabel.frame.origin.y + textLabel.bounds.size.height + (bottomHeight - buttonSize.height)/2,
                                          buttonSize.width, buttonSize.height);
            
            [rightButton setImage:[UIImage imageNamed:@"btn_short_blue_normal.png"] forState:UIControlStateNormal];
            [rightButton setImage:[UIImage imageNamed:@"btn_short_blue_pressed.png"] forState:UIControlStateHighlighted];
            [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:rightButton];
            
            UILabel * rightLabel = [[UILabel alloc] initWithFrame:rightButton.frame];
            rightLabel.backgroundColor = [UIColor clearColor];
            rightLabel.text = rightTitle;
            rightLabel.textColor = [UIColor whiteColor];
            rightLabel.textAlignment = NSTextAlignmentCenter;
            rightLabel.font = [UIFont systemFontOfSize:18.0f];
            [bottomView addSubview:rightLabel];
        }
        
    }
    return self;
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

#pragma mark - Button Click

- (void) leftButtonClick{
    if (self.leftBlock) {
        self.leftBlock();
    }
    
    [self dismiss];
}

- (void) rightButtonClick{
    if (self.rightBlock) {
        self.rightBlock();
    }
    
    [self dismiss];
}

- (void) blackAlphaViewTap{
    [self dismiss];
}

@end
