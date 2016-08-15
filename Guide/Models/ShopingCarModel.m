//
//  ShopingCarModel.m
//  Guide
//
//  Created by 张海勇 on 16/8/14.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ShopingCarModel.h"

@implementation ShopingCarModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder  encodeObject:_fullName forKey:@"fullName"];
    [aCoder  encodeObject:_productId forKey:@"productId"];
    [aCoder encodeObject:_storeSelectingType forKey:@"storeSelectingType"];
    [aCoder encodeObject:_storesId forKey:@"storesId"];
    [aCoder encodeObject:_areasId forKey:@"areasId"];
    [aCoder encodeObject:_items forKey:@"items"];
    [aCoder  encodeObject:_amount forKey:@"amount"];
}

//解的时候调用，告诉系统哪个属性要解档，如何解档
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        _fullName = [aDecoder decodeObjectForKey:@"fullName"];
        _productId = [aDecoder decodeObjectForKey:@"productId"];
        _storeSelectingType  = [aDecoder decodeObjectForKey:@"storeSelectingType"];
        _storesId  = [aDecoder decodeObjectForKey:@"storesId"];
        _areasId  = [aDecoder decodeObjectForKey:@"areasId"];
        _items  = [aDecoder decodeObjectForKey:@"items"];
        _amount  = [aDecoder decodeObjectForKey:@"amount"];
    }
    return self;
}


@end
