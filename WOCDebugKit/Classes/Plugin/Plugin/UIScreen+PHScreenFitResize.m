//
//  UIScreen+PHScreenFitResize.m
//  MamaDebugBuilder
//
//  Created by 妈妈网 on 2021/9/15.
//  Copyright © 2021 mamawangtanxl. All rights reserved.
//

#import "UIScreen+PHScreenFitResize.h"
#import <objc/runtime.h>

@implementation UIScreen (PHScreenFitResize)

+ (void)load {
    
    [NSUserDefaults.standardUserDefaults setInteger:PHScreenFitTypeNone forKey:@"PHScreenFitType"];
}

- (CGRect)screenFit_bounds
{
    PHScreenFitType currenType = [NSUserDefaults.standardUserDefaults integerForKey:@"PHScreenFitType"];
    CGRect bounds = CGRectZero;
    switch (currenType) {
        case PHScreenFitType_iPhone6:
            
            bounds = CGRectMake(0, 0, 375, 667);
            break;
        case PHScreenFitType_iPhone6Plus:
            
            bounds = CGRectMake(0, 0, 414, 736);
            break;
        case PHScreenFitType_iPhoneSE:
            
            bounds = CGRectMake(0, 0, 320, 568);
            break;
        case PHScreenFitType_iPhoneX:
            
            bounds = CGRectMake(0, 0, 375, 812);
            break;
        case PHScreenFitType_iPhoneXR:
            
            bounds = CGRectMake(0, 0, 414, 896);
            break;
        case PHScreenFitType_iPhone12mini:
            
            bounds = CGRectMake(0, 0, 360, 780);
            break;
        case PHScreenFitType_iPhone12:
            
            bounds = CGRectMake(0, 0, 390, 844);
            break;
        case PHScreenFitType_iPhone12ProMax:
            
            bounds = CGRectMake(0, 0, 428, 926);
            break;
        default:
            break;
    }
    return bounds;
}

// Lookin 观察到 Screen 之外 window 的 windowLevel == -100, 改为黑色便于调试
+ (void)refreshWindowBackgroundColor {
    
    for (UIWindow *window in UIApplication.sharedApplication.windows) {
        if (window.windowLevel == -100) {
            
            window.backgroundColor = UIColor.blackColor;
        }
    }
}

+ (void)swizzleScreenFitWithScreenType:(PHScreenFitType)screenType {
    
    [self refreshWindowBackgroundColor];
    
    PHScreenFitType currenType = [NSUserDefaults.standardUserDefaults integerForKey:@"PHScreenFitType"];
    if (currenType == PHScreenFitTypeNone) {
        
        [NSUserDefaults.standardUserDefaults setInteger:screenType forKey:@"PHScreenFitType"];
        [self swizzleInstanceMethod:@selector(bounds) with:@selector(screenFit_bounds)];
    } else {
        
        [self swizzleInstanceMethod:@selector(bounds) with:@selector(screenFit_bounds)];
        [NSUserDefaults.standardUserDefaults setInteger:screenType forKey:@"PHScreenFitType"];
        [self swizzleInstanceMethod:@selector(bounds) with:@selector(screenFit_bounds)];
    }
}

+ (void)swizzleInstanceMethod:(SEL)originalSel with:(SEL)swizzledSel {
    
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSel);
    
    BOOL didAddMethod =
    class_addMethod(self,
                    originalSel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self,
                            swizzledSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end
