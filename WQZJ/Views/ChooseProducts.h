//
//  ChooseProducts.h
//  WQZJ
//
//  Created by J on 14-10-17.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseProductsDelegate <NSObject>

- (void) chooseProductsDidChooseWithIndexArray:(NSMutableArray *)array;

@end

@interface ChooseProducts : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * table;
    NSMutableArray * dataArray;
    NSMutableArray * selectedArray;
}

@property (nonatomic, assign) id<ChooseProductsDelegate> delegate;

- (id)initWithSelectedIndexArray:(NSArray *)array;
- (void) show;

@end
