//
//  ChosePayTypeController.m
//  Guide
//
//  Created by 张海勇 on 16/7/16.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ChosePayTypeController.h"

@interface ChosePayTypeController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UILabel *coinsLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinsExplainLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *rmbLabel;
@property (weak, nonatomic) IBOutlet UILabel *finalRmbLabel;
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
    
    self.finalRmbLabel.text = self.calculateCoinModel.rmb;
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


#pragma mark UITableViewDelegate && UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

@end
