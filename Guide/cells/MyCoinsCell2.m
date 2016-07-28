//
//  MyCoinsCell2.m
//  Guide
//
//  Created by 张海勇 on 16/7/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MyCoinsCell2.h"

@implementation MyCoinsCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)RechargeAction:(id)sender {
    
    self.block();
}

- (void)toRechargeVC:(RechargeBlock)block {

    _block = block;
}
@end
