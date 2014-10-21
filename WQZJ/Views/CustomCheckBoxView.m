//
//  CustomCheckBoxView.m
//  WQZJ
//
//  Created by J on 14-10-20.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "CustomCheckBoxView.h"

#import "Define.h"

#define CustomCheckBoxViewRowHeight 48
#define CustomCheckBoxViewInfoViewWidth 280

@implementation CustomCheckBoxView

- (id)initWithTitle:(NSString *)title textArray:(NSArray *)textArray indexArray:(NSArray *)indexArray{
    return [self initWithTitle:title textArray:textArray indexArray:indexArray identifier:nil];
}

- (id)initWithTitle:(NSString *)title textArray:(NSArray *)textArray indexArray:(NSArray *)indexArray identifier:(NSString *)identifier{
    self = [super initWithFrame:ScreenBounds];
    if (self) {
        
        self.identifier = identifier;
        dataArray = [NSMutableArray arrayWithArray:textArray];
        selectedIndexArray = [NSMutableArray arrayWithArray:indexArray];
        
        //半透明黑色背景
        UIView * blackAlphaView = [[UIView alloc] initWithFrame:self.bounds];
        blackAlphaView.backgroundColor = [UIColor blackColor];
        blackAlphaView.alpha = 0.5;
        [self addSubview:blackAlphaView];
        
        UITapGestureRecognizer * blackTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackAlphaViewTap)];
        [blackAlphaView addGestureRecognizer:blackTap];
        
        float maxInfoViewHeight = ScreenHeight - StatusBarHeight - 16;
        maxInfoViewHeight = MIN(maxInfoViewHeight, (dataArray.count + 2) * CustomCheckBoxViewRowHeight);
        
        float infoBottomViewFrameY = (ScreenHeight - StatusBarHeight - maxInfoViewHeight)/2;
        infoBottomViewFrameY += StatusBarHeight;
        
        //展示信息的底部view
        UIView * infoBottomView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width - CustomCheckBoxViewInfoViewWidth)/2,
                                                                           infoBottomViewFrameY,
                                                                           CustomCheckBoxViewInfoViewWidth,
                                                                           maxInfoViewHeight)];
        infoBottomView.backgroundColor = [UIColor whiteColor];
        infoBottomView.layer.cornerRadius = 2.0f;
        infoBottomView.clipsToBounds = YES;
        [self addSubview:infoBottomView];
        
        //标题
        
        //顶部蓝色背景
        UIView * titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, infoBottomView.bounds.size.width, CustomCheckBoxViewRowHeight)];
        titleBgView.backgroundColor = ThemeColor;
        [infoBottomView addSubview:titleBgView];
        
        //蓝色线
        UIView * darkBlueLineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleBgView.bounds.size.height - 1, titleBgView.bounds.size.width, 1)];
        darkBlueLineView.backgroundColor = RGBColor(55, 157, 230);
        [infoBottomView addSubview:darkBlueLineView];
        
        //标题文字
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleBgView.bounds.size.width - 20, CustomCheckBoxViewRowHeight)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = title;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.shadowColor = [UIColor blackColor];
        titleLabel.shadowOffset = CGSizeMake(0, 1);
        titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        titleLabel.minimumScaleFactor = 0.5;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        [infoBottomView addSubview:titleLabel];
        
        //tableview
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CustomCheckBoxViewRowHeight,
                                                                    infoBottomView.bounds.size.width,
                                                                    infoBottomView.bounds.size.height - CustomCheckBoxViewRowHeight * 2)];
        myTableView.backgroundColor = [UIColor clearColor];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.bounces = NO;
        if (isOverIOS7) {
            myTableView.separatorInset = UIEdgeInsetsZero;
        }
        [infoBottomView addSubview:myTableView];
        
        //灰色线
        UIView * darkGrayLineView = [[UIView alloc] initWithFrame:CGRectMake(0, infoBottomView.bounds.size.height - CustomCheckBoxViewRowHeight - 1, infoBottomView.bounds.size.width, 1)];
        darkGrayLineView.backgroundColor = [UIColor lightGrayColor];
        darkGrayLineView.alpha = 0.5;
        [infoBottomView addSubview:darkGrayLineView];
        
        //下面按钮
        
        CGSize buttonSize = CGSizeMake(120, 36);
        float buttonSpace = (infoBottomView.bounds.size.width - buttonSize.width * 2)/3;
        
        //左边按钮

        UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(buttonSpace, myTableView.frame.origin.y + myTableView.bounds.size.height + (CustomCheckBoxViewRowHeight - buttonSize.height)/2, buttonSize.width, buttonSize.height);
        [leftButton setImage:[UIImage imageNamed:@"btn_short_gray_normal.png"] forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"btn_short_blue_pressed.png"] forState:UIControlStateHighlighted];
        [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [infoBottomView addSubview:leftButton];
        
        UILabel * leftLabel = [[UILabel alloc] initWithFrame:leftButton.frame];
        leftLabel.backgroundColor = [UIColor clearColor];
        leftLabel.text = selectedIndexArray.count >= dataArray.count?@"全不选":@"全选";
        leftLabel.textColor = [UIColor blackColor];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.font = [UIFont systemFontOfSize:18.0f];
        [infoBottomView addSubview:leftLabel];
        
        //右边按钮
        float rightButtonFrameX = infoBottomView.bounds.size.width - buttonSpace - buttonSize.width;
        UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(rightButtonFrameX,leftButton.frame.origin.y,
                                       buttonSize.width, buttonSize.height);
        
        [rightButton setImage:[UIImage imageNamed:@"btn_short_blue_normal.png"] forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"btn_short_blue_pressed.png"] forState:UIControlStateHighlighted];
        [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [infoBottomView addSubview:rightButton];
        
        UILabel * rightLabel = [[UILabel alloc] initWithFrame:rightButton.frame];
        rightLabel.backgroundColor = [UIColor clearColor];
        rightLabel.text = @"确定";
        rightLabel.textColor = [UIColor whiteColor];
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.font = [UIFont systemFontOfSize:18.0f];
        [infoBottomView addSubview:rightLabel];
        
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


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        
        UIView * selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, myTableView.bounds.size.width, CustomCheckBoxViewRowHeight)];
        selectedView.backgroundColor = ThemeColor;
        cell.selectedBackgroundView = selectedView;
    }
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIImageView * tagIv = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.bounds.size.width - 48 - 5, 0, 48, 48)];
    BOOL isSelected = NO;
    for (NSNumber * num in selectedIndexArray) {
        if (num.intValue == indexPath.row) {
            isSelected = YES;
            break;
        }
    }
    [tagIv setImage:[UIImage imageNamed:isSelected?@"ic_checkbox_selected.png":@"ic_checkbox_unselected.png"]];
    [cell.contentView addSubview:tagIv];

    float maxWidth = tagIv.frame.origin.x;
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, maxWidth, CustomCheckBoxViewRowHeight)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [dataArray objectAtIndex:indexPath.row];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.minimumScaleFactor = 0.5;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    [cell.contentView addSubview:titleLabel];
    
    return cell;
}

