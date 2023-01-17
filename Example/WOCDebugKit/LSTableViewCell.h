//
//  LSTableViewCell.h
//  LSTableTool_Example
//
//  Created by liaoshen on 2022/11/16.
//  Copyright © 2022 git. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCEazyTableViewCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSTableViewCell : UITableViewCell <SCEazyTableViewCellProtocol>
@property (nonatomic, strong) UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
