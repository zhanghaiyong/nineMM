//
//  sureOrderCell2.m
//  Guide
//
//  Created by 张海勇 on 16/7/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "sureOrderCell2.h"

@implementation sureOrderCell2


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)coinTypeAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    if (button != self.firstBtn) {
        
        self.firstBtn.selected = NO;
        self.firstBtn = button;
        button.selected = YES;
    }
    
    NSString *coinStatus;
    switch (button.tag) {
        case 100: //金币
            coinStatus = @"goldenCoin";
            break;
        case 101: //蓝币
             coinStatus = @"blueCoin";
            break;
        case 102: //红币
             coinStatus = @"redCoin";
            break;
        case 103: //黑币
             coinStatus = @"blackCoin";
            break;
            
        default:
            break;
    }
    
    self.block(coinStatus);
    
    
}

- (void)choseCoinPay:(sureOrderCell2Block)block {

    _block = block;
}
@end