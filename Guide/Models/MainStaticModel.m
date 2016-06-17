//
//  MainStaticModel.m
//  Guide
//
//  Created by 张海勇 on 16/6/16.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MainStaticModel.h"

@implementation MainStaticModel

//实现这个方法，就会自动吧数组中的字典转化成对应的模型
+ (NSDictionary *)objectClassInArray {
    
    return @{@"buttons":[ButtonsModel class],@"goodsTypes":[GoodsTypeModel class],@"topBanners":[TopBannersModel class]};
}


@end
