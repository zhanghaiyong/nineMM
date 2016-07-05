//
//  OrderComplainCtrl.m
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "OrderComplainCtrl.h"

@interface OrderComplainCtrl ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation OrderComplainCtrl

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"发起申诉";
}

#pragma mark UITableViewDelegate&&UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 10;
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}



@end
