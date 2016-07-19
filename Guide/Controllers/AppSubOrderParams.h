//
//  AppSubOrderParams.h
//  Guide
//
//  Created by 张海勇 on 16/7/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface AppSubOrderParams : BaseParams

@property (nonatomic,assign) int      amount;
@property (nonatomic,strong) NSString  *orders;
@property (nonatomic,strong) NSString *paymentMethod;

@end
