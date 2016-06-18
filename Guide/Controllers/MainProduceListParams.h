//
//  MainProduceListParams.h
//  Guide
//
//  Created by 张海勇 on 16/6/17.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainProduceListParams : NSObject
//筛选条件
@property (nonatomic,strong) NSString *qryCategoryId;
//每一页的条数
@property (nonatomic,strong) NSString *rows;
//页号
@property (nonatomic,strong) NSString *page;

@end
