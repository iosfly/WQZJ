//
//  CustomAlertView.h
//  Test
//
//  Created by Peter on 14-10-20.
//  Copyright (c) 2014年 etangdu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;

- (id)initWithTitle:(NSString *)title
               text:(NSString *)text
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rightTitle;

- (void) show;

@end
