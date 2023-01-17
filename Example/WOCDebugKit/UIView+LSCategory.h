//
//  UIView+LSCategory.h
//  LSTableTool_Example
//
//  Created by liaoshen on 2022/11/16.
//  Copyright © 2022 git. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LSCategory)
#pragma mark - 手势
/**
 *  添加单击手势
 */
- (void)mm_addTapGestureWithTarget:(id)target action:(SEL)action;

/**
 *  添加滑动手势
 */
- (void)mm_addPanGestureWithTarget:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
