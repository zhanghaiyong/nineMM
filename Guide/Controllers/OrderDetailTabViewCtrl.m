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
#import "OrderDetailCell1.h"
#import "OrderDetailCell2.h"
#import "OrderDetailCell4.h"

@interface OrderDetailTabViewCtrl ()<UITableViewDataSource,UITableViewDelegate>{

    OrderDetailModel *orderDetail;
    NSMutableDictionary *sourceDic;//用来判断资源分组展开和关闭
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
        
        if ([orderDetail.orderType isEqualToString:@"payment"]) {
            
            return 370;
        }
        return 330;
        
    }else {
        
        if ([orderDetail.orderType isEqualToString:@"payment"]) {
            
            NSDictionary *dic = orderDetail.orderItems[indexPath.row];
            CGFloat H = 140;
            
            if ([[dic objectForKey:@"itemsCount"] integerValue] > 0) {
                H += 40;
            }
            
            if ([[dic objectForKey:@"shopCount"] integerValue] > 0) {
                
                H += 40;
            }
            
            if ([sourceDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                
//                OrderDetailCell1 *cell1 = [tableView cellForRowAtIndexPath:indexPath];
//                cell1.sourceData = [orderDetail.orderItems[indexPath.row] objectForKey:@"items"];
                
                return H += ((NSArray *)[dic objectForKey:@"items"]).count * 30;
            }
            
            return H;
        }
    
        return 180;
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
        cell.payMethod.text = [NSString stringWithFormat:@"%@",orderDetail.paymentMethodName];
        cell.packageName.text = orderDetail.packagedProductName;
        cell.buyUnit.text = orderDetail.departmentName;

        return cell;
        
    }else {
        
         if ([orderDetail.orderType isEqualToString:@"payment"]) {
    
             NSDictionary *orderItem = orderDetail.orderItems[indexPath.row];
             
            OrderDetailCell1 *cell1 = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailCell1" owner:self options:nil] lastObject];
             
             if ([sourceDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                 cell1.sourceTableViewH.constant = ((NSArray *)[orderItem objectForKey:@"items"]).count * 30;
                 cell1.sourceData = [orderDetail.orderItems[indexPath.row] objectForKey:@"items"];
             }
             
    
            cell1.productName.text = [orderItem objectForKey:@"productName"];
            cell1.priceLabel.text = [NSString stringWithFormat:@"%@",[orderItem objectForKey:@"price"]];
            cell1.stockLabel.text = [NSString stringWithFormat:@"%@",[orderItem objectForKey:@"quantity"]];
            cell1.sourceCount.text = [NSString stringWithFormat:@"%@项（点击查看详情）",[orderItem objectForKey:@"itemsCount"]];
            cell1.storeCount.text = [NSString stringWithFormat:@"%@家（点击查看详情）",[orderItem objectForKey:@"itemsCount"]];
             
             [cell1 tapToShowSource:^(NSString *aFlag) {
                 
                 if ([aFlag isEqualToString:@"source"]) {
                     
                     if (sourceDic == nil) {
                         sourceDic = [[NSMutableDictionary alloc]init];
                     }
                     
                     if (![sourceDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                         [sourceDic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                         
                         
                     }else {
                         
                         [sourceDic removeObjectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                     }
                     
                     [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                 }
                 
             }];
            
            return cell1;
             
         }else {
         
             OrderDetailCell2 *cell2 = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailCell2" owner:self options:nil] lastObject];
             NSDictionary *orderItem = orderDetail.orderItems[indexPath.row];
             cell2.packageName.text = [orderItem objectForKey:@"coinRechargePackageName"];
             cell2.coinType.text = [orderItem objectForKey:@"coinType"];
             cell2.number.text = [NSString stringWithFormat:@"%@",[orderItem objectForKey:@"coinAmount"]];
             cell2.money.text = [NSString stringWithFormat:@"%@",[orderItem objectForKey:@"rmbAmount"]];
             
            return cell2;
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
