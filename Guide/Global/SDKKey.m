//
//  SDKKey.m
//  Guide
//
//  Created by ksm on 16/4/28.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "SDKKey.h"
#import "IQKeyboardManager.h"
#import "KSMNetworkRequest.h"
@implementation SDKKey

+ (SDKKey *)shareSDKKey
{
    static SDKKey *sdkkey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sdkkey = [[SDKKey alloc] init];
    });
    
    return sdkkey;
}

////短信验证
//- (void)SMSSDKKey {
//
//    [SMSSDK registerApp:(NSString *)SMSKey withSecret:(NSString * )SMSecret];
//}

//设置键盘自动关闭
- (void)IQKeyboard {

    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = NO;
}

////容云
//- (void)RCIMKey {
//
//    [[RCIM sharedRCIM] initWithAppKey:(NSString *)RCIMKey];
//
//}

//- (void)RCIMConnect {
//
//    [[RCIM sharedRCIM] connectWithToken:@"Df7sGhhWXJPTbN7QdOMK13Igz9215S2aKsyFhtpheoTerUXZ/yyGwhB6wKkYf/X8c3b+6QyFBqP6ptOUPa0DaQ==" success:^(NSString *userId) {
//        
//        NSLog(@"%@",userId);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        [[RCIM sharedRCIM]setUserInfoDataSource:self];
//            
//        });
//        
//    } error:^(RCConnectErrorCode status) {
//        
//    } tokenIncorrect:^{
//        
//    }];
//}

/**
 *  获取用户信息。
 *
 *  @param userId     用户 Id。
 *  @param completion 用户信息
 */
//- (void)getUserInfoWithUserId:(NSString *)userId
//                   completion:(void (^)(RCUserInfo *userInfo))completion {
//    
//    RCUserInfo *currentUserInfo = [[RCIM sharedRCIM]currentUserInfo];
//    NSLog(@"currentUserInfo = %@   %@",currentUserInfo.userId,userId);
//    
//    if ([userId isEqualToString:currentUserInfo.userId]) {
//        
//        RCUserInfo *meInfo = [[RCUserInfo alloc]init];
//        meInfo.userId = userId;
//        meInfo.name = @"我";
//        meInfo.portraitUri = @"http://p0.qhimg.com/dr/200_200_/t0147d607a9498d9d6e.jpg";
//        return completion(meInfo);
//        
//    }
//    return completion(nil);
//}

@end
