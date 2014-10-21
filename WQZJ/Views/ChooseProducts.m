//
//  ChooseProducts.m
//  WQZJ
//
//  Created by J on 14-10-17.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "ChooseProducts.h"

#import "Define.h"

@implementation ChooseProducts

- (id)initWithSelectedIndexArray:(NSArray *)array
{
    self = [super initWithFrame:ScreenBounds];
    if (self) {
        
        selectedArray = [NSMutableArray arrayWithArray:array];
        
        dataArray = [NSMutableArray arrayWithObjects:
                     @"三鲜鸡精40*227克",
                     @"蔬之鲜25*400克",
                     @"芝麻油24*230毫升",
                     @"鲜贝露调味汁12*500毫升",
                     @"美极鲜鸡精20*450克",
                     @"天天旺鸡精调味料40*200g", nil];
        
        UIView * bottomView = [[UIView alloc] initWithFrame:self.bounds];
        bottomView.backgroundColor = [UIColor blackColor];
        bottomView.alpha = 0.5;
        [self addSubview:bottomView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTap)];
        [bottomView addGestureRecognizer:tap];
        
        float titleViewHeight = 48.0f;
        UIView * infoBottomView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width - 280)/2, 20 + (self.bounds.size.height - 20 - 384)/2, 280, 390)];
        infoBottomView.backgroundColor = [UIColor whiteColor];
        infoBottomView.layer.cornerRadius = 2.0f;
        infoBottomView.clipsToBounds = YES;
        [self addSubview:infoBottomView];
        
        UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, infoBottomView.bounds.size.width, titleViewHeight)];
        titleView.backgroundColor = ThemeColor;
        [infoBottomView addSubview:titleView];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleView.bounds.size.width - 20, titleView.bounds.size.height)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = @"选择产品";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.shadowColor = [UIColor blackColor];
        titleLabel.shadowOffset = CGSizeMake(0, 1);
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [titleView addSubview:titleLabel];
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, titleView.bounds.size.height, infoBottomView.bounds.size.width, infoBottomView.bounds.size.height - titleView.bounds.size.height - 50)];
        table.scrollEnabled = NO;
        table.bounces = NO;
        if (isOverIOS7) {
            table.separatorInset = UIEdgeInsetsZero;
        }
        table.dataSource = self;
        table.delegate = self;
        [infoBottomView addSubview:table];
        
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 336, infoBottomView.bounds.size.width, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.alpha = 0.5;
        [infoBottomView addSubview:lineView];
        
        UIButton * selectedAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedAllButton.frame = CGRectMake(13, 346, 120, 36);
        [selectedAllButton setImage:[UIImage imageNamed:@"btn_gray_nor.png"] forState:UIControlStateNormal];
        [selectedAllButton setImage:[UIImage imageNamed:@"btn_blue_sel.png"] forState:UIControlStateHighlighted];
        [selectedAllButton addTarget:self action:@selector(selectedAllButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [infoBottomView addSubview:selectedAllButton];
        
        UILabel * selectedAllLabel = [[UILabel alloc] initWithFrame:selectedAllButton.frame];
        selectedAllLabel.backgroundColor = [UIColor clearColor];
        selectedAllLabel.text = selectedArray.count == dataArray.count?@"全不选":@"全选";
        selectedAllLabel.textColor = [UIColor grayColor];
        selectedAllLabel.textAlignment = NSTextAlignmentCenter;
        [infoBottomView addSubview:selectedAllLabel];
        
        UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(148, 346, 120, 36);
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


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIdentifier = @"cellIdentifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
        view.backgroundColor = ThemeColor;
        cell.selectedBackgroundView = view;
    }
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, table.bounds.size.width - 20 - 48, 48)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font = [UIFont systemFontOfSize:15.0f];
    textLabel.text = [dataArray objectAtIndex:indexPath.row];
    [cell.contentView addSubview:textLabel];

    BOOL ischeck = NO;
    for (NSNumber * num in selectedArray) {
        if (num.intValue == indexPath.row) {
            ischeck = YES;
            break;
        }
    }
    UIImageView * checkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(table.bounds.size.width - 45, 4, 40, 40)];
    [checkImageView setImage:[UIImage imageNamed:ischeck?@"checkbox_on.png":@"checkbox_off.png"]];
    [cell.contentView addSubview:checkImageView];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    int index = -1;
    for (int i = 0; i < selectedArray.count; i++) {
        if ([[selectedArray objectAtIndex:i] intValue] == indexPath.row) {
            index = i;
            break;
        }
    }
    
    if (index == -1) {
        [selectedArray addObject:[NSNumber numberWithInt:indexPath.row]];
    }else{
        [selectedArray removeObjectAtIndex:index];
    }
    
    [tableView reloadData];
}

#pragma mark -

- (void) selectedAllButtonClick{
    if (selectedArray.count == dataArray.count) {
        [selectedArray removeAllObjects];
    }else{
        [selectedArray removeAllObjects];
        for (int i = 0; i < dataArray.count; i++) {
            [selectedArray addObject:[NSNumber numberWithInt:i]];
        }
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseProductsDidChooseWithIndexArray:)]) {
        [self.delegate chooseProductsDidChooseWithIndexArray:selectedArray];
    }
    
    [self dismiss];
}

- (void) sureButtonClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseProductsDidChooseWithIndexArray:)]) {
        [self.delegate chooseProductsDidChooseWithIndexArray:selectedArray];
    }
    
    [self dismiss];
}

@end
