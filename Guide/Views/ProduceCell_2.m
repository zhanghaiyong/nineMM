//
//  ProduceCell_2.m
//  Guide
//
//  Created by 张海勇 on 16/5/28.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ProduceCell_2.h"

@implementation ProduceCell_2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setModelDic:(NSDictionary *)modelDic {

    _modelDic = modelDic;
    
    NSArray *allKeys = modelDic.allKeys;
    NSArray *allValues = modelDic.allValues;
    
    for (int i = 0; i<allValues.count; i++) {
        
        UILabel *key = [[UILabel alloc]initWithFrame:CGRectMake(10, 20+i*39, (self.width-20)/3, 40)];
        key.textAlignment = NSTextAlignmentCenter;
        key.text = allKeys[i];
        key.font = [UIFont systemFontOfSize:15];
        key.layer.borderColor = [UIColor blackColor].CGColor;
        key.layer.borderWidth = 1;
        [self.contentView addSubview:key];
        
        
        UILabel *value = [[UILabel alloc]initWithFrame:CGRectMake(key.right-1, key.top, (self.width-20)/3*2, 40)];
        value.textAlignment = NSTextAlignmentCenter;
        value.text = allValues[i];
        value.font = [UIFont systemFontOfSize:15];
        value.layer.borderColor = [UIColor blackColor].CGColor;
        value.layer.borderWidth = 1;
        [self.contentView addSubview:value];
    }
}

@end
