//
//  BagOrderCell.m
//  Guide
//
//  Created by 张海勇 on 16/8/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "OtherOrderCell.h"

@implementation OtherOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderModel:(OrderModel *)orderModel {

    _orderModel = orderModel;
    self.orderCode.text = [NSString stringWithFormat:@"%@：%@",orderModel.orderTypeName,orderModel.orderSn];
    
    [self.orderStatus setTitle:[NSString stringWithFormat:@" %@ ",orderModel.orderStepName] forState:UIControlStateNormal];
    [self.orderStatus setTitleColor:[Uitils colorWithHex:(unsigned long)orderModel.orderStepTextColor] forState:UIControlStateNormal];
    self.orderStatus.layer.borderColor = [Uitils colorWithHex:(unsigned long)orderModel.orderStepTextColor].CGColor;
    self.name.text = [orderModel.orderItems[0]objectForKey:@"coinRechargePackageName"];
    self.coins.text = [NSString stringWithFormat:@"%@ %@",[orderModel.orderItems[0]objectForKey:@"coinAmount"],[orderModel.orderItems[0]objectForKey:@"coinType"]];
    self.orderTime.text = orderModel.orderCreateDate;
    self.rmb.text = [NSString stringWithFormat:@"%@ 人民币",[orderModel.orderItems[0]objectForKey:@"rmbAmount"]];
}

@end
