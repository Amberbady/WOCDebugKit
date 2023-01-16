//
//  UIScreen+PHScreenFitResize.h
//  MamaDebugBuilder
//
//  Created by 妈妈网 on 2021/9/15.
//  Copyright © 2021 mamawangtanxl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PHScreenFitType) {
    PHScreenFitTypeNone = 0,
    PHScreenFitType_iPhone6 = 1,
    PHScreenFitType_iPhone6Plus = 2,
    PHScreenFitType_iPhoneSE = 3,
    PHScreenFitType_iPhoneX = 4,
    PHScreenFitType_iPhoneXR = 5,
    PHScreenFitType_iPhone12mini = 6,
    PHScreenFitType_iPhone12 = 7,
    PHScreenFitType_iPhone12ProMax = 8,
};

@interface UIScreen (PHScreenFitResize)

+ (void)swizzleScreenFitWithScreenType:(PHScreenFitType)screenType;

- (CGRect)screenFit_bounds;

@end

NS_ASSUME_NONNULL_END
