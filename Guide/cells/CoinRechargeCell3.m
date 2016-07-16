//
//  CoinRechargeCell3.m
//  Guide
//
//  Created by 张海勇 on 16/7/16.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "CoinRechargeCell3.h"

@implementation CoinRechargeCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)toChosePayMethod:(id)sender {
    
    self.block();
    
}

- (void)userBlockToVC:(toChosePayMethodBlock)block {

    _block = block;
}
@end
