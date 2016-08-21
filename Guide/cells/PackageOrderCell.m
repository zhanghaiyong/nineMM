//
//  PackageOrderCell.m
//  Guide
//
//  Created by 张海勇 on 16/8/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "PackageOrderCell.h"
#import "SmallOrderCell1.h"
#import "SmallORderCell2.h"
@implementation PackageOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderModel:(OrderModel *)orderModel {

    _orderModel = orderModel;
    
    if (orderModel.packagedProductName != nil) {
        
        self.packageName.text = [NSString stringWithFormat:@"打包套餐：%@",orderModel.packagedProductName];
    }else {
    
        self.packageName.text = @"";
        self.packageNameH.constant = 0;
    }
    
    self.orderCode.text = [NSString stringWithFormat:@"%@：%@",orderModel.orderTypeName,orderModel.orderSn];
    [self.orderStatus setTitle:[NSString stringWithFormat:@" %@ ",orderModel.orderStepName] forState:UIControlStateNormal];
    [self.orderStatus setTitleColor:[Uitils colorWithHex:(unsigned long)orderModel.orderStepTextColor] forState:UIControlStateNormal];
    self.orderStatus.layer.borderColor = [Uitils colorWithHex:(unsigned long)orderModel.orderStepTextColor].CGColor;
    self.orderTime.text = orderModel.orderCreateDate;
    self.coins.text = [NSString stringWithFormat:@"%@ %@",orderModel.totalPrice,[orderModel.paymentMethodName stringByReplacingOccurrencesOfString:@"支付" withString:@""]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.orderModel.orderItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.orderModel.orderType isEqualToString:@"payment"] && self.orderModel.packagedProductName!=nil) { //套餐
        return 60;
    }else {
    
        return 30;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.orderModel.orderType isEqualToString:@"payment"] && self.orderModel.packagedProductName!=nil) { //套餐
        SmallOrderCell1 *cell1 = [[[NSBundle mainBundle] loadNibNamed:@"SmallOrderCell1" owner:self options:nil] lastObject];
        
        return cell1;
        
    }else {
        
        SmallORderCell2 *cell2 = [[[NSBundle mainBundle] loadNibNamed:@"SmallORderCell2" owner:self options:nil] lastObject];
        
        NSDictionary *dic = self.orderModel.orderItems[indexPath.row];
        cell2.name.text = [dic objectForKey:@"productName"];
        cell2.coins.text = [NSString stringWithFormat:@"%@酒币 x %@",[dic objectForKey:@"price"],[dic objectForKey:@"quantity"]];
        return cell2;
    }
}

@end
