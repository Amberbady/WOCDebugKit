//
//  WOCViewController.m
//  WOCDebugKit
//
//  Created by 廖燊 on 01/16/2023.
//  Copyright (c) 2023 廖燊. All rights reserved.
//

#import "WOCViewController.h"
#import "LSTestVM.h"
#import "LSSCEventProxy.h"
#import "DoraemonCacheManager.h"
#import "DoraemonHomeWindow.h"
#define MAINSCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define MAINSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
@interface WOCViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LSTestVM *vm;
@property (nonatomic, strong) LSSCEventProxy *proxy;
@end

@implementation WOCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.tableView];
    [self.vm request];
    self.proxy.vm = self.vm;
    self.eventProxy = self.proxy;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -Accessor
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT - 88) style:(UITableViewStylePlain)];
        _tableView.alwaysBounceVertical = YES;
        [_tableView setBackgroundColor:[UIColor clearColor]];
        _tableView.estimatedRowHeight = 0.0f;
        _tableView.estimatedSectionHeaderHeight = 0.0f;
        _tableView.estimatedSectionFooterHeight = 0.0f;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = YES;
        if (@available(iOS 11.0, *)) {
               _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];

    }
    return _tableView;
}

- (LSSCEventProxy *)proxy{
    if (!_proxy) {
        _proxy = [[LSSCEventProxy alloc]init];
    }
    return _proxy;
}

-(LSTestVM *)vm{
    if (!_vm) {
        _vm = [[LSTestVM alloc] init];
        __weak typeof(self) weakSelf = self;
        _vm.reloadData = ^{
            weakSelf.tableView.dataSource = weakSelf.vm.dataSource;
            weakSelf.tableView.delegate = weakSelf.vm.delegate;
            [weakSelf.tableView reloadData];
        };
        _vm.didCellSelect = ^{
            [[DoraemonCacheManager sharedInstance] saveDaraemonKitSwitch:YES];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"开启调试工具需要退出App" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *collectAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[DoraemonCacheManager sharedInstance] saveDaraemonKitSwitch:NO];
            }];
            UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    exit(0);
                });
            }];
            [alertController addAction:collectAction];
            [alertController addAction:deleteAction];
            [weakSelf.navigationController presentViewController:alertController animated:YES completion:nil];
        };
    }
    return _vm;
}
@end
