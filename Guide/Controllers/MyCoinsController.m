#import "MyCoinsController.h"
//#import "TitleView.h"
#import "balanceCoinModel.h"
#import "CoinsDetailViewCtrl.h"
@interface MyCoinsController ()

//可用
@property (weak, nonatomic) IBOutlet UILabel *golden;
@property (weak, nonatomic) IBOutlet UILabel *black;
@property (weak, nonatomic) IBOutlet UILabel *red;
@property (weak, nonatomic) IBOutlet UILabel *blue;
@property (weak, nonatomic) IBOutlet UILabel *green;

//冻结
@property (weak, nonatomic) IBOutlet UILabel *FreezeGolden;
@property (weak, nonatomic) IBOutlet UILabel *FreezeBlack;
@property (weak, nonatomic) IBOutlet UILabel *FreezeRed;
@property (weak, nonatomic) IBOutlet UILabel *FreezeBlue;
@property (weak, nonatomic) IBOutlet UILabel *FreezeGreen;
@end

@implementation MyCoinsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的酒币";
    
    NSLog(@"我的酒币 = %@",self.persionModel);
    
//    //头部
//    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    titleView.normalColor = lever2Color;
//    titleView.backgroundColor = [UIColor whiteColor];
//    titleView.selectedColor = specialRed;
//    titleView.titleArray = @[@"全部",@"金币",@"绿币",@"黑币",@"红币",@"蓝币"];
//    
//    [titleView TitleViewCallBack:^(NSInteger btnTag) {
//        
//    }];
//    
//    self.tableView.tableHeaderView = titleView;
    //用户信息
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell1 = [self.tableView cellForRowAtIndexPath:index1];
    UIImageView *avatar = [cell1.contentView viewWithTag:100];
    [Uitils cacheImagwWithSize:avatar.size imageID:[self.persionModel.memberInfo objectForKey:@"avatarImgId"] imageV:avatar placeholder:nil];
    
    UILabel *userName = [cell1.contentView viewWithTag:101];
    userName.text = [self.persionModel.memberInfo objectForKey:@"departmentName"];
    UILabel *userType = [cell1.contentView viewWithTag:102];
    userType.text = [self.persionModel.memberInfo objectForKey:@"nick"];
    
    //金币
    for (NSDictionary *coinDic in self.persionModel.coins) {
        
        if ([coinDic.allKeys containsObject:@"black"]) {
            
            self.black.text = [NSString stringWithFormat:@"%@",[coinDic objectForKey:@"black"]];
            
        }else if ([coinDic.allKeys containsObject:@"red"]) {
            
            self.red.text = [NSString stringWithFormat:@"%@",[coinDic objectForKey:@"red"]];
            
        }else if ([coinDic.allKeys containsObject:@"blue"]) {
            
            self.blue.text = [NSString stringWithFormat:@"%@",[coinDic objectForKey:@"blue"]];
            
        }else if ([coinDic.allKeys containsObject:@"golden"]) {
            
            self.golden.text = [NSString stringWithFormat:@"%@",[coinDic objectForKey:@"golden"]];
            
        }else {
        
            self.green.text = [NSString stringWithFormat:@"%@",[coinDic objectForKey:@"green"]];
        }
    }
    
    
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
                
                NSDictionary *retObj = [dataDic objectForKey:@"retObj"];
                balanceCoinModel *model = [balanceCoinModel mj_objectWithKeyValues:retObj];
                self.black.text = model.black;
                self.blue.text = model.blue;
                self.golden.text = model.golden;
                self.green.text = model.green;
                self.red.text = model.red;
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
        
        [[HUDConfig shareHUD]ErrorHUD :error.localizedDescription delay:DELAY];
    }];

    
}


#pragma mark UITableView Delegate &&DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 2) {
        
        NSString *coinTypeCode;
        
        switch (indexPath.row) {
            case 0:
                
                coinTypeCode = @"golden";
                
                break;
            case 1:
                
                coinTypeCode = @"black";
                
                break;
            case 2:
                
                coinTypeCode = @"red";
                
                break;
            case 3:
                
                coinTypeCode = @"blue";
                
                break;
            case 4:
                
                coinTypeCode = @"green";
                
                break;
                
            default:
                break;
        }
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        CoinsDetailViewCtrl *coinDetailVC = [mainSB instantiateViewControllerWithIdentifier:@"CoinsDetailViewCtrl"];
        coinDetailVC.coinTypeCode = coinTypeCode;
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
