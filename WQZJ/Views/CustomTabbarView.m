//
//  CustomTabbarView.m
//  WQZJ
//
//  Created by J on 14-10-15.
//  Copyright (c) 2014年 J. All rights reserved.
//

#import "CustomTabbarView.h"
#import "Define.h"

@implementation CustomTabbarView

- (id)initWithOrigin:(CGPoint)origin highlightIndex:(int)index;
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, ScreenWidth, TabbarHeight)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSArray * titleArray = [NSArray arrayWithObjects:@"日常工作", @"管理统计", nil];
        for (int i = 0; i < 2; i++) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(i*self.bounds.size.width/2, 0, self.bounds.size.width/2, self.bounds.size.height)];
            label.backgroundColor = [UIColor clearColor];
            label.text = [titleArray objectAtIndex:i];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:16.0f];
            
            if (i == index) {
                label.textColor = ThemeColor;
            }else{
                label.textColor = [UIColor blackColor];
            }
            
            [self addSubview:label];
        }
    }
    return self;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    int index = 0;
    if (p.x > self.bounds.size.width/2) {
        index = 1;
    }
    
    if (index == 0) {
        if (self.leftBlock) {
            self.leftBlock();
        }
    }else{
        if (self.rightBlock) {
            self.rightBlock();
        }
    }
}

@end
