#import "PageInfo.h"
#import "TabBarViewController.h"
#import "MainViewController.h"
@implementation PageInfo

+ (UITabBarController *)pageControllers {

    NSMutableArray *controllers = [NSMutableArray array];
    NSArray *pages = [self pages];
    UIViewController *pageController = nil;
    UINavigationController *navPage = nil;
    
    UIStoryboard *loginStoryB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    TabBarViewController *rootTabBar = [loginStoryB instantiateViewControllerWithIdentifier:@"TabBarViewController"];

    for (PageInfo *pageInfo in pages) {
        
        pageController = [loginStoryB instantiateViewControllerWithIdentifier:pageInfo.ClassName];
        navPage = [[UINavigationController alloc] initWithRootViewController:pageController];
        pageController.tabBarItem.image = [UIImage imageNamed:pageInfo.Image];
        pageController.tabBarItem.title = pageInfo.Title;
        pageController.tabBarItem.selectedImage = [UIImage imageNamed:pageInfo.SelectImage];
//        pageController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        [controllers addObject:navPage];
    }
    
//    rootTabBar.viewControllers = controllers;
//    UINavigationController *navi = rootTabBar.viewControllers[0];
//    MainViewController *main = (MainViewController *)navi.topViewController;
    return rootTabBar;

}

+ (NSArray *)pages
{
    NSString *configFile = [[NSBundle mainBundle] pathForResource:@"TabBar" ofType:@"plist"];
    NSArray *pageConfigs = [NSArray arrayWithContentsOfFile:configFile];
    NSMutableArray *pages = [[NSMutableArray alloc] init];
    
    if (pageConfigs.count <= 0) {
        BASE_ERROR_FUN(@"没有配置TabBarPages.plist");
    }
    
    for (NSDictionary *dict in pageConfigs) {
        PageInfo *info = [PageInfo mj_objectWithKeyValues:dict];
        [pages addObject:info];
    }
    
    return pages;
}

@end
