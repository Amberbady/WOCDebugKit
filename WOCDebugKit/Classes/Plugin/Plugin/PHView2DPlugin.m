//
//  PHView2DPlugin.m
//  MamaDebugBuilder
//
//  Created by tanxl on 2020/1/10.
//  Copyright © 2020 mamawangtanxl. All rights reserved.
//

#import "PHView2DPlugin.h"

@implementation PHView2DPlugin

- (void)pluginDidLoad{
    [[DoraemonManager shareInstance] hiddenHomeWindow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_2D" object:nil];
    });
}

@end
