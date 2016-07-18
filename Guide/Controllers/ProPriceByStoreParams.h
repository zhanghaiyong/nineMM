//
//  ProPriceByStoreParams.h
//  Guide
//
//  Created by 张海勇 on 16/7/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface ProPriceByStoreParams : BaseParams
/**
 *  资源商品ID
 */
@property (nonatomic,strong)NSString *productId;
/**
 *  门店选择方式
 */
@property (nonatomic,strong)NSString *storeSelectingType;
/**
 *  区域id列表
 */
@property (nonatomic,strong)NSString *areaIds;
/**
 *  门店id列表
 */
@property (nonatomic,strong)NSString *storeIds;

@end
