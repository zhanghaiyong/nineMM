//
//  UpdatePwdParams.h
//  Guide
//
//  Created by 张海勇 on 16/8/2.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface UpdatePwdParams : BaseParams

@property (nonatomic,strong)NSString *oldPassword;
@property (nonatomic,strong)NSString *password;

@end
