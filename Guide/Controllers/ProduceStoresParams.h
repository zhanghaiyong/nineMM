//
//  ProduceStoresParams.h
//  Guide
//
//  Created by 张海勇 on 16/7/17.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface ProduceStoresParams : BaseParams

@property (nonatomic,strong) NSString *productId;
@property (nonatomic,strong) NSString *areaIds;
@property (nonatomic,strong) NSString *keyword;
@property (nonatomic,assign) int      rows;
@property (nonatomic,assign) int      page;

@end
