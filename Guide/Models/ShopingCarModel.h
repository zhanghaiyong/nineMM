//
//  ShopingCarModel.h
//  Guide
//
//  Created by 张海勇 on 16/8/14.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface ShopingCarModel : NSObject<NSCoding>

@property (nonatomic,strong)NSString *fullName;

/**
 *  商品id
 */
@property (nonatomic,strong)NSString *productId;
/**
 *  门店或者资源
 */
@property (nonatomic,strong)NSString *storeSelectingType;
/**
 *  门店id
 */
@property (nonatomic,strong)NSString *storesId;
/**
 *  区域id
 */
@property (nonatomic,strong)NSString *areasId;
/**
 *  资源id
 */
@property (nonatomic,strong)NSArray *items;
/**
 *  价格
 */
@property (nonatomic,strong)NSString *amount;
@end
