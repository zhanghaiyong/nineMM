//
//  CoinRechargeCell1.m
//  Guide
//
//  Created by 张海勇 on 16/7/15.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "CoinRechargeCell1.h"

@implementation CoinRechargeCell1
{
    NSString *coinTypeCode;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  选择充值酒币类型
 */
- (IBAction)RechargeCoinType:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    if (button != self.firstBtn) {
        
        self.firstBtn.selected = NO;
        self.firstBtn = button;
        button.selected = YES;
    }
    
    switch (button.tag) {
        case 100:
            coinTypeCode = @"golden";
            break;
        case 101:
            coinTypeCode = @"white";
            break;
        case 102:
            coinTypeCode = @"blue";
            break;
        default:
            break;
    }
    
    self.block(coinTypeCode);
    
}

- (IBAction)sureRechargeAction:(id)sender {
    
    self.sureRechargeBlock();
    
}

- (void)getPackageList:(CoinRechargeCell1Block)block {

    _block = block;
}

- (void)sureRechargeBlock:(sureRecharge)block {

    _sureRechargeBlock = block;
}

@end
