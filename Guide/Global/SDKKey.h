//
//  SDKKey.h
//  Guide
//
//  Created by ksm on 16/4/28.
//  Copyright © 2016年 ksm. All rights reserved.
//

static NSString *RCIMKey = @"25wehl3uwcrnw";

#import <Foundation/Foundation.h>

@interface SDKKey : NSObject
+ (SDKKey *)shareSDKKey;
//短信验证
//- (void)SMSSDKKey;


//设置键盘自动关闭
- (void)IQKeyboard;

//容云
//- (void)RCIMKey;
//- (void)RCIMConnect;
@end
