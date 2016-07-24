//
//  FeatureParams.h
//  Guide
//
//  Created by 张海勇 on 16/7/25.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface FeatureParams : BaseParams

@property (nonatomic,strong)NSString *feature;
@property (nonatomic,strong)NSString *keyword;
@property (nonatomic,assign)int rows;
@property (nonatomic,assign)int page;

@end
