#import "MyCoinsController.h"
#import "MyCoinsCell1.h"
#import "MyCoinsCell2.h"
#import "MyCoinsCell3.h"
#import "MyCoinsCell4.h"
#import "CoinsDetailViewCtrl.h"
#import "CoinsRechargeViewController.h"
@interface MyCoinsController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *coinModel;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyCoinsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的酒币";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSLog(@"我的酒币 = %@",self.persionModel.mj_keyValues);
    
    [self balanceData];

}

- (void)balanceData {

    [[HUDConfig shareHUD]alwaysShow];
    
    BaseParams *params = [[BaseParams alloc]init];
    
    
    FxLog(@"orderDetail = %@",params.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KGetLoginMemberCoinBalance params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"balanceData = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                coinModel = [dataDic objectForKey:@"retObj"];

//                self.black.text = model.black;
//                self.blue.text = model.blue;
//                self.golden.text = model.golden;
//                self.green.text = model.green;
//                self.red.text = model.red;
                
                [self.tableView reloadData];
//                
//                
//                //过期信息
//                if (![retObj objectForKey:@"expiryInfo"]) {
//                    
//                    NSDictionary *expiryInfo = [retObj objectForKey:@"expiryInfo"];
//                    
//                    self.expiryLabel.hidden = NO;
//                    self.expiryLabel.text = [NSString stringWithFormat:@"%@到%@过期",[expiryInfo objectForKey:@"amount"],[[expiryInfo objectForKey:@"expiryDate"] substringToIndex:10]];
//                }
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
        [[HUDConfig shareHUD]ErrorHUD :error.localizedDescription delay:DELAY];
    }];

    
}


#pragma mark UITableView Delegate &&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 0;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return self.persionModel.coins.count;
            break;
        case 3:
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
            return 100;
            break;
        case 1:
            return 50;
            break;
        case 2:
            return 60;
            break;
        case 3:
            return 50;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:{
        
            static NSString *ideitifier = @"cell1";
            MyCoinsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
            if (!cell) {
                 cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCoinsCell1" owner:self options:nil] lastObject];
            }
            //用户信息
            UIImageView *avatar = [cell.contentView viewWithTag:100];
            [Uitils cacheImagwWithSize:avatar.size imageID:[self.persionModel.memberInfo objectForKey:@"avatarImgId"] imageV:avatar placeholder:@"组-23"];
            
            UILabel *userName = [cell.contentView viewWithTag:101];
            userName.text = [self.persionModel.memberInfo objectForKey:@"departmentName"];
            UILabel *userType = [cell.contentView viewWithTag:102];
            userType.text = [self.persionModel.memberInfo objectForKey:@"nick"];
            return cell;
        }
            break;
        case 1:{
            
            static NSString *ideitifier = @"cell2";
            MyCoinsCell2 *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCoinsCell2" owner:self options:nil] lastObject];
            }
            [cell toRechargeVC:^{
                
                UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
                CoinsRechargeViewController *coinDetailVC = [mainSB instantiateViewControllerWithIdentifier:@"CoinsRechargeViewController"];
                [self.navigationController pushViewController:coinDetailVC animated:YES];
            }];
            return cell;
        }
            break;
        case 2:{
            
            static NSString *ideitifier = @"cell3";
            MyCoinsCell3 *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCoinsCell3" owner:self options:nil] lastObject];
            }
            
            NSDictionary *coins = self.persionModel.coins[indexPath.row];
            cell.coinImage.image = [UIImage imageNamed:[Uitils toImageName:coins.allKeys[0]]];
            cell.coinName.text = [Uitils toChinses:coins.allKeys[0]];
            cell.usableCoin.text = [NSString stringWithFormat:@"%@",coins.allValues[0]];
            
            
            if ([coins.allKeys[0] isEqualToString:@"red"]) {
                
                if (((NSDictionary *)[coinModel objectForKey:@"expiryInfo"]).count != 0) {
                    
                    cell.expireLabel.hidden = NO;
                    cell.expireLabel.text = [NSString stringWithFormat:@"%@到%@过期",[[coinModel objectForKey:@"expiryInfo"] objectForKey:@"amount"],[[[coinModel objectForKey:@"expiryInfo"] objectForKey:@"expiryDate"] substringToIndex:10]];
                }
            }
            
            return cell;
        }
            break;
        case 3:{
            
            static NSString *ideitifier = @"cell4";
            MyCoinsCell4 *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MyCoinsCell4" owner:self options:nil] lastObject];
            }
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        
        NSDictionary *coins = self.persionModel.coins[indexPath.row];

        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        CoinsDetailViewCtrl *coinDetailVC = [mainSB instantiateViewControllerWithIdentifier:@"CoinsDetailViewCtrl"];
        coinDetailVC.coinTypeCode = coins.allKeys[0];
        [self.navigationController pushViewController:coinDetailVC animated:YES];
        
    }else if (indexPath.section == 3) {
    
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        CoinsDetailViewCtrl *coinDetailVC = [mainSB instantiateViewControllerWithIdentifier:@"CoinsDetailViewCtrl"];
        [self.navigationController pushViewController:coinDetailVC animated:YES];
    }
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}
@end
