
// 酒币充值

#import "CoinsRechargeViewController.h"
#import "ChosePayTypeController.h"
#import "CoinRechargeCell1.h"
#import "CoinRechargeCell2.h"
#import "CoinRechargeCell3.h"
#import "PackageCell.h"

#import "CoinRechargePackageParams.h"
#import "CalculateCoinParams.h"

#import "PackageListModel.h"
#import "CalculateCoinModel.h"

@interface CoinsRechargeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray     *packageArr;
    NSInteger          packageIndex;
    CalculateCoinModel *calculateCoinModel;
    CoinRechargeCell1  *coinRechargeCell1;
    CoinRechargeCell2  *coinRechargeCell2;
    CoinRechargeCell3  *coinRechargeCell3;
    CGFloat            cell2Height;
}

@property (nonatomic,strong)CoinRechargePackageParams *packageParams;
@property (nonatomic,strong)CalculateCoinParams       *calculateCoinParams;
@property (weak, nonatomic) IBOutlet UITableView      *bigTableView;
@end

@implementation CoinsRechargeViewController

//酒币换算
- (CalculateCoinParams *)calculateCoinParams {
    
    if (_calculateCoinParams == nil) {
        CalculateCoinParams *calculateCoinParams = [[CalculateCoinParams alloc]init];
        _calculateCoinParams = calculateCoinParams;
    }
    return _calculateCoinParams;
}

//获取套餐
- (CoinRechargePackageParams *)packageParams {

    if (_packageParams == nil) {
        CoinRechargePackageParams *packageParams = [[CoinRechargePackageParams alloc]init];
        _packageParams = packageParams;
    }
    return _packageParams;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    packageArr = [NSMutableArray array];
     [self getPackageList:@"golden"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"酒币充值";
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


- (void)getPackageList:(NSString *)TypeCode {

    [[HUDConfig shareHUD]alwaysShow];
    
    [packageArr removeAllObjects];
    
    self.packageParams.coinTypeCode = TypeCode;
    
    [KSMNetworkRequest postRequest:KCoinRechargePackageList params:self.packageParams.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"getPackageList = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                packageArr = [PackageListModel mj_objectArrayWithKeyValuesArray:[[dataDic objectForKey:@"retObj"] objectForKey:@"rows"]];
                packageIndex = packageArr.count+1;
                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
                CoinRechargeCell1 *cell = (CoinRechargeCell1 *)[self.bigTableView cellForRowAtIndexPath:index];
                [cell.smallTableVIew reloadData];
            }
            
        }else if ([[dataDic objectForKey:@"retCode"]integerValue] == -2){
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            LoginViewController *loginVC = [SB instantiateViewControllerWithIdentifier:@"LoginViewController"];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:navi animated:YES completion:nil];
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
        [[HUDConfig shareHUD]ErrorHUD:error.localizedDescription delay:DELAY];
    }];
}

//计算酒币充值套餐人民币与酒币的换算
- (void)calculateCoinPackageRecharge {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    FxLog(@"calculateCoinPackageRecharge = %@",self.calculateCoinParams.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KRMBtoCoins params:self.calculateCoinParams.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"计算酒币充值套餐人民币与酒币的换算 = %@",dataDic);
        
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                calculateCoinModel = [CalculateCoinModel mj_objectWithKeyValues:[dataDic objectForKey:@"retObj"]];
                
                cell2Height = 180;
                NSIndexSet *section1=[[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(1, 2)];
                [self.bigTableView reloadSections:section1 withRowAnimation:UITableViewRowAnimationTop];
                
                coinRechargeCell3.sureRechargeBtn.alpha = 1;
                coinRechargeCell3.sureRechargeBtn.userInteractionEnabled = YES;
                [coinRechargeCell1.priceLabel resignFirstResponder];
            }
            
        }else {
            
            coinRechargeCell1.priceLabel.text = @"";
            [[HUDConfig shareHUD] dismiss];
            coinRechargeCell1.tipsLabel.text = [dataDic objectForKey:@"retMsg"];
                [UIView animateWithDuration:1.5 animations:^{
                    
                    coinRechargeCell1.tipsLabel.alpha = 1;
                    
                } completion:^(BOOL finished) {
                    
                    coinRechargeCell1.tipsLabel.alpha = 0;
                }];
        }
        
    } failure:^(NSError *error) {
        
        [[HUDConfig shareHUD]ErrorHUD:error.localizedDescription delay:DELAY];
    }];
}


