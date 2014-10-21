//
//  ChooseTimeView.h
//  WQZJ
//
//  Created by J on 14-10-17.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseTimeViewDelegate <NSObject>

- (void) chooseTimeViewDidSelectedWithTitle:(NSString *)title index:(int)index;

@end

@interface ChooseTimeView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * table;
    NSMutableArray * dataArray;
    int currentSelectedIndex;
}

@property (nonatomic, assign) id<ChooseTimeViewDelegate> delegate;

- (id)initWithSelectedIndex:(int)index;
- (void) show;

@end
