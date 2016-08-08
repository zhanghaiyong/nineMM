//
//  updateUserInfoParams.h
//  Guide
//
//  Created by 张海勇 on 16/8/8.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface updateUserInfoParams : BaseParams

/**
 *  用户类别  个人:person,单位:company
 */
@property (nonatomic,strong)NSString *type;
/**
 *  姓名
 */
@property (nonatomic,strong)NSString *name;
/**
 *  性别   男:male,女:female
 */
@property (nonatomic,strong)NSString *gender;
/**
 *  生日
 */
@property (nonatomic,strong)NSString *birth;
/**
 *  头像id
 */
@property (nonatomic,strong)NSString *avatarId;

@property (nonatomic,strong)NSString *attr1;
@property (nonatomic,strong)NSString *attr2;
@property (nonatomic,strong)NSString *attr3;

@end
