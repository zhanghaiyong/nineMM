//
//  ScenicHead.m
//  Guide
//
//  Created by ksm on 16/4/11.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ScenicHead.h"

@implementation ScenicHead

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _banner = [[ZHYBannerView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height-30)];
        _banner.imageArray = @[@"pic_cicada_iphone",@"pic_cicada_iphone",@"pic_cicada_iphone"];
        [self addSubview:_banner];
        
        _tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _banner.bottom, self.width, 30)];
        _tipsLabel.text = @"资源类型";
        _tipsLabel.font = lever2Font;
        _tipsLabel.textColor = lever1Color;
        [self addSubview:_tipsLabel];
    }
    return self;
}

@end