#pragma mark - UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CustomCheckBoxViewRowHeight;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    BOOL add = YES;
    for (NSNumber * num in selectedIndexArray) {
        if (num.intValue == indexPath.row) {
            [selectedIndexArray removeObject:num];
            add = NO;
            break;
        }
    }
    
    if (add) {
        [selectedIndexArray addObject:[NSNumber numberWithInt:indexPath.row]];
    }
    
    [myTableView reloadData];
}

#pragma mark - Button Click

- (void) leftButtonClick{
    [selectedIndexArray removeAllObjects];
    
    if (selectedIndexArray.count < dataArray.count) {
        for (int i = 0; i < dataArray.count; i++) {
            [selectedIndexArray addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCheckBoxViewDidSelectedWithIndexArray:)]) {
        [self.delegate customCheckBoxViewDidSelectedWithIndexArray:selectedIndexArray];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCheckBoxViewDidSelectedWithIndexArray:customCheckBoxView:)]) {
        [self.delegate customCheckBoxViewDidSelectedWithIndexArray:selectedIndexArray customCheckBoxView:self];
    }
    
    [self dismiss];
}

- (void) rightButtonClick{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCheckBoxViewDidSelectedWithIndexArray:)]) {
        [self.delegate customCheckBoxViewDidSelectedWithIndexArray:selectedIndexArray];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCheckBoxViewDidSelectedWithIndexArray:customCheckBoxView:)]) {
        [self.delegate customCheckBoxViewDidSelectedWithIndexArray:selectedIndexArray customCheckBoxView:self];
    }
    
    [self dismiss];
}

- (void) blackAlphaViewTap{
    [self dismiss];
}

@end
