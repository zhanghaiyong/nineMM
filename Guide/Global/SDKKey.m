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


@end
