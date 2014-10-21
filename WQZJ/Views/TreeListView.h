//
//  TreeListView.h
//  TTT
//
//  Created by Peter on 14-10-16.
//  Copyright (c) 2014年 etangdu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TreeListViewDelegate <NSObject>

- (void) treeListViewDidSelectedWithSelectedID:(int)selectedID;

@end

@interface TreeListView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIView * infoBottomView;
    UIView * titleView;
    UITableView * table;
    NSMutableArray * showDataArray;
    NSMutableArray * oriDataArray;
    int currentSelectedID;
}

@property (nonatomic, assign) id<TreeListViewDelegate> delegate;

- (id) initWithArray:(NSMutableArray *)array currentSelectedID:(int)selectedID;
- (void) show;

@end
