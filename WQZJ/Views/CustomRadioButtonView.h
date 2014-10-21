//
//  CustomRadioButtonView.h
//  Test
//
//  Created by Peter on 14-10-20.
//  Copyright (c) 2014年 etangdu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomRadioButtonView;

@protocol CustomRadioButtonViewDelegate <NSObject>

@optional

- (void) customRadioButtonViewDidSelectedWithTitle:(NSString *)title selectedIndex:(int)index;
- (void) customRadioButtonViewDidSelectedWithTitle:(NSString *)title selectedIndex:(int)index customRadioButtonView:(CustomRadioButtonView *)customRadioButtonView;

@end

@interface CustomRadioButtonView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * myTableView;
    NSMutableArray * dataArray;
    int currentSelectedIndex;
}

@property (nonatomic, assign) id<CustomRadioButtonViewDelegate> delegate;
/*
    标示
 */
@property (nonatomic, strong) NSString * identifier;

/*
    index 传入负数的话就不会显示圆点图片
 */
- (id)initWithTitle:(NSString *)title
         infoTitles:(NSArray *)infoTitleArray
      selectedIndex:(int)index;

- (id)initWithTitle:(NSString *)title
         infoTitles:(NSArray *)infoTitleArray
      selectedIndex:(int)index
         identifier:(NSString *)identifier;

- (void) show;

@end
