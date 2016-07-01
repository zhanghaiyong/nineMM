
#import "LaunchViewController.h"
#import "MainStaticModel.h"
#import "PageInfo.h"
#import "TabBarViewController.h"
#import "MainViewController.h"

@interface LaunchViewController ()
{
    UIActivityIndicatorView *IndicatorView;
    MainStaticModel *mainStaticModel;
}
@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//    IndicatorView             = [[UIActivityIndicatorView alloc ]initWithFrame:CGRectMake(250.0,20.0,30.0,30.0)];
//    IndicatorView.center      = self.view.center;
//    IndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//    [self.view addSubview:IndicatorView];
//    [IndicatorView startAnimating];//启动

    [self getSessionID];
}

//判断是否存储了图片
- (void)showLaunchImage {
    
    NSString *rootPath     = [HYSandbox docPath];
    NSString *filePath     = [NSString stringWithFormat:@"%@/%@",rootPath,LaunchCaches];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
    _launchImage.image     = [UIImage imageWithContentsOfFile:filePath];
    }
}

- (void)getSessionID {
    
    [KSMNetworkRequest postRequest:KGetSessionID params:nil success:^(NSDictionary *dataDic) {

        FxLog(@"sessionID = %@",dataDic);
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            [Uitils setUserDefaultsObject:[dataDic objectForKey:@"sessionId"] ForKey:TOKEN];
        }

        [self requestHomeData];

    } failure:^(NSError *error) {

    }];
}

//请求主页的数据
- (void)requestHomeData {

    [KSMNetworkRequest postRequest:KHomePageStatic params:nil success:^(NSDictionary *dataDic) {
        
        FxLog(@"dataDic = %@",dataDic);
        [IndicatorView stopAnimating];
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                mainStaticModel = [MainStaticModel mj_objectWithKeyValues:[dataDic objectForKey:@"retObj"]];
            }
            //请求成功后，进入主页
            [self hideLanch];
        }
        
    } failure:^(NSError *error) {
        
        [IndicatorView stopAnimating ];
    }];
}

- (void)hideLanch {
    
    if (self.view.superview != [AppDelegate appDeg].window) {
        [self.view removeFromSuperview];
    }
    else {
        
        [self toTabBar];
    }
}

//- (void)setLaucnImage:(NSData *)data {
//    
//    UIImage *image = [UIImage imageWithData:data];
//    NSString *rootPath = [HYSandbox docPath];
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@.jpg",rootPath,LaunchCaches];
//    
//    if (image!=nil) {
//        _launchImage.image = image;
//        [data writeToFile:filePath atomically:YES];
//    }
//}

- (void)toTabBar {

    NSMutableArray *controllers = [NSMutableArray array];
    NSArray *pages = [self pages];
    UIViewController *pageController = nil;
    UINavigationController *navPage = nil;
    
    UIStoryboard *loginStoryB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    TabBarViewController *rootTabBar = [loginStoryB instantiateViewControllerWithIdentifier:@"TabBarViewController"];
    UIView *bgView = [[UIView alloc] initWithFrame:rootTabBar.tabBar.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    [rootTabBar.tabBar insertSubview:bgView atIndex:0];
    rootTabBar.tabBar.opaque = YES;
    
    for (PageInfo *pageInfo in pages) {
        
        pageController = [loginStoryB instantiateViewControllerWithIdentifier:pageInfo.ClassName];
        navPage = [[UINavigationController alloc] initWithRootViewController:pageController];
        pageController.tabBarItem.image = [UIImage imageNamed:pageInfo.Image];
        pageController.tabBarItem.title = pageInfo.Title;
        pageController.tabBarItem.selectedImage = [UIImage imageNamed:pageInfo.SelectImage];
        [controllers addObject:navPage];
    }
    
    rootTabBar.viewControllers = controllers;
    UINavigationController *navi = rootTabBar.viewControllers[0];
    MainViewController *main = (MainViewController *)navi.topViewController;
    main.mainStaticModel = mainStaticModel;
    
    [AppDelegate appDeg].window.rootViewController = rootTabBar;
}

- (NSArray *)pages {
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
