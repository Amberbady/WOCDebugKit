//
//  LSTableViewCell.m
//  LSTableTool_Example
//
//  Created by liaoshen on 2022/11/16.
//  Copyright © 2022 git. All rights reserved.
//

#import "LSTableViewCell.h"
#import "UIView+LSCategory.h"
#import "UIResponder+SCRouter.h"
#import "DoraemonCacheManager.h"
#import "DoraemonHomeWindow.h"
@implementation LSTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.clipsToBounds = YES;
        self.backgroundColor = UIColor.redColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self.contentView addSubview:self.titleLabel];
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width - 40, 40)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.backgroundColor = UIColor.whiteColor;
        [_titleLabel mm_addTapGestureWithTarget:self action:@selector(touchAction)];
    }
    return _titleLabel;
}

- (void)touchAction{
    [[DoraemonCacheManager sharedInstance] saveDaraemonKitSwitch:YES];
    exit(0);
}

- (void)setupCellWithRowData:(NSString *)rowData{
    _titleLabel.text = rowData;
}
@end
