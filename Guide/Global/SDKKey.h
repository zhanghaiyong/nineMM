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
