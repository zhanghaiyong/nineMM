//
//  OrderDetailTabViewCtrl.m
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "OrderDetailTabViewCtrl.h"

@interface OrderDetailTabViewCtrl ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OrderDetailTabViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单详情";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}


@end
