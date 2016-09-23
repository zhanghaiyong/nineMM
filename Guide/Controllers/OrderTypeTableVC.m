//
//  OrderTypeTableVC.m
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "OrderTypeTableVC.h"
#import "PackageOrderCell.h"
#import "OtherOrderCell.h"
#import "OrderDetailTabViewCtrl.h"
#import "OrderListParams.h"
#import "OrderModel.h"
#import "OrderComplainCtrl.h"
@interface OrderTypeTableVC ()<UITableViewDelegate,UITableViewDataSource>
{

    NSMutableArray *orderListArr;
    BOOL isRefresh;
}
@property (nonatomic,strong)OrderListParams *params;

@end

@implementation OrderTypeTableVC

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
    
    [self setNavigationLeft:@"返回"];
    
    self.title = @"订单列表";
    
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
    
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.params.page = 1;
        
        isRefresh = YES;
        [self getOrderList];
        
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.params.page += 1;
        
        isRefresh = NO;
        [self getOrderList];
    }];
    
    [self getOrderList];
    
}

- (void)getOrderList {

    [[HUDConfig shareHUD]alwaysShow];
    
    [KSMNetworkRequest postRequest:KOrderList params:self.params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"getOrderList = %@",dataDic);
        
        if (!isRefresh) {
            
            [[HUDConfig shareHUD]dismiss];
        }
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            if (isRefresh) {
                
                [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            }
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *sourceData = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                
                if (sourceData.count == 0) {
                    
                    [[HUDConfig shareHUD]SuccessHUD:@"暂无订单" delay:DELAY];
                }
                
                if (self.params.page == 1) {
                    
                    orderListArr = [OrderModel mj_objectArrayWithKeyValuesArray:sourceData];
                    [self.tableView.mj_header endRefreshing];
                    
                }else {
                
                    NSArray *array = [OrderModel mj_objectArrayWithKeyValuesArray:sourceData];
                    [orderListArr addObjectsFromArray:array];
                    
                    if (array.count < self.params.rows) {
                        
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }else {
                        
                        [self.tableView.mj_footer endRefreshing];
                    }
                }
                
                
                [self.tableView reloadData];
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma  makk UITableViewDelegate&&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return orderListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderModel *model = orderListArr[indexPath.section];
    
    if ([model.orderType isEqualToString:@"payment"] && model.packagedProductName.length != 0) { //套餐
        
        return 120 + model.orderItems.count*80;
    
    }else if ([model.orderType isEqualToString:@"payment"] && model.packagedProductName.length == 0) { //购物车
        
        return 80+model.orderItems.count*40;
        
    }else if ([model.orderType isEqualToString:@"coinRecharge"]) { // 酒币
    
        return 80+60;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        
        return 0;
    }
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    OrderModel *model = orderListArr[indexPath.section];
    
    if ([model.orderType isEqualToString:@"coinRecharge"]) { // 酒币
    
        OtherOrderCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"OtherOrderCell" owner:self options:nil] lastObject];
        cell.orderModel = model;
        return cell;
    }else {
    
        PackageOrderCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PackageOrderCell" owner:self options:nil] lastObject];
        cell.orderModel = model;
        return cell;
    }
    
    
    
    /*
    static NSString *identtifier = @"cell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identtifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderCell" owner:self options:nil] lastObject];
    }
//    if ([_showDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]]) {
//        cell.detailViewHeight.constant = 160;
//    }else {
    
        cell.detailViewHeight.constant = 0;
//    }
    
    OrderModel *model = orderListArr[indexPath.section];
    
    cell.orderIDLabel.text = model.orderSn;
    [cell.orderStatusButton setTitle:[NSString stringWithFormat:@"  %@  ",model.orderStepName] forState:UIControlStateNormal];
    [cell.orderStatusButton setTitleColor:[Uitils colorWithHex:(unsigned long)model.orderStepTextColor] forState:UIControlStateNormal];
    cell.orderStatusButton.layer.borderColor = [Uitils colorWithHex:(unsigned long)model.orderStepTextColor].CGColor;
    
    cell.produceName.text = model.goodsName;
    cell.nowPriceLabel.text = model.price;
//    cell.coinType1.text = ;
//    cell.coinType2.text = ;
    if (model.quantity) {
    
        cell.collectLabel.text = [NSString stringWithFormat:@"x%@",model.quantity];
    }
    cell.nowPriceRed.text = model.price;
//    cell.oriPrice.text = model.totalPrice;
    
    [cell tapDealOrder:^{
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        OrderComplainCtrl *dealOrder = [mainSB instantiateViewControllerWithIdentifier:@"OrderComplainCtrl"];
        dealOrder.orderModel = model;
        [self.navigationController pushViewController:dealOrder animated:YES];
    }];
    
    //进入详情
    [cell tapToChechOrderDetail:^{
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        OrderDetailTabViewCtrl *orderDetail = [mainSB instantiateViewControllerWithIdentifier:@"OrderDetailTabViewCtrl"];
        orderDetail.orderId = model.orderId;
        [self.navigationController pushViewController:orderDetail animated:YES];
    }];
    
    return cell;
     */
//    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderModel *model = orderListArr[indexPath.section];
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    OrderDetailTabViewCtrl *orderDetail = [mainSB instantiateViewControllerWithIdentifier:@"OrderDetailTabViewCtrl"];
    orderDetail.orderId = model.orderId;
    [self.navigationController pushViewController:orderDetail animated:YES];
}

- (void)doBack:(UIButton *)sender {
    
    if (self.fromRecharge) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else {
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}


@end
