//
//  LSSCEventProxy.h
//  LSTableTool_Example
//
//  Created by liaoshen on 2022/11/16.
//  Copyright © 2022 git. All rights reserved.
//

#import <LSTableTool/LSTableTool.h>
#import "LSTestVM.h"
NS_ASSUME_NONNULL_BEGIN

@interface LSSCEventProxy : SCEventProxy
@property (nonatomic, strong) LSTestVM *vm;
@end

NS_ASSUME_NONNULL_END
