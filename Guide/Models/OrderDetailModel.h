//
//  OrderDetailModel.h
//  Guide
//
//  Created by 张海勇 on 16/7/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderItemModel.h"
@interface OrderDetailModel : NSObject<MJKeyValue>

@property (nonatomic,strong) NSDictionary *address;
@property (nonatomic,strong) NSString     *goodsName;
@property (nonatomic,strong) NSString     *orderCreateDate;
@property (nonatomic,strong) NSString     *orderId;
@property (nonatomic,strong) NSArray      *orderItems;
@property (nonatomic,strong) NSString     *orderOrderStatus;
@property (nonatomic,strong) NSString     *orderSn;
@property (nonatomic,strong) NSString     *orderStepCode;
@property (nonatomic,strong) NSString     *orderStepName;
@property (nonatomic,strong) NSString     *orderStepTextColor;
@property (nonatomic,strong) NSString     *paymentMethodCode;
@property (nonatomic,strong) NSString     *paymentMethodName;
@property (nonatomic,strong) NSString     *paymentTime;
@property (nonatomic,strong) NSString     *totalPrice;

@end
