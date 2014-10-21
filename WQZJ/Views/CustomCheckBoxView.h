//
//  CustomCheckBoxView.h
//  WQZJ
//
//  Created by J on 14-10-20.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomCheckBoxView;

@protocol CustomCheckBoxViewDelegate <NSObject>

@optional

- (void) customCheckBoxViewDidSelectedWithIndexArray:(NSMutableArray *)indexArray;
- (void) customCheckBoxViewDidSelectedWithIndexArray:(NSMutableArray *)indexArray customCheckBoxView:(CustomCheckBoxView *)customCheckBoxView;

@end

@interface CustomCheckBoxView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * myTableView;
    NSMutableArray * dataArray;
    NSMutableArray * selectedIndexArray;
}

@property (nonatomic, assign) id<CustomCheckBoxViewDelegate> delegate;
/*
 标示
 */
@property (nonatomic, strong) NSString * identifier;

/*
 textArray 存 NSString
 indexArray 存 NSNumber (int类型)
 */

- (id)initWithTitle:(NSString *)title textArray:(NSArray *)textArray indexArray:(NSArray *)indexArray;

- (id)initWithTitle:(NSString *)title textArray:(NSArray *)textArray indexArray:(NSArray *)indexArray identifier:(NSString *)identifier;

- (void) show;

@end
