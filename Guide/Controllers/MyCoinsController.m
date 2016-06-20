//
//  MyCoinsController.m
//  Guide
//
//  Created by 张海勇 on 16/6/20.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MyCoinsController.h"
#import "TitleView.h"
@interface MyCoinsController ()

@end

@implementation MyCoinsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的酒币";
    //头部
    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    titleView.normalColor = lever2Color;
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.selectedColor = specialRed;
    titleView.titleArray = @[@"全部",@"金币",@"绿币",@"黑币",@"红币",@"蓝币"];
    
    [titleView TitleViewCallBack:^(NSInteger btnTag) {
        
    }];
    
    self.tableView.tableHeaderView = titleView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView Delegate &&DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}
@end
