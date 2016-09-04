//
//  GetOrderShopParams.h
//  Guide
//
//  Created by 张海勇 on 16/9/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface GetOrderShopParams : BaseParams

@property (nonatomic,strong)NSString *id;
@property (nonatomic,assign)int      rows;
@property (nonatomic,assign)int      page;

@end
