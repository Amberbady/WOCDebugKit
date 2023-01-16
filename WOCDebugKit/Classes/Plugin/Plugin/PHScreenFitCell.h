//
//  PHScreenFitCell.h
//  MamaDebugBuilder
//
//  Created by 妈妈网 on 2021/9/15.
//  Copyright © 2021 mamawangtanxl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHScreenFitCell : UITableViewCell

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BOOL isSelected;

+ (instancetype)screenFitCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
