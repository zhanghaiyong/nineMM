//
//  UserSourceModel.h
//  Guide
//
//  Created by 张海勇 on 16/7/17.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSourceModel : NSObject<NSCopying>

@property (nonatomic,strong)NSString *code;
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *name;

@end