#pragma mark UITableViewDelegate&&UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    
    if (tableView == self.bigTableView) {
        
        if (section == 1) {
            
            return SCREEN_HEIGHT-390-cell2Height-64-50;
        }
            return 0.1;
    }
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.bigTableView) {
        
        switch (indexPath.section) {
            case 0:
                return 390;
                break;
            case 1:
                return cell2Height;
                break;
            case 2:
                return 50;
                break;
                
            default:
                break;
        }
    }
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (tableView == self.bigTableView) {
        return 3;
    }else {
    
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.bigTableView) {
        
        return 1;
    }
    return packageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.bigTableView) {
        
        switch (indexPath.section) {
            case 0:{
                
                coinRechargeCell1 = [[[NSBundle mainBundle]loadNibNamed:@"CoinRechargeCell1" owner:self options:nil]lastObject];
                coinRechargeCell1.smallTableVIew.delegate = self;
                coinRechargeCell1.smallTableVIew.dataSource = self;
                
                //酒币种类切换
                [coinRechargeCell1 getPackageList:^(NSString *coinType) {
                    
                    [self getPackageList:coinType];
                    
                }];
                
                //确认充值
                [coinRechargeCell1 sureRechargeBlock:^{
                    //充值金额
                    self.calculateCoinParams.rmb = [coinRechargeCell1.priceLabel.text intValue];
                    
                    //选择了
                    if (packageIndex < packageArr.count) {
                     
                        PackageListModel *model = packageArr[packageIndex];
                        self.calculateCoinParams.packageId = [model.id intValue];
                    }
//                    else {
//                    
//                        [[HUDConfig shareHUD]Tips:@"请选择充值套餐" delay:DELAY];
//                    }
                    
                    [self calculateCoinPackageRecharge];
                    
                }];
                return coinRechargeCell1;
            }
                break;
            case 1: {
                
                coinRechargeCell2 = [[[NSBundle mainBundle]loadNibNamed:@"CoinRechargeCell2" owner:self options:nil]lastObject];
                
                if (calculateCoinModel) {
                    //币种
                    coinRechargeCell2.coinType.text = calculateCoinModel.coinTypeName;
                    //酒币数量
                    coinRechargeCell2.coins.text = [NSString stringWithFormat:@"%@%@",calculateCoinModel.coin,coinRechargeCell2.coinType.text];
                    //金额
                    coinRechargeCell2.rmbLabel.text = calculateCoinModel.rmb;
                    
                    if ([calculateCoinModel.expiryDate integerValue] > 0) {
                        
                        coinRechargeCell2.validDate.text = calculateCoinModel.expiryDate;
                    }else {
                    
                        coinRechargeCell2.validDate.text = @"永久";
                    }
                }
                
                return coinRechargeCell2;
            }
                break;
                
            case 2: {
                
                coinRechargeCell3 = [[[NSBundle mainBundle]loadNibNamed:@"CoinRechargeCell3" owner:self options:nil]lastObject];
                
                if (calculateCoinModel) {
                    //金额
                    coinRechargeCell3.moneyLabel.text = [NSString stringWithFormat:@"%@元人民币",calculateCoinModel.rmb];
                }
                
                if (cell2Height > 0) {
                    
                    coinRechargeCell3.sureRechargeBtn.alpha = 1;
                    coinRechargeCell3.sureRechargeBtn.userInteractionEnabled = YES;
                }
                
                [coinRechargeCell3 userBlockToVC:^{
                    
                    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
                    ChosePayTypeController *payType = [SB instantiateViewControllerWithIdentifier:@"ChosePayTypeController"];
                    payType.calculateCoinModel = calculateCoinModel;
                    payType.packageId = self.calculateCoinParams.packageId;
                    [self.navigationController pushViewController:payType animated:YES];
                    
                }];
                return coinRechargeCell3;
            }
                break;
            default:
                break;
        }
    }
    
    static NSString *identifier = @"cell";
    PackageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PackageCell" owner:self options:nil]lastObject];
    }
    
    if (indexPath.row == packageIndex) {
        
        cell.isSelect.selected = YES;
    }
    
    PackageListModel *model = packageArr[indexPath.row];
    
    if ([self.packageParams.coinTypeCode isEqualToString:@"red"]) {
        
       cell.label1.text = [NSString stringWithFormat:@"有效期:%@,范围:%@~%@",model.expiryDate,model.rangeRmbMin,model.rangeRmbMax];
        
    }else {
        cell.label1.text = [NSString stringWithFormat:@"比例:%@,充值金额范围:%@~%@",model.ratioRmb,model.rangeRmbMin,model.rangeRmbMax];
    }
    cell.label2.text = [NSString stringWithFormat:@"(%@)",model.name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView != self.bigTableView) {
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        CoinRechargeCell1 *cell1 = (CoinRechargeCell1 *)[self.bigTableView cellForRowAtIndexPath:index];
        [cell1.smallTableVIew reloadData];
        
        NSLog(@"%ld",indexPath.row);
        packageIndex = indexPath.row;
        
        PackageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.isSelect.selected = YES;
    }
}

@end
