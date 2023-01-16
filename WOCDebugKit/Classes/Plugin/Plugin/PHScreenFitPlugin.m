//
//  PHScreenFitPlugin.m
//  MamaDebugBuilder
//
//  Created by 妈妈网 on 2021/9/15.
//  Copyright © 2021 mamawangtanxl. All rights reserved.
//

#import "PHScreenFitPlugin.h"
#import "DoraemonUtil.h"
#import "PHScreenFitViewController.h"

@implementation PHScreenFitPlugin

- (void)pluginDidLoad{
    PHScreenFitViewController *vc = [[PHScreenFitViewController alloc] init];
    [DoraemonUtil openPlugin:vc];
}

@end
