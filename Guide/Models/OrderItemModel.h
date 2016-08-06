//
//  OrderItemModel.h
//  Guide
//
//  Created by 张海勇 on 16/8/6.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderItemModel : NSObject

@property (nonatomic,strong)NSString *goodsName;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *productId;
@property (nonatomic,strong)NSString *productImageId;
@property (nonatomic,strong)NSString *productName;
@property (nonatomic,strong)NSString *quantity;
@end
