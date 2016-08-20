//
//  OrderDetailTabViewCtrl.m
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "OrderDetailTabViewCtrl.h"
#import "OrderDetailParams.h"
#import "OrderDetailModel.h"
#import "OrderItemModel.h"
#import "OrderDetailCell1.h"
#import "OrderDetailCell4.h"

@interface OrderDetailTabViewCtrl ()<UITableViewDataSource,UITableViewDelegate>{

    OrderDetailModel *orderDetail;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation OrderDetailTabViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单详情";
    [self setNavigationLeft:@"返回"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self orderDetail];
}

#pragma  mark UITableViewDelegate&&UITableViewDatSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return 1;
    }else {
        return orderDetail.orderItems.count;;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        return 330;
        
    }else {
    
        return 80;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        return 40;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    label.text = @"  订单项目";
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = [UIColor lightGrayColor];
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        OrderDetailCell4 *cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailCell4" owner:self options:nil] lastObject];
        cell.orderCode.text = orderDetail.orderSn;
        cell.orderStatus.text = orderDetail.orderStepName;
        cell.orderStatus.textColor = [Uitils colorWithHex:(unsigned long)orderDetail.orderStepName];
        cell.orderTime.text = orderDetail.orderCreateDate;
        cell.OrderPeople.text = [orderDetail.address objectForKey:@"consignee"];
        cell.orderTotalPrice.text = orderDetail.totalPrice;
        NSString *coinName = [orderDetail.paymentMethodCode stringByReplacingOccurrencesOfString:@"Coin" withString:@""];
        cell.payMethod.text = [NSString stringWithFormat:@"%@支付",[Uitils toChinses:coinName]];

        return cell;
        
    }else {
    
        static NSString *identifier = @"cell";
        OrderDetailCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell1) {
            cell1 = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailCell1" owner:self options:nil] lastObject];
            
            OrderItemModel *orderItem = orderDetail.orderItems[indexPath.row];
            cell1.productName.text = orderItem.goodsName;
            cell1.priceLabel.text = orderItem.price;
            cell1.stockLabel.text = [NSString stringWithFormat:@"x%@",orderItem.quantity];;
            
            return cell1;
        }
        
    }
    return nil;
}

- (void)orderDetail {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    OrderDetailParams *params = [[OrderDetailParams alloc]init];
    params.id = [self.orderId intValue];
    
    FxLog(@"orderDetail = %@",params.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KAppOrderDetail params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"orderDetail = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSDictionary *retObj = [dataDic objectForKey:@"retObj"];
               orderDetail = [OrderDetailModel mj_objectWithKeyValues:retObj];
                
                [self.tableView reloadData];
            }
            
        }else {
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)doBack:(UIButton *)sender {
    
    if (self.surePayProduce) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


@end
