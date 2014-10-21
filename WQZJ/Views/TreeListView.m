//
//  TreeListView.m
//  TTT
//
//  Created by Peter on 14-10-16.
//  Copyright (c) 2014年 etangdu. All rights reserved.
//

#import "TreeListView.h"
#import "Define.h"

@implementation TreeListView

- (id) initWithArray:(NSMutableArray *)array currentSelectedID:(int)selectedID
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        UIView * bottomView = [[UIView alloc] initWithFrame:self.bounds];
        bottomView.backgroundColor = [UIColor blackColor];
        bottomView.alpha = 0.5;
        [self addSubview:bottomView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTap)];
        [bottomView addGestureRecognizer:tap];
        
        
        float titleViewHeight = 48.0f;
        infoBottomView = [[UIView alloc] initWithFrame:CGRectMake(20, (self.bounds.size.height - 20 - titleViewHeight)/2, self.bounds.size.width - 40, titleViewHeight)];
        infoBottomView.backgroundColor = [UIColor whiteColor];
        infoBottomView.layer.cornerRadius = 2.0f;
        infoBottomView.clipsToBounds = YES;
        [self addSubview:infoBottomView];
        
        titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, infoBottomView.bounds.size.width, titleViewHeight)];
        titleView.backgroundColor = ThemeColor;
        [infoBottomView addSubview:titleView];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleView.bounds.size.width - 20, titleView.bounds.size.height)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = @"选择机构";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.shadowColor = [UIColor blackColor];
        titleLabel.shadowOffset = CGSizeMake(0, 1);
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [titleView addSubview:titleLabel];
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, titleView.bounds.size.height + 8, infoBottomView.bounds.size.width, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.bounces = NO;
        table.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [infoBottomView addSubview:table];
        
        currentSelectedID = selectedID;
        oriDataArray = [NSMutableArray arrayWithArray:array];
        showDataArray = [NSMutableArray array];
        [self calculateShowDataWithAnimation:NO];
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
    return showDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIdentifier = @"cellIdentifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
        view.backgroundColor = ThemeColor;
        cell.selectedBackgroundView = view;
    }
    
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSDictionary * dic = [showDataArray objectAtIndex:indexPath.row];
    int level = [[dic valueForKey:@"level"] intValue];
    
    if ([dic valueForKey:@"status"]) {
        BOOL isShow = [[dic valueForKey:@"status"] boolValue];
        UIImageView * statusIv = [[UIImageView alloc] initWithFrame:CGRectMake((level - 1) * 20, 0, 32, 32)];
        [statusIv setImage:[UIImage imageNamed:isShow?@"hide.png":@"show.png"]];
        [cell.contentView addSubview:statusIv];
    }
    
    float labelFrameX = 32 + (level - 1) * 20;
    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelFrameX, 0, table.bounds.size.width - labelFrameX - 32, 32)];
    textLabel.text = [dic valueForKey:@"name"];
    [cell.contentView addSubview:textLabel];
    
    UIButton * checkBoxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBoxButton.frame = CGRectMake(infoBottomView.bounds.size.width - 32 - 5, 0, 32, 32);
    checkBoxButton.tag = [[dic valueForKey:@"id"] intValue];
    BOOL isCheck = checkBoxButton.tag == currentSelectedID;
    [checkBoxButton setImage:[UIImage imageNamed:isCheck?@"checkbox_on.png":@"checkbox_off.png"] forState:UIControlStateNormal];
    [checkBoxButton addTarget:self action:@selector(checkBoxButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:checkBoxButton];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 32.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSDictionary * dic = [showDataArray objectAtIndex:indexPath.row];
    int selectedID = [[dic valueForKey:@"id"] intValue];
    
    [self changeStatusWithID:selectedID];
}

#pragma mark - ButtonClick

- (void) checkBoxButtonClick:(UIButton *)button{
    currentSelectedID = button.tag;
    
    [self dismiss];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(treeListViewDidSelectedWithSelectedID:)]) {
        [self.delegate treeListViewDidSelectedWithSelectedID:currentSelectedID];
    }
}

#pragma mark - Utils

