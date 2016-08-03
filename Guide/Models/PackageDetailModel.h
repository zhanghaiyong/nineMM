//
//  PackageDetailModel.h
//  Guide
//
//  Created by 张海勇 on 16/8/3.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Produce1Model.h"
@interface PackageDetailModel : NSObject<MJKeyValue>

@property (nonatomic,strong) NSArray  *acceptableCoinTypes;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSArray  *products;
@property (nonatomic,strong) NSString *stock;

@end
