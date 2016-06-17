//
//  MainStaticModel.h
//  Guide
//
//  Created by 张海勇 on 16/6/16.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ButtonsModel.h"
#import "GoodsTypeModel.h"
#import "TopBannersModel.h"

@interface MainStaticModel : NSObject<MJKeyValue>

@property (nonatomic,strong)NSArray *buttons;
@property (nonatomic,strong)NSArray *goodsTypes;
@property (nonatomic,strong)NSArray *topBanners;
@end
