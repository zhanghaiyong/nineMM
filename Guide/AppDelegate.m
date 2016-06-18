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
#import "PageInfo.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark configureAPIKey
- (void)configure {
    
    //设置主导航栏背景色
//    [[UINavigationBar appearance] setBarTintColor:MainColor];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           lever1Color,
                                                           NSForegroundColorAttributeName,
                                                           nil, NSShadowAttributeName,
                                                           [UIFont boldSystemFontOfSize:17],
                                                           NSFontAttributeName, nil]];
}



+ (AppDelegate *)appDeg {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

//- (void)showTabBarPage {
//    self.window.rootViewController = [PageInfo pageControllers];
//    [self.window makeKeyAndVisible];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置键盘自动关闭
    [[SDKKey shareSDKKey] IQKeyboard];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置主色调
    [self configure];
    
    LaunchViewController *launchVC = [[LaunchViewController alloc]initWithNibName:@"LaunchViewController" bundle:nil];
    [launchVC showLaunchImage];
    self.window.rootViewController = launchVC;
    
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
