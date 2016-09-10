//
//  OrderDetailCell4.h
//  Guide
//
//  Created by 张海勇 on 16/8/6.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCell4 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderCode;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UILabel *buyUnit;

@property (weak, nonatomic) IBOutlet UILabel *OrderPeople;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *payMethod;

@property (weak, nonatomic) IBOutlet UILabel *packageName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *packageH;
@property (weak, nonatomic) IBOutlet UILabel *orderType;
@end
