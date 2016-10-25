#import <UIKit/UIKit.h>
#import <JPUSHService.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,JPUSHRegisterDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)appDeg;
//- (void)showTabBarPage;

@end

