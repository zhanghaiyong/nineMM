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

- (void)viewDidLoad {
    [super viewDidLoad];

}


#pragma mark UITableViewDelegate&&UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}



@end
