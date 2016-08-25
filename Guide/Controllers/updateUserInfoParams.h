//
//  UpdateUserInfoParams.h
//  Guide
//
//  Created by 张海勇 on 16/8/13.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface UpdateUserInfoParams : BaseParams
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *gender;
@property (nonatomic,strong)NSString *birth;
@property (nonatomic,strong)NSString *avatarId;
@property (nonatomic,strong)NSString *email;
@property (nonatomic,strong)NSString *attr1;
@property (nonatomic,strong)NSString *attr2;
@property (nonatomic,strong)NSString *attr3;

@end
