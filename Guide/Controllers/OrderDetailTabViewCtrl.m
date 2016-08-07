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
#import "OrderDetailCell2.h"
#import "OrderDetailCell3.h"
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
        
        return orderDetail.orderItems.count;;
    }else {
    
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        return 80;
        
    }else {
    
        switch (indexPath.row) {
            case 0:
                return 165;
                break;
            case 1:
                return 90;
                break;
            case 2:
                return 120;
                break;
                
            default:
                break;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
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
    }else {
    
        switch (indexPath.row) {
            case 0:{
            
                OrderDetailCell2 *cell2 = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailCell2" owner:self options:nil] lastObject];
                cell2.orderCode.text = orderDetail.orderSn;
                cell2.orderStatus.text = orderDetail.orderStepName;
                cell2.orderStatus.textColor = [Uitils colorWithHex:(unsigned long)orderDetail.orderStepName];
                cell2.orderTime.text = orderDetail.orderCreateDate;
                return cell2;
            }
                
                break;
            case 1:{
                
                OrderDetailCell3 *cell3 = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailCell3" owner:self options:nil] lastObject];
//                cell3.pointProduct.text = orderDetail.
                NSString *coinName = [orderDetail.paymentMethodCode stringByReplacingOccurrencesOfString:@"Coin" withString:@""];
                cell3.payCoinImage.image = [UIImage imageNamed:[Uitils toImageName:coinName]];
                cell3.payCoinName.text = [Uitils toChinses:coinName];
                return cell3;
            }
                
                break;
            case 2:{
                
                OrderDetailCell4 *cell4 = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailCell4" owner:self options:nil] lastObject];
                cell4.OrderPeople.text = [orderDetail.address objectForKey:@"consignee"];
                cell4.orderTotalPrice.text = orderDetail.totalPrice;
                return cell4;
            }
                
                break;
                
            default:
                break;
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
