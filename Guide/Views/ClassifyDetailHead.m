//
//  ClassifyDetailHead.m
//  Guide
//
//  Created by 张海勇 on 16/5/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ClassifyDetailHead.h"

@implementation ClassifyDetailHead


//1000为时间 1001为折扣 1002为筛选
- (IBAction)tapButtonAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    if ([self.delegate respondsToSelector:@selector(searchterm:)]) {
        
        [self.delegate searchterm:button.tag];
    }
}

@end
