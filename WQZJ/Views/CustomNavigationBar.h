//
//  CustomNavigationBar.h
//  WQZJ
//
//  Created by J on 14-10-15.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationBar : UIView

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, copy) dispatch_block_t leftBlock;

- (id)initWithNeedShowLeftButton:(BOOL)show;

@end
