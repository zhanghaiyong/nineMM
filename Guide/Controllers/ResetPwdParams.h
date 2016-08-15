//
//  ResetPwdParams.h
//  Guide
//
//  Created by 张海勇 on 16/8/9.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface ResetPwdParams : BaseParams

@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *password;
@property (nonatomic,strong)NSString *validCode;
@property (nonatomic,strong)NSString *phone;

@end
