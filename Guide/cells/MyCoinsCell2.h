//
//  MyCoinsCell2.h
//  Guide
//
//  Created by 张海勇 on 16/7/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

typedef void(^RechargeBlock)(void);

#import <UIKit/UIKit.h>

@interface MyCoinsCell2 : UITableViewCell

@property (nonatomic,copy)RechargeBlock block;

- (void)toRechargeVC:(RechargeBlock)block;

@end
