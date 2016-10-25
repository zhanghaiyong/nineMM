static NSString *appKey = @"ca5cfa7d71691b108f3b03f7";
static NSString *channel = @"Publish channel";
static BOOL isProduction = true;

#import <Foundation/Foundation.h>
#import <JPUSHService.h>

@interface JiPush : NSObject

@property(nonatomic, strong) NSString   *userId;
@property(nonatomic, strong) NSString   *aliasName;
@property(nonatomic, strong) NSString   *topicName;

+ (JiPush *)shareJpush;
- (void)addObserver;
- (void)registerPush:(NSDictionary *)launchOptions;
- (void)unregisterPush;
- (void)registerDeviceToken:(NSData *)deviceToken;
- (void)handleNotification:(NSDictionary *)userInfo;

- (void)setAlias:(NSString *)alias;
- (void)unsetAlias;
- (void)setTopic:(NSString *)topic;
- (void)unsetTopic;
//- (void)showLocalNotificationAtFront:(UILocalNotification *)notification;

@end
