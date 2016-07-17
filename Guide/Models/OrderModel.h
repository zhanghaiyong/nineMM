//
//  OrderModel.h
//  Guide
//
//  Created by 张海勇 on 16/7/17.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic,strong)NSArray *buttons;
@property (nonatomic,strong)NSString *customImageId;
@property (nonatomic,strong)NSString *goodsName;
@property (nonatomic,strong)NSString *orderCreateDate;
@property (nonatomic,strong)NSString *orderId;
@property (nonatomic,strong)NSString *orderOrderStatus;
@property (nonatomic,strong)NSString *orderSn;
@property (nonatomic,strong)NSString *orderStatusName;
@property (nonatomic,strong)NSString *orderStatusTextColor;
@property (nonatomic,strong)NSString *paymentTime;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *productId;
@property (nonatomic,strong)NSString *productImageId;
@property (nonatomic,strong)NSString *productName;
@property (nonatomic,strong)NSString *quantity;
@property (nonatomic,strong)NSString *totalPrice;

@end
