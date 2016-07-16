//
//  CoinsDetailParams.h
//  Guide
//
//  Created by 张海勇 on 16/7/16.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface CoinsDetailParams : BaseParams

@property (nonatomic,strong)NSString *coinTypeCode;
@property (nonatomic,assign)int      rows;
@property (nonatomic,assign)int      page;

@end
