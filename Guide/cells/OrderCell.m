//
//  OrderCell.m
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)LookDetailAction:(id)sender {
    
    self.toOrderDetailBlock();
    
}
- (IBAction)dealOrderAction:(id)sender {
    
    self.dealOrderBlock();
    
}

- (void)tapToChechOrderDetail:(toOrderDetail)block {

    _toOrderDetailBlock = block;
}

- (void)tapDealOrder:(dealOrder)block {

    _dealOrderBlock = block;
}

@end
