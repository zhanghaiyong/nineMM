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
@interface OrderDetailTabViewCtrl ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *image;
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
/**
 *  酒币
 */
@property (weak, nonatomic) IBOutlet UILabel *wineCoin;
/**
 *  库存
 */
@property (weak, nonatomic) IBOutlet UILabel *stock;
/**
 *  合计
 */
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
/**
 *  订单编号
 */
@property (weak, nonatomic) IBOutlet UILabel *orderCode;
/**
 *  订单状态
 */
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
/**
 *  订单时间
 */
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
/**
 *  指定商品
 */
@property (weak, nonatomic) IBOutlet UILabel *pointGoods;
/**
 *  支付币种
 */
@property (weak, nonatomic) IBOutlet UILabel *coinType;
/**
 *  下单人
 */
@property (weak, nonatomic) IBOutlet UILabel *orderMan;
/**
 *  购买单位
 */
@property (weak, nonatomic) IBOutlet UILabel *payUnit;
/**
 *  订单总额
 */
@property (weak, nonatomic) IBOutlet UILabel *orderTotalWineCoin;

@end

@implementation OrderDetailTabViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单详情";
    [self setNavigationLeft:@"返回"];
    
    [self orderDetail];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
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
               OrderDetailModel *orderDetail = [OrderDetailModel mj_objectWithKeyValues:retObj];
                
                self.goodsName.text = orderDetail.goodsName;
                self.wineCoin.text = orderDetail.price;
                self.stock.text = [NSString stringWithFormat:@"x%@",orderDetail.quantity];
                self.totalPrice.text = orderDetail.totalPrice;
                self.orderCode.text = orderDetail.orderSn;
                self.orderStatus.text = orderDetail.orderStepName;
                self.orderStatus.textColor = HEX_RGB((unsigned long)orderDetail.orderStepTextColor);
                self.orderTime.text = orderDetail.orderCreateDate;
                self.pointGoods.text = orderDetail.productName;
                self.coinType.text = orderDetail.paymentMethodName;
                self.orderMan.text = [orderDetail.address objectForKey:@"consignee"];
//                self.payUnit.text = orderDetail.
                self.orderTotalWineCoin.text = orderDetail.totalPrice;
                
                
                
//                [self.tableView reloadData];
            }
            
        }else {
//            if ([[dataDic objectForKey:@"retCode"]integerValue] == -2){
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
//            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//            LoginViewController *loginVC = [SB instantiateViewControllerWithIdentifier:@"LoginViewController"];
//            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
//            [self presentViewController:navi animated:YES completion:^{
//                
//                [self.navigationController popViewControllerAnimated:YES];
//                
//            }];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)doBack:(UIButton *)sender
{
    if (self.surePayProduce) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


@end
