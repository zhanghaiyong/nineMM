//
//  OrderDetailCell4.m
//  Guide
//
//  Created by 张海勇 on 16/8/6.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "OrderDetailCell4.h"

@implementation OrderDetailCell4

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)cancleOrderAction:(id)sender {
    
    self.block();
}

- (void)returnBlock:(cancleBlock)block {

    _block = block;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
