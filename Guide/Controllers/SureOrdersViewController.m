#import "SureOrdersViewController.h"
#import "sureOrdercell1.h"
#import "sureOrderCell2.h"
#import "sureOrderCell3.h"
#import "sureOrderFoorView.h"
#import "SourceListViewController.h"
#import "sureOrderFoorView.h"

#import "AppSubOrderParams.h"
#import "SubOrderModel.h"
#import "UserSourceModel.h"
#import "OrderDetailTabViewCtrl.h"

#import "Produce1Model.h"
#import "ProduceStoresModel.h"
@interface SureOrdersViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    sureOrderCell3 *cell3;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AppSubOrderParams *params;

@end

@implementation SureOrdersViewController


-(AppSubOrderParams *)params {

    if (_params == nil) {
        
        AppSubOrderParams *params = [[AppSubOrderParams alloc]init];
        params.amount = [self.proPrice intValue];
        _params = params;
        
    }
    return _params;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认下单";
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)subOrder {

    [[HUDConfig shareHUD]alwaysShow];
    
    NSLog(@"self.params = %@",self.params.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KAppSubOrder params:self.params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"buyNowAction = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
            OrderDetailTabViewCtrl *orderDetail = [mainSB instantiateViewControllerWithIdentifier:@"OrderDetailTabViewCtrl"];
            orderDetail.orderId = [[dataDic objectForKey:@"retObj"] objectForKey:@"orderId"][0];
            orderDetail.surePayProduce = YES;
            [self.navigationController pushViewController:orderDetail animated:YES];
            
        }else {
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
    

    
}

#pragma mark UITableViewDelegate&&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        
        if (self.packageId.length != 0) {
            
            return SCREEN_HEIGHT-64-80-120;
        }
        return SCREEN_HEIGHT-64-110-80-120;
        
    }
    return 10;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    if (section == 2) {
        
        sureOrderFoorView *footer = [[[NSBundle mainBundle]loadNibNamed:@"sureOrderFoorView" owner:self options:nil]lastObject];
        footer.frame = CGRectMake(0, 0, self.tableView.width, 50);
        
        [footer nowBuyProduce:^{
            
            if (self.packageId.length == 0) {
            
                SubOrderModel *subOrderModel     = [[SubOrderModel alloc]init];
                subOrderModel.productId          = [self.produceId intValue];
                subOrderModel.quantity           = 1;
                subOrderModel.storeSelectingType = self.proPriceByStoreParams.storeSelectingType;
                subOrderModel.stores             = self.proPriceByStoreParams.storeIds;
                subOrderModel.areas              = self.proPriceByStoreParams.areaIds;
                NSMutableArray *userSourceId     = [NSMutableArray array];
                for (UserSourceModel *model in self.userSourceArr) {
                    
                    [userSourceId addObject:model.id];
                }
                subOrderModel.items   = [userSourceId componentsJoinedByString:@","];
                
                NSMutableDictionary *itemM = [NSMutableDictionary dictionary];
//                itemModel *itemM      = [[itemModel alloc]init];
                NSArray *itemArr      = [NSArray arrayWithObject:subOrderModel.mj_keyValues];
                [itemM setObject:itemArr forKey:@"items"];
                NSArray *array        = [NSArray arrayWithObject:itemM];
                NSString *jsonString  = [array mj_JSONString];
                self.params.orders = jsonString;
                
            }else {
            
                
//                itemModel *itemM      = [[itemModel alloc]init];
                NSMutableDictionary *itemM = [NSMutableDictionary dictionary];
//                itemM.packagedProductId = [self.packageId intValue];
                [itemM setObject:[NSNumber numberWithInt:[self.packageId intValue]] forKey:@"packagedProductId"];
                
                NSMutableArray *itemArray = [NSMutableArray array];
                for (int i = 0; i < self.packageproduce.count; i++) {
                    
                    Produce1Model *produce = self.packageproduce[i];
                    
                    SubOrderModel *subOrderModel     = [[SubOrderModel alloc]init];
                    //商品id
                    subOrderModel.productId          = [produce.id intValue];
                    //数量
                    subOrderModel.quantity           = 1;
                    //门店或者区域
                    if (![self.storeOrArea[i] isEqualToString:@"0"]) {
                        subOrderModel.storeSelectingType = self.storeOrArea[i];
                    }
                    
                    if ([self.allStoreArea[i] isKindOfClass:[NSArray class]]) {
                        
                        if ([self.storeOrArea[i] isEqualToString:@"store"]) {
                            
                            NSMutableArray *array = [NSMutableArray array];
                            for (ProduceStoresModel *model in self.allStoreArea[i]) {
                                [array addObject:model.id];
                            }
                            subOrderModel.stores             = [array componentsJoinedByString:@","];
                        }else {
                            
                            NSMutableArray *array = [NSMutableArray array];
                            for (NSDictionary *dic in self.allStoreArea[i]) {
                                [array addObject:[dic objectForKey:@"i"]];
                            }
                            subOrderModel.areas             = [array componentsJoinedByString:@","];
                        }
                    }
                    
                    if ([self.allSource[i] isKindOfClass:[NSArray class]]) {
                        
                        NSMutableArray *userSourceId     = [NSMutableArray array];
                        for (UserSourceModel *model in self.allSource[i]) {
                            [userSourceId addObject:model.id];
                        }
                        subOrderModel.items   = [userSourceId componentsJoinedByString:@","];
                    }
                    [itemArray addObject:subOrderModel.mj_keyValues];
                }
                
                [itemM setObject:itemArray forKey:@"items"];
                NSArray *array        = [NSArray arrayWithObject:itemM];
                NSString *jsonString  = [array mj_JSONString];
                self.params.orders = jsonString;
                
            }
            
            
            if (self.params.paymentMethod.length == 0) {
                [[HUDConfig shareHUD]Tips:@"请选择支付币种" delay:DELAY];
                return;
            }
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"下单后酒币将立即支付，请确认是否提交订单？" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self subOrder];
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }];
        return footer;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
            
            if (self.packageId.length != 0) {
                return 0;
            }
            return 110;
            
            break;
        case 1:
            return 80;
            break;
        case 2:
            
            return 120;//260
            
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:{
            sureOrdercell1 *cell1 = [[[NSBundle mainBundle] loadNibNamed:@"sureOrdercell1" owner:self options:nil] lastObject];
            cell1.sourceData = self.userSourceArr;
            return cell1;
        }
            break;
        case 1:{
            sureOrderCell2 *cell2 = [[[NSBundle mainBundle] loadNibNamed:@"sureOrderCell2" owner:self options:nil] lastObject];
            
            NSArray *coins = self.acceptableCoinTypes;
            for (NSString *name in coins) {
                
                if ([name isEqualToString:@"golden"]) {
                    
                    cell2.button1.userInteractionEnabled = YES;
                    cell2.button1.alpha = 1;
                    cell2.image1.alpha = 1;
                }
                
                if ([name isEqualToString:@"blue"]) {
                    
                    cell2.button2.userInteractionEnabled = YES;
                    cell2.button2.alpha = 1;
                    cell2.image2.alpha = 1;
                }
                
                if ([name isEqualToString:@"red"]) {
                    
                    cell2.button3.userInteractionEnabled = YES;
                    cell2.button3.alpha = 1;
                    cell2.image3.alpha = 1;
                }
                
                if ([name isEqualToString:@"black"]) {
                    
                    cell2.button4.userInteractionEnabled = YES;
                    cell2.button4.alpha = 1;
                    cell2.image4.alpha = 1;
                }
            }
            
            [cell2 choseCoinPay:^(NSString *coinStatus) {
                
                self.params.paymentMethod = coinStatus;
                if ([coinStatus isEqualToString:@"goldenCoin"]) {
                    
                    cell3.payCoinType.text = @"支付币种：金币";
                    return;
                }
                if ([coinStatus isEqualToString:@"blueCoin"]) {
                    
                    cell3.payCoinType.text = @"支付币种：蓝币";
                    return;
                }
                if ([coinStatus isEqualToString:@"redCoin"]) {
                    
                    cell3.payCoinType.text = @"支付币种：红币";
                    return;
                }
                if ([coinStatus isEqualToString:@"blackCoin"]) {
                    
                    cell3.payCoinType.text = @"支付币种：黑币";
                    return;
                }
                
                
                
            }];
            return cell2;
        }
            
            break;
        case 2:{
            
            cell3 = [[[NSBundle mainBundle] loadNibNamed:@"sureOrderCell3" owner:self options:nil] lastObject];
            cell3.priceLabel.text = [NSString stringWithFormat:@"资源金额：%@",self.proPrice];
            return cell3;
        }
            
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
            
            if (indexPath.row == 0) {
                
                UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
                SourceListViewController *sourceList = [SB instantiateViewControllerWithIdentifier:@"SourceListViewController"];
                sourceList.userSourceArr = self.userSourceArr;
                [self.navigationController pushViewController:sourceList animated:YES];
            }
            
            break;
            
        default:
            break;
    }
}

@end
