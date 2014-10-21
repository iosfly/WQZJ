//
//  CustomTabbarView.h
//  WQZJ
//
//  Created by J on 14-10-15.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabbarView : UIView

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;

- (id)initWithOrigin:(CGPoint)origin highlightIndex:(int)index;

@end
