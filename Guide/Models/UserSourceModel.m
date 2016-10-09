//
//  UserSourceModel.m
//  Guide
//
//  Created by 张海勇 on 16/7/17.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "UserSourceModel.h"

@implementation UserSourceModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder  encodeObject:_code forKey:@"code"];
    [aCoder encodeObject:_id forKey:@"id"];
    [aCoder encodeObject:_name forKey:@"name"];

}

//解的时候调用，告诉系统哪个属性要解档，如何解档
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        //一定要赋值
        _code = [aDecoder decodeObjectForKey:@"code"];
        _id  = [aDecoder decodeObjectForKey:@"id"];
        _name  = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone {

    return nil;
}

@end
