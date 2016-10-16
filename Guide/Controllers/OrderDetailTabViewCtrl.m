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
#import "GetOrderShopParams.h"
#import "CancleOrderParams.h"
@interface OrderDetailTabViewCtrl ()<UITableViewDataSource,UITableViewDelegate>{

    OrderDetailModel *orderDetail;
    NSMutableDictionary *sourceDic;//用来判断资源分组展开和关闭
    NSMutableDictionary *storeDic;//用来判断资源分组展开和关闭
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *shopCount;
@property (nonatomic,strong)GetOrderShopParams *shopParams;


@end

@implementation OrderDetailTabViewCtrl

- (GetOrderShopParams *)shopParams {

    if (_shopParams == nil) {
        GetOrderShopParams *shopParams= [[GetOrderShopParams alloc]init];
        shopParams.rows = 10;
        _shopParams = shopParams;
    }
    return _shopParams;
}

- (NSMutableArray *)shopCount {

    if (_shopCount == nil) {
        
        NSMutableArray *shopCount = [NSMutableArray array];
        _shopCount = shopCount;
    }
    return _shopCount;
}

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
        
        if (orderDetail.packagedProductName.length != 0) {
            
            return 410;
        }
        
        return 370;
        
    }else {
        
        if ([orderDetail.orderType isEqualToString:@"payment"]) {
            
            NSDictionary *dic = orderDetail.orderItems[indexPath.row];
            CGFloat H = 140;
            
            if ([[dic objectForKey:@"itemsCount"] integerValue] > 0) {
                H += 44;
            }
            
            if ([[dic objectForKey:@"shopCount"] integerValue] > 0) {
                
                H += 44;
            }
            
            if ([sourceDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                
                return H += ((NSArray *)[dic objectForKey:@"items"]).count * 40;
            }
            
            if ([storeDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                
                return H += self.shopCount.count * 40;
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
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
        cell.payMethod.text = orderDetail.paymentMethodName;
        cell.orderType.text = orderDetail.orderTypeName;
        
        if ([orderDetail.cancelable integerValue] == 1) {
            
            cell.cancleButton.alpha = 1;
            cell.cancleButton.userInteractionEnabled = YES;
        }
        
        [cell returnBlock:^{
            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否取消此订单？" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[HUDConfig shareHUD]alwaysShow];
                CancleOrderParams *cancleParams = [[CancleOrderParams alloc]init];
                cancleParams.id = [orderDetail.orderId intValue];
                
                [KSMNetworkRequest postRequest:KCancleOrder params:cancleParams.mj_keyValues success:^(NSDictionary *dataDic) {
                    
                    NSLog(@"KCancleOrder = %@",dataDic);
                    [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
                    
                    [[HUDConfig shareHUD]dismiss];
                    
                    if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
                        
                        [self doBack:cell.cancleButton];
                        
                        if ([self.delegate respondsToSelector:@selector(deleteOrder:)]) {
                            [self.delegate deleteOrder:_section];
                        }
                    }
                    
                } failure:^(NSError *error) {
                    
                    [[HUDConfig shareHUD]SuccessHUD:@"取消失败" delay:DELAY];
                    NSLog(@"KCancleOrder = %@",error);
                }];
                
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            }]];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }];
        

        if (orderDetail.packagedProductName.length == 0) {
            
            cell.packageH.constant = 0;
        }
        
        cell.packageName.text = orderDetail.packagedProductName;
        cell.buyUnit.text = orderDetail.departmentName;

        return cell;
        
    }else {
        
         if ([orderDetail.orderType isEqualToString:@"payment"]) {
    
             NSDictionary *orderItem = orderDetail.orderItems[indexPath.row];
             
            OrderDetailCell1 *cell1 = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailCell1" owner:self options:nil] lastObject];
             
             //展示商品列表
             if ([sourceDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                 cell1.sourceTableViewH.constant = ((NSArray *)[orderItem objectForKey:@"items"]).count * 40;
                 cell1.sourceData = [orderDetail.orderItems[indexPath.row] objectForKey:@"items"];
             }
             
             //展示门店列表
             if ([storeDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                 cell1.storeTableViewH.constant = self.shopCount.count * 40;
                 cell1.sourceData = self.shopCount;
             }
             
    
            cell1.productName.text = [orderItem objectForKey:@"productName"];
            cell1.priceLabel.text = [NSString stringWithFormat:@"%@",[orderItem objectForKey:@"price"]];
            cell1.stockLabel.text = [NSString stringWithFormat:@"%@",[orderItem objectForKey:@"quantity"]];
             
             //如果有商品数，则显示按钮
             if ([[orderItem objectForKey:@"itemsCount"] integerValue] > 0) {
                 
                 cell1.sourceViewH.constant = 44;
                 cell1.sourceCount.text = [NSString stringWithFormat:@"%@项（点击查看详情）",[orderItem objectForKey:@"itemsCount"]];
             }
             
             //如果有门店数，则显示按钮
             if ([[orderItem objectForKey:@"shopCount"] integerValue] > 0) {
                 
                 cell1.storeViewH.constant = 44;
                 cell1.storeCount.text = [NSString stringWithFormat:@"%@家（点击查看详情）",[orderItem objectForKey:@"shopCount"]];
             }
             
             
             [cell1 tapToShowSource:^(NSString *aFlag) {
                 
                 if ([aFlag isEqualToString:@"source"]) {
                     
                     storeDic = nil;
                     
                     if (sourceDic == nil) {
                         sourceDic = [[NSMutableDictionary alloc]init];
                     }
                     
                     if (![sourceDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                         [sourceDic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                         
                         
                     }else {
                         
                         [sourceDic removeObjectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                     }
                     
                     [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                     
                 }else {
                 
                     sourceDic = nil;
                     if (storeDic == nil) {
                         storeDic = [[NSMutableDictionary alloc]init];
                     }

                     if ([storeDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                         [storeDic removeObjectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                         [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                         return;
                     }
                     
                     if (self.shopCount.count > 0) {
                         
                         if (![storeDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                             [storeDic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                             
                         }else {
                             
                             [storeDic removeObjectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                         }
                         [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                         return;
                     }
                     
                     self.shopParams.id = [orderItem objectForKey:@"orderItemId"];
                     self.shopParams.page = 1;
                     [self loadShopIndex:indexPath table:cell1.storeTableView type:nil];
                 }
                 
             }];
             
             //刷新
             cell1.storeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                 
                 FxLog(@"刷新");
                 self.shopParams.id = [orderItem objectForKey:@"orderItemId"];
                  self.shopParams.page = 1;
                  [self loadShopIndex:indexPath table:cell1.storeTableView type:@"refresh"];
             }];
             
             //加载
             cell1.storeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                 
                 FxLog(@"加载");
                  self.shopParams.id = [orderItem objectForKey:@"orderItemId"];
                  self.shopParams.page += 1;
                  [self loadShopIndex:indexPath table:cell1.storeTableView type:@"loadMore"];
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

- (void)loadShopIndex:(NSIndexPath *)indexPath table:(UITableView *)tableV type:(NSString *)type{

    [[HUDConfig shareHUD]alwaysShow];

    [KSMNetworkRequest postRequest:KGetOrderShops params:self.shopParams.mj_keyValues success:^(NSDictionary *dataDic) {
        
        [[HUDConfig shareHUD]Tips:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        
        FxLog(@"orderShop = %@  \n%@",dataDic,self.shopParams.mj_keyValues);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
        
        NSString *jsonStr = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        
        //等于1，说明是刷新
        if (self.shopParams.page == 1) {
            
            [self.shopCount removeAllObjects];
            [self.shopCount addObjectsFromArray:array];
            
        }else {
            
            [self.shopCount addObjectsFromArray:array];
        }
        
        if (array.count < self.shopParams.rows) {
            
            [tableV.mj_footer endRefreshingWithNoMoreData];
        }else {
            
            [tableV.mj_footer endRefreshing];
        }
        
        if (!type) {
           
            if (![storeDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                [storeDic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                
            }else {
                
                [storeDic removeObjectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
            }
        }

        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
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
