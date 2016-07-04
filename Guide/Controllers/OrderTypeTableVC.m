//
//  OrderTypeTableVC.m
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "OrderTypeTableVC.h"
#import "OrderCell.h"
#import "OrderComplainCtrl.h"
@interface OrderTypeTableVC ()<UITableViewDelegate,UITableViewDataSource>
{

    NSMutableDictionary *_showDic;//用来判断分组展开和关闭
}
@end

@implementation OrderTypeTableVC

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.orderType) {
        case 100:
            self.title = ORDERTYPE1;
            break;
        case 101:
            self.title = ORDERTYPE2;
            break;
        case 102:
            self.title = ORDERTYPE3;
            break;
        case 103:
            
            self.title = ORDERTYPE4;
            break;
            
        default:
            break;
    }
}


#pragma  makk UITableViewDelegate&&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_showDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]]) {
        return 190+160;
    }
    return 190;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *identtifier = @"cell";
        OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identtifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderCell" owner:self options:nil] lastObject];
        }
    if ([_showDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]]) {
        cell.detailViewHeight.constant = 160;
    }else {
    
        cell.detailViewHeight.constant = 0;
    }
    
    //进入详情
    [cell tapToChechOrderDetail:^{
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        OrderComplainCtrl *OrderComplain = [mainSB instantiateViewControllerWithIdentifier:@"OrderComplainCtrl"];
        [self.navigationController pushViewController:OrderComplain animated:YES];
    }];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_showDic == nil) {
        
        _showDic = [[NSMutableDictionary alloc]init];
    }
    
    NSString *key = [NSString stringWithFormat:@"%ld",indexPath.section];
    
    if (![_showDic objectForKey:key]) {
        [_showDic setObject:@"1" forKey:key];
        
    }else {
        
        [_showDic removeObjectForKey:key];
    }
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    

//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
}


@end
