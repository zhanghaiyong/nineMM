#import "JiPush.h"

@implementation JiPush
+ (JiPush *)shareJpush
{
    static JiPush *jpush = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jpush = [[JiPush alloc] init];
    });
    
    return jpush;
}

- (void)addObserver {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(method1) name:kJPFNetworkDidSetupNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(method2) name:kJPFNetworkDidCloseNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(method3) name:kJPFNetworkDidRegisterNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(method4) name:kJPFNetworkDidLoginNotification object:nil];
}

- (void)registerPush:(NSDictionary *)launchOptions {
    
    //极光推送 注册APNS类型
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
//    }
//else {
//        //categories 必须为nil
//        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//    }

    //注册
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel apsForProduction:isProduction];
    
}

- (void)unregisterPush {
    
    //    [JPUSHService ]
}

- (void)registerDeviceToken:(NSData *)deviceToken {
    
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)handleNotification:(NSDictionary *)userInfo {
    
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)showLocalNotificationAtFront:(UILocalNotification *)notification {
    
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

- (void)setAlias:(NSString *)alias {
    
    [JPUSHService setAlias:alias callbackSelector:@selector(exchane) object:self];
    
}
- (void)unsetAlias {
    
}

- (void)setTopic:(NSString *)topic {
    
}

- (void)unsetTopic {
    
    
}

- (void)exchane {
    
    NSLog(@"xvczdxv");
}

#pragma  mark notifitionMethod
- (void)method1 {
    
    NSLog(@"建立连接");
}

- (void)method2 {
    
    NSLog(@"关闭连接");
}

- (void)method3 {
    
    NSLog(@"注册成功");
}

- (void)method4 {
    
    NSLog(@"登录成功");
    NSString *registration = [JPUSHService registrationID];
    NSLog(@"%@",registration);
    
}
@end
