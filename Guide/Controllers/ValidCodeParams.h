//
//  ValidCodeParams.h
//  Guide
//
//  Created by 张海勇 on 16/8/9.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface ValidCodeParams : BaseParams

@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *phone;
//reg:注册,resetPsw:重置密码,login:短信验证码登录
@property (nonatomic,strong)NSString *busiType;

@end
