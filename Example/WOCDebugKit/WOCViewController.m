//
//  WOCViewController.m
//  WOCDebugKit
//
//  Created by 廖燊 on 01/16/2023.
//  Copyright (c) 2023 廖燊. All rights reserved.
//

#import "WOCViewController.h"
#import "LSTestVM.h"
#define MAINSCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define MAINSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
@interface WOCViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LSTestVM *vm;
@end

@implementation WOCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.tableView];
    [self.vm request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(LSTestVM *)vm{
    if (!_vm) {
        _vm = [[LSTestVM alloc] init];
        __weak typeof(self) weakSelf = self;
        _vm.reloadData = ^{
            weakSelf.tableView.dataSource = weakSelf.vm.dataSource;
            weakSelf.tableView.delegate = weakSelf.vm.delegate;
            [weakSelf.tableView reloadData];
        };
    }
    return _vm;
}
@end
