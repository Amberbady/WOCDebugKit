//
//  LSSCEventProxy.m
//  LSTableTool_Example
//
//  Created by liaoshen on 2022/11/16.
//  Copyright © 2022 git. All rights reserved.
//

#import "LSSCEventProxy.h"

NSString *const kEventProxyRequest = @"kEventProxyRequest";

@interface LSSCEventProxy ()

@property (nonatomic, strong) NSDictionary *tempEventProxy;

@end

@implementation LSSCEventProxy

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.eventStrategy = self.tempEventProxy;
    }
    return self;
}

- (NSDictionary *)tempEventProxy{
    if (!_tempEventProxy) {
        _tempEventProxy = @{
            kEventProxyRequest:[self createInvocationForSelector:@selector(requestData)],
        };
    }
    return _tempEventProxy;
}

- (void)requestData{
    if (self.vm.didCellSelect){
        self.vm.didCellSelect();
    }
}


@end
