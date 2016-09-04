//
//  ChosePayTypeController.m
//  Guide
//
//  Created by 张海勇 on 16/7/16.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ChosePayTypeController.h"
#import "WineCoinsRechargeParams.h"
#import "PayAlertViewController.h"
@interface ChosePayTypeController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UILabel *coinsLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinsExplainLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *rmbLabel;
@property (weak, nonatomic) IBOutlet UILabel *finalRmbLabel;
//@property (weak, nonatomic) IBOutlet UILabel *expityLabel;
@end

@implementation ChosePayTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付方式";
    
    [self showData];
}

- (void)showData {

    //币种
    self.coinsLabel.text = self.calculateCoinModel.coinTypeName;
    //酒币数量
    self.coinCountLabel.text = [NSString stringWithFormat:@"%@%@",self.calculateCoinModel.coin,self.coinsLabel.text];
    //金额
    self.rmbLabel.text = self.calculateCoinModel.rmb;
    
    self.finalRmbLabel.text = [NSString stringWithFormat:@"%@元",self.calculateCoinModel.rmb];
    
//    if ([self.calculateCoinModel.expiryDate integerValue] > 0) {
//        
//        self.expityLabel.text = self.calculateCoinModel.expiryDate;
//    }else {
//        
//        self.expityLabel.text = @"永久";
//    }
}

//选择支付方式
- (IBAction)payTypeAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    if (button != self.firstBtn) {
        
        self.firstBtn.selected = NO;
        self.firstBtn = button;
        button.selected = YES;
    }
}


- (IBAction)surePayAction:(id)sender {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    WineCoinsRechargeParams *params = [[WineCoinsRechargeParams alloc]init];
    params.packageId = self.packageId;
    params.rmb = [self.calculateCoinModel.rmb intValue];
    params.paymentMethodCode = @"offline";
    
    FxLog(@"surePayAction = %@",params.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KInitiatePackageCoinRecharge params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"surePayAction = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
        UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        PayAlertViewController *paySuccessALert = [SB instantiateViewControllerWithIdentifier:@"PayAlertViewController"];
        paySuccessALert.orderId = [[dataDic objectForKey:@"retObj"] objectForKey:@"orderId"];
        [self.navigationController pushViewController:paySuccessALert animated:YES];
        
    } failure:^(NSError *error) {
        
    }];

}


#pragma mark UITableViewDelegate && UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 2) {
        
       return SCREEN_HEIGHT-260-64-70;
    }
    
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

@end
