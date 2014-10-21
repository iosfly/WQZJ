//
//  CustomRadioButtonView.m
//  Test
//
//  Created by Peter on 14-10-20.
//  Copyright (c) 2014年 etangdu. All rights reserved.
//

#import "CustomRadioButtonView.h"

#import "Define.h"

#define CustomRadioButtonViewRowHeight 48
#define CustomRadioButtonViewInfoViewWidth 280

@implementation CustomRadioButtonView

- (id)initWithTitle:(NSString *)title
         infoTitles:(NSArray *)infoTitleArray
      selectedIndex:(int)index{
    
    return [self initWithTitle:title
                    infoTitles:infoTitleArray
                 selectedIndex:index identifier:nil];
}

- (id)initWithTitle:(NSString *)title
         infoTitles:(NSArray *)infoTitleArray
      selectedIndex:(int)index
         identifier:(NSString *)identifier
{
    self = [super initWithFrame:ScreenBounds];
    if (self) {
        
        //data
        self.identifier = identifier;
        currentSelectedIndex = index;
        dataArray = [NSMutableArray arrayWithArray:infoTitleArray];
        
        //半透明黑色背景
        UIView * blackAlphaView = [[UIView alloc] initWithFrame:self.bounds];
        blackAlphaView.backgroundColor = [UIColor blackColor];
        blackAlphaView.alpha = 0.5;
        [self addSubview:blackAlphaView];
        
        UITapGestureRecognizer * blackTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackAlphaViewTap)];
        [blackAlphaView addGestureRecognizer:blackTap];
        
        float maxInfoViewHeight = ScreenHeight - StatusBarHeight - 16;
        maxInfoViewHeight = MIN(maxInfoViewHeight, (dataArray.count + 1) * CustomRadioButtonViewRowHeight);
        
        float infoBottomViewFrameY = (ScreenHeight - StatusBarHeight - maxInfoViewHeight)/2;
        if (isOverIOS7) {
            infoBottomViewFrameY += StatusBarHeight;
        }
        
        //展示信息的底部view
        UIView * infoBottomView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width - CustomRadioButtonViewInfoViewWidth)/2,
                                                                           infoBottomViewFrameY,
                                                                           CustomRadioButtonViewInfoViewWidth,
                                                                           maxInfoViewHeight)];
        infoBottomView.backgroundColor = [UIColor whiteColor];
        infoBottomView.layer.cornerRadius = 2.0f;
        infoBottomView.clipsToBounds = YES;
        [self addSubview:infoBottomView];
        
        //标题
        
        //顶部蓝色背景
        UIView * titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, infoBottomView.bounds.size.width, CustomRadioButtonViewRowHeight)];
        titleBgView.backgroundColor = ThemeColor;
        [infoBottomView addSubview:titleBgView];
        
        //蓝色线
        UIView * darkBlueLineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleBgView.bounds.size.height - 1, titleBgView.bounds.size.width, 1)];
        darkBlueLineView.backgroundColor = RGBColor(55, 157, 230);
        [infoBottomView addSubview:darkBlueLineView];
        
        //标题文字
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleBgView.bounds.size.width - 20, CustomRadioButtonViewRowHeight)];
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
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CustomRadioButtonViewRowHeight,
                                                                    infoBottomView.bounds.size.width,
                                                                    infoBottomView.bounds.size.height - CustomRadioButtonViewRowHeight)];
        myTableView.backgroundColor = [UIColor clearColor];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.bounces = NO;
        if (isOverIOS7) {
            myTableView.separatorInset = UIEdgeInsetsZero;
        }
        [infoBottomView addSubview:myTableView];
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
        
        UIView * selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, myTableView.bounds.size.width, CustomRadioButtonViewRowHeight)];
        selectedView.backgroundColor = ThemeColor;
        cell.selectedBackgroundView = selectedView;
    }
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    float maxWidth = myTableView.bounds.size.width - 20;
    if (currentSelectedIndex >= 0 && currentSelectedIndex == indexPath.row) {
        
        UIImageView * tagIv = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.bounds.size.width - 30 - 10, (CustomRadioButtonViewRowHeight - 30)/2, 30, 30)];
        [tagIv setImage:[UIImage imageNamed:@"image_tag_radio.png"]];
        [cell.contentView addSubview:tagIv];
        
        maxWidth = tagIv.frame.origin.x;
    }
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, maxWidth, CustomRadioButtonViewRowHeight)];
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
    return CustomRadioButtonViewRowHeight;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (currentSelectedIndex < 0) {
        [self dismiss];
    }else{
        currentSelectedIndex = indexPath.row;
        [tableView reloadData];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.1];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customRadioButtonViewDidSelectedWithTitle:selectedIndex:)]) {
        [self.delegate customRadioButtonViewDidSelectedWithTitle:[dataArray objectAtIndex:indexPath.row] selectedIndex:currentSelectedIndex];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customRadioButtonViewDidSelectedWithTitle:selectedIndex:customRadioButtonView:)]) {
        [self.delegate customRadioButtonViewDidSelectedWithTitle:[dataArray objectAtIndex:indexPath.row] selectedIndex:currentSelectedIndex customRadioButtonView:self];
    }
}

#pragma mark - 

- (void) blackAlphaViewTap{
    [self dismiss];
}

@end
