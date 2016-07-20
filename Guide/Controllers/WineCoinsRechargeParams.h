//
//  WineCoinsRechargeParams.h
//  Guide
//
//  Created by 张海勇 on 16/7/21.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface WineCoinsRechargeParams : BaseParams

@property (nonatomic,assign)int packageId;
@property (nonatomic,assign)int rmb;
@property (nonatomic,strong)NSString *paymentMethodCode;
@end
