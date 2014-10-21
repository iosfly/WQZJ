//
//  ChooseTimeView.m
//  WQZJ
//
//  Created by J on 14-10-17.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "ChooseTimeView.h"

#import "Define.h"

@implementation ChooseTimeView

- (id)initWithSelectedIndex:(int)index
{
    self = [super initWithFrame:ScreenBounds];
    if (self) {
        currentSelectedIndex = index;
        
        dataArray = [NSMutableArray arrayWithObjects:@"今天",@"昨天",@"本周",@"上周",@"本月",@"上月",@"自选起止时间", nil];
        
        UIView * bottomView = [[UIView alloc] initWithFrame:self.bounds];
        bottomView.backgroundColor = [UIColor blackColor];
        bottomView.alpha = 0.5;
        [self addSubview:bottomView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTap)];
        [bottomView addGestureRecognizer:tap];
        
        float titleViewHeight = 48.0f;
        UIView * infoBottomView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width - 280)/2, 20 + (self.bounds.size.height - 20 - 384)/2, 280, 384)];
        infoBottomView.backgroundColor = [UIColor whiteColor];
        infoBottomView.layer.cornerRadius = 2.0f;
        infoBottomView.clipsToBounds = YES;
        [self addSubview:infoBottomView];
        
        UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, infoBottomView.bounds.size.width, titleViewHeight)];
        titleView.backgroundColor = ThemeColor;
        [infoBottomView addSubview:titleView];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleView.bounds.size.width - 20, titleView.bounds.size.height)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = @"选择时间";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.shadowColor = [UIColor blackColor];
        titleLabel.shadowOffset = CGSizeMake(0, 1);
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [titleView addSubview:titleLabel];
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, titleView.bounds.size.height, infoBottomView.bounds.size.width, infoBottomView.bounds.size.height - titleView.bounds.size.height)];
        table.scrollEnabled = NO;
        table.bounces = NO;
        if (isOverIOS7) {
            table.separatorInset = UIEdgeInsetsZero;
        }
        table.dataSource = self;
        table.delegate = self;
        [infoBottomView addSubview:table];
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
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 48)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font = [UIFont systemFontOfSize:15.0f];
    textLabel.text = [dataArray objectAtIndex:indexPath.row];
    textLabel.textColor = [UIColor darkGrayColor];
    [cell.contentView addSubview:textLabel];
    
    if (currentSelectedIndex == indexPath.row) {
        UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(table.bounds.size.width - 48, 0, 48, 48)];
        [iv setImage:[UIImage imageNamed:@"circle.png"]];
        [cell.contentView addSubview:iv];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    currentSelectedIndex = indexPath.row;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseTimeViewDidSelectedWithTitle:index:)]) {
        [self.delegate chooseTimeViewDidSelectedWithTitle:[dataArray objectAtIndex:indexPath.row] index:currentSelectedIndex];
    }
    
    [self dismiss];
}

@end
