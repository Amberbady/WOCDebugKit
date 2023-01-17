//
//  LSTestVM.h
//  LSTableTool_Example
//
//  Created by liaoshen on 2022/11/16.
//  Copyright © 2022 git. All rights reserved.
//

#import <LSTableTool/LSBaseViewModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface LSTestVM : LSBaseViewModel
@property (nonatomic , copy, nullable) dispatch_block_t reloadData;
@property (nonatomic , copy, nullable) dispatch_block_t didCellSelect;
- (void)request;
@end

NS_ASSUME_NONNULL_END
