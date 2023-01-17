//
//  UIView+LSCategory.m
//  LSTableTool_Example
//
//  Created by liaoshen on 2022/11/16.
//  Copyright © 2022 git. All rights reserved.
//

#import "UIView+LSCategory.h"

@implementation UIView (LSCategory)
#pragma mark - 手势
// 添加单击手势
- (void)mm_addTapGestureWithTarget:(id)target action:(SEL)action
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tapGesture];
}

// 添加滑动手势
- (void)mm_addPanGestureWithTarget:(id)target action:(SEL)action
{
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *tapGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tapGesture];
}

@end
