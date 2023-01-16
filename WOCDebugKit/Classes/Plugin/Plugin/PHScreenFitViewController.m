//
//  PHScreenFitViewController.m
//  MamaDebugBuilder
//
//  Created by 妈妈网 on 2021/9/15.
//  Copyright © 2021 mamawangtanxl. All rights reserved.
//

#import "PHScreenFitViewController.h"
#import "PHScreenFitCell.h"
#import "DoraemonHomeWindow.h"
#import "DoraemonAppInfoUtil.h"
#import "UIScreen+PHScreenFitResize.h"
#import "Masonry.h"
#import "DoraemonToastUtil.h"

@interface PHScreenFitViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
// 屏幕尺寸
@property (nonatomic, strong) NSArray *screenFrameArray;
// 机型描述
@property (nonatomic, strong) NSArray *desStrArray;

@end

@implementation PHScreenFitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupAllScreenFrame];
    [self setupTableView];
}

/** 不要改变顺序，和screenFit_bounds 里的bounds对应 */
- (void)setupAllScreenFrame {
    
    // iPhone6, iPhone6s, iPhone7, iPhone8， iPhoneSE 二代
    NSArray *iPhone6 = @[@375, @667];
    // iPhone6Plus, iPhone6sPlus, iPhone7P, iPhone8Plus
    NSArray *iPhone6Plus = @[@414, @736];
    // iPhoneSE 一代
    NSArray *iPhoneSE = @[@320, @568];
    // iPhoneX, iPhoneXS, iPhone11 Pro,
    NSArray *iPhoneX = @[@375, @812];
    // iPhoneXR, iPhoneXS Max, iPhone11, iPhone11 Pro Max
    NSArray *iPhoneXR = @[@414, @896];
    // iPhone12 mini, iPhone13 mini
    NSArray *iPhone12mini = @[@360, @780];
    // iPhone12, iPhone12 Pro, iPhone13, iPhone13 Pro
    NSArray *iPhone12 = @[@390, @844];
    // iPhone12 Pro Max, iPhone13 Pro Max
    NSArray *iPhone12ProMax = @[@428, @926];
    
    NSArray *iPhone14ProMax = @[@430, @932];
    
    self.screenFrameArray = @[
        iPhone6,
        iPhone6Plus,
        iPhoneSE,
        iPhoneX,
        iPhoneXR,
        iPhone12mini,
        iPhone12,
        iPhone12ProMax,
        iPhone14ProMax
    ];
    self.desStrArray = @[
        @"(375, 667): iPhone6, iPhone6s, iPhone7, iPhone8, iPhoneSE 二代",
        @"(414, 736): iPhone6Plus, iPhone6sPlus, iPhone7P, iPhone8Plus",
        @"(320, 568): iPhoneSE 一代",
        @"(375, 812): iPhoneX, iPhoneXS, iPhone11 Pro",
        @"(414, 896): iPhoneXR, iPhoneXS Max, iPhone11, iPhone11 Pro Max",
        @"(360, 780): iPhone12 mini, iPhone13 mini",
        @"(390, 844): iPhone12, iPhone12 Pro, iPhone13, iPhone13 Pro, iPhone14",
        @"(428, 926): iPhone12 Pro Max, iPhone13 Pro Max, iPhone14 Pro",
        @"(430, 932): iPhone14 Pro Max",
    ];
}

- (void)setupTableView {
    
    //获取手机型号
    NSString *iphoneType = [DoraemonAppInfoUtil iphoneType];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UILabel *currentModeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    currentModeLabel.text = [NSString stringWithFormat:@"当前机型:%@", iphoneType];
    currentModeLabel.textColor = UIColor.blackColor;
    currentModeLabel.font = [UIFont systemFontOfSize:17];
    currentModeLabel.textAlignment = NSTextAlignmentCenter;
    tableView.tableHeaderView = currentModeLabel;
    
    CGFloat bottomHeight = 0;
    if (@available(iOS 11.0, *)) {
        bottomHeight = UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom;
    }
    
    CGFloat navBarHeight = CGRectGetHeight(UIApplication.sharedApplication.statusBarFrame) + 44;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-bottomHeight);
        make.top.mas_equalTo(navBarHeight);
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.screenFrameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PHScreenFitCell *cell = [PHScreenFitCell screenFitCellWithTableView:tableView];
    cell.title = self.desStrArray[indexPath.row];
    PHScreenFitType currenType = [NSUserDefaults.standardUserDefaults integerForKey:@"PHScreenFitType"];
    BOOL isSelected = (indexPath.row + 1 == currenType);
    cell.isSelected = isSelected;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *iPhoneFrame = self.screenFrameArray[indexPath.row];
    CGFloat width = [iPhoneFrame.firstObject floatValue];
    CGFloat height = [iPhoneFrame.lastObject floatValue];
    PHScreenFitType currenType = [NSUserDefaults.standardUserDefaults integerForKey:@"PHScreenFitType"];
    // 当前设备尺寸
    CGRect bounds = CGRectZero;
    if (currenType == PHScreenFitTypeNone) {
        
        bounds = UIScreen.mainScreen.bounds;
    } else {
    
        bounds = UIScreen.mainScreen.screenFit_bounds;
    }
    
    if (bounds.size.width < width || bounds.size.height < height) {
        
        [DoraemonToastUtil showToast:@"选择的机型尺寸超出当前设备屏幕(更宽 or 更高)" inView:DoraemonHomeWindow.shareInstance];
        return;
    }
    
    CGFloat x = (bounds.size.width - width) / 2.0;
    CGFloat y = (bounds.size.height - height) / 2.0;
    UIApplication.sharedApplication.delegate.window.frame = CGRectMake(x, y, width, height);
    PHScreenFitType type = indexPath.row + 1;
    [UIScreen swizzleScreenFitWithScreenType:type];
    [DoraemonHomeWindow.shareInstance hide];
}


@end
