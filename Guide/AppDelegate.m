#import "AppDelegate.h"
#import "SDKKey.h"
#import "LaunchViewController.h"
#import "LoginViewController.h"
#import "PageInfo.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark configureAPIKey
- (void)configure {
    
    //设置主导航栏背景色
    [[UINavigationBar appearance] setBarTintColor:TintColor];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           lever1Color,
                                                           NSForegroundColorAttributeName,
                                                           nil, NSShadowAttributeName,
                                                           [UIFont boldSystemFontOfSize:17],
                                                           NSFontAttributeName, nil]];
//    [[UITabBar appearance] setTintColor:TintColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:lever2Color} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:MainColor} forState:UIControlStateSelected];
}



+ (AppDelegate *)appDeg {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Uitils reach];
    
    //设置键盘自动关闭
    [[SDKKey shareSDKKey] IQKeyboard];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置主色调
    [self configure];
    
    LaunchViewController *launchVC = [[LaunchViewController alloc]initWithNibName:@"LaunchViewController" bundle:nil];
    [launchVC showLaunchImage];
    self.window.rootViewController = launchVC;
    
//    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//    LoginViewController *loginVC = [SB instantiateViewControllerWithIdentifier:@"LoginViewController"];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
//    self.window.rootViewController = navi;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}
@end
