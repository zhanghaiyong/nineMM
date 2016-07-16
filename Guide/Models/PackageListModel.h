//
//  PackageListModel.h
//  Guide
//
//  Created by 张海勇 on 16/7/15.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageListModel : NSObject

@property (nonatomic,strong) NSString *beginDate;
@property (nonatomic,strong) NSString *coinTypeId;
@property (nonatomic,strong) NSString *coinTypeName;
@property (nonatomic,strong) NSString *endDate;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *rangeRmbMax;
@property (nonatomic,strong) NSString *rangeRmbMin;
@property (nonatomic,strong) NSString *ratioCoin;
@property (nonatomic,strong) NSString *ratioRmb;

@end
