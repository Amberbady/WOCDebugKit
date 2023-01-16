//
//  PHScreenFitCell.m
//  MamaDebugBuilder
//
//  Created by 妈妈网 on 2021/9/15.
//  Copyright © 2021 mamawangtanxl. All rights reserved.
//

#import "PHScreenFitCell.h"
#import "Masonry.h"

@interface PHScreenFitCell ()

@property (nonatomic, strong) UILabel *desLabel;

@end


@implementation PHScreenFitCell

+ (instancetype)screenFitCellWithTableView:(UITableView *)tableView
{
    PHScreenFitCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PHScreenFitCell.class)];
    if (!cell) {
        
        cell = [[PHScreenFitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(PHScreenFitCell.class)];
        cell.contentView.backgroundColor = UIColor.whiteColor;
        [cell setupUI];
    }
    return cell;
}

- (void)setupUI {
    
    UILabel *desLabel = [[UILabel alloc] init];
    desLabel.textColor = UIColor.blackColor;
    desLabel.font = [UIFont systemFontOfSize:12];
    desLabel.adjustsFontSizeToFitWidth = YES;
    desLabel.numberOfLines = 0;
    desLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:desLabel];
    self.desLabel = desLabel;
    
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.desLabel.text = title;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    
    self.desLabel.textColor = isSelected ? UIColor.redColor : UIColor.blackColor;
}

@end
