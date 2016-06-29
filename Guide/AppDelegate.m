//
//  AppDelegate.m
//  Guide
//
//  Created by ksm on 16/4/7.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "AppDelegate.h"
//#import "JiPush.h"
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

- (void)getSessionID {
    
    [KSMNetworkRequest postRequest:KGetSessionID params:nil success:^(NSDictionary *dataDic) {
        
        NSLog(@"sessionID = %@",dataDic);
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
           [Uitils setUserDefaultsObject:[dataDic objectForKey:@"sessionId"] ForKey:TOKEN];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置键盘自动关闭
    [[SDKKey shareSDKKey] IQKeyboard];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self getSessionID];
    
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
