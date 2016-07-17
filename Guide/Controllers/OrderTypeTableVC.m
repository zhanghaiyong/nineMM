//
//  OrderTypeTableVC.m
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "OrderTypeTableVC.h"
#import "OrderCell.h"
#import "OrderDetailTabViewCtrl.h"
#import "OrderListParams.h"
#import "OrderModel.h"
@interface OrderTypeTableVC ()<UITableViewDelegate,UITableViewDataSource>
{

    NSMutableDictionary *_showDic;//用来判断分组展开和关闭
    NSMutableArray *orderListArr;
}
@property (nonatomic,strong)OrderListParams *params;

@end

@implementation OrderTypeTableVC

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}


-(OrderListParams *)params {

    if (_params == nil) {
        
        OrderListParams *params = [[OrderListParams alloc]init];
        params.rows = 20;
        params.page = 0;
        
        switch (self.orderType) {
            case 100:

                break;
            case 101: //待审核
                params.orderStatus = @"unconfirmed";
                break;
            case 102: //已取消
                params.orderStatus = @"cancelled";
                break;
            case 103: //执行中
                params.orderStatus = @"shipping";
                break;
            case 104: //申诉订单
                params.orderStatus = @"complained";
                break;
                
            default:
                break;
        }
        
        
        _params = params;
    }
    
    return _params;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    orderListArr = [NSMutableArray array];
    
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
        case 104:
            
            self.title = ORDERTYPE5;
            break;
            
        default:
            break;
    }
    
    [self getOrderList];
    
}

- (void)getOrderList {

    [[HUDConfig shareHUD]alwaysShow];
    
    self.params.page += 1;
    
    [KSMNetworkRequest postRequest:KOrderList params:self.params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"getOrderList = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                orderListArr = [OrderModel mj_objectArrayWithKeyValuesArray:[[dataDic objectForKey:@"retObj"] objectForKey:@"rows"]];
                
                [self.tableView reloadData];
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
        [[HUDConfig shareHUD]ErrorHUD:error.localizedDescription delay:DELAY];
    }];
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
        return 180+160;
    }
    return 180;
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
        OrderDetailTabViewCtrl *orderDetail = [mainSB instantiateViewControllerWithIdentifier:@"OrderDetailTabViewCtrl"];
        [self.navigationController pushViewController:orderDetail animated:YES];
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