- (void) changeStatusWithID:(int)selectedID{
    BOOL canBreak = NO;

    //level1
    for (NSDictionary * firstdic in oriDataArray) {
        int oriID = [[firstdic valueForKey:@"id"] intValue];
        if (selectedID == oriID) {
            if ([firstdic valueForKey:@"status"]) {
                BOOL status = [[firstdic valueForKey:@"status"] boolValue];
                [firstdic setValue:[NSNumber numberWithBool:!status] forKey:@"status"];
                [self calculateShowDataWithAnimation:YES];
                
                //将下级全部收起来
                if (status) {
                    for (NSDictionary * secondDic in [firstdic valueForKey:@"objs"]) {
                        if ([secondDic valueForKey:@"status"]) {
                            [secondDic setValue:[NSNumber numberWithBool:!status] forKey:@"status"];
                        }
                        for (NSDictionary * thirdDic in [secondDic valueForKey:@"objs"]) {
                            if ([thirdDic valueForKey:@"status"]) {
                                [thirdDic setValue:[NSNumber numberWithBool:!status] forKey:@"status"];
                            }
                        }
                    }
                }
            }
            canBreak = YES;
            
            break;
        }
    }
    
    //level2
    if (!canBreak) {
        for (NSDictionary * firstDic in oriDataArray) {
            if ([firstDic valueForKey:@"objs"]) {
                for (NSDictionary * secondDic in [firstDic valueForKey:@"objs"]) {
                    int oriID = [[secondDic valueForKey:@"id"] intValue];
                    if (selectedID == oriID) {
                        if ([secondDic valueForKey:@"status"]) {
                            BOOL status = [[secondDic valueForKey:@"status"] boolValue];
                            [secondDic setValue:[NSNumber numberWithBool:!status] forKey:@"status"];
                            [self calculateShowDataWithAnimation:YES];
                            
                            //将下级全部收起来
                            if (status) {
                                for (NSDictionary * thirdDic in [secondDic valueForKey:@"objs"]) {
                                    if ([thirdDic valueForKey:@"status"]) {
                                        [thirdDic setValue:[NSNumber numberWithBool:!status] forKey:@"status"];
                                    }
                                }
                            }
                            
                        }
                        canBreak = YES;
                        break;
                    }
                }
            }
            
            if (canBreak) {
                break;
            }
        }
    }
    
    //level3
    if (!canBreak) {
        for (NSDictionary * firstDic in oriDataArray) {
            if ([firstDic valueForKey:@"objs"]) {
                for (NSDictionary * secondDic in [firstDic valueForKey:@"objs"]) {
                    
                    if ([secondDic valueForKey:@"objs"]) {
                        for (NSDictionary * thirdDic in [secondDic valueForKey:@"objs"]) {
                            int oriID = [[thirdDic valueForKey:@"id"] intValue];
                            if (selectedID == oriID) {
                                if ([thirdDic valueForKey:@"status"]) {
                                    BOOL status = [[thirdDic valueForKey:@"status"] boolValue];
                                    [thirdDic setValue:[NSNumber numberWithBool:!status] forKey:@"status"];
                                    [self calculateShowDataWithAnimation:YES];
                                }
                                canBreak = YES;
                                break;
                            }
                        }
                    }
                    
                    if (canBreak) {
                        break;
                    }
                }
            }
            
            if (canBreak) {
                break;
            }
        }
    }
}

- (void) calculateShowDataWithAnimation:(BOOL)animation{
    [showDataArray removeAllObjects];
    for (NSDictionary * dic in oriDataArray) {
        [self addDic:dic];
    }
    
    [table reloadData];
    
    float duration = 0;
    if (animation) {
        duration = 0.2;
    }
    
    [UIView animateWithDuration:duration animations:^{
        CGRect infoBottomViewFrame = infoBottomView.frame;
        infoBottomViewFrame.size.height = showDataArray.count > 14?(self.bounds.size.height - 20 - 20):(showDataArray.count * 32 + 16 + titleView.bounds.size.height);
        infoBottomViewFrame.origin.y = 20 + (self.bounds.size.height - 20 - infoBottomViewFrame.size.height)/2;
        infoBottomView.frame = infoBottomViewFrame;
        
        CGRect tableFrame = table.frame;
        tableFrame.size.height = infoBottomView.bounds.size.height - titleView.bounds.size.height - 16;
        table.frame = tableFrame;
    }];
}

- (void) addDic:(NSDictionary *)dic{
    if ([dic valueForKey:@"objs"]) {
        [showDataArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [dic valueForKey:@"name"],@"name",
                                  [dic valueForKey:@"level"],@"level",
                                  [dic valueForKey:@"status"],@"status",
                                  [dic valueForKey:@"id"],@"id",nil]];
        if ([[dic valueForKey:@"status"] boolValue]) {
            for (NSDictionary * subdic in [dic valueForKey:@"objs"]) {
                [self addDic:subdic];
            }
        }
    }else{
        [showDataArray addObject:dic];
    }
}

@end
