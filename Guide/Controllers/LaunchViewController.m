
#import "LaunchViewController.h"
#import "MainStaticModel.h"
#import "PageInfo.h"
#import "TabBarViewController.h"
#import "MainViewController.h"

@interface LaunchViewController ()
{
    MainStaticModel *mainStaticModel;
    NSDictionary *sessionDic;
}
@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [SVProgressHUD showWithStatus:@"数据更新中，请稍候..."];

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

#pragma mark 获取区域树
- (void)getAreasTreeJson:(NSString *)sessionId {
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    FxLog(@"app_Version = %@",app_Version);
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:sessionId forKey:@"sessionId"];
    
    NSString *rootPath = [HYSandbox docPath];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",rootPath,ARESTREE];
    NSArray *areaTree  = [NSArray arrayWithContentsOfFile:filePath];
    
    if (![[Uitils getUserDefaultsForKey:APPVERSION] isEqualToString:app_Version] || areaTree.count == 0) {
        
        if ([Uitils getUserDefaultsForKey:APPVERSION]) {
            
            [params setObject:[Uitils getUserDefaultsForKey:APPVERSION] forKey:@"areaTreeVer"];
            
        }else {
        
            [params setObject:@"0" forKey:@"areaTreeVer"];
        }
        [Uitils setUserDefaultsObject:app_Version ForKey:APPVERSION];
        
        
        [KSMNetworkRequest postRequest:KGetAreasTreeJson params:nil success:^(NSDictionary *dataDic) {
            
            FxLog(@"获取区域树 = %@",dataDic);

            if ([[[dataDic objectForKey:@"retObj"] objectForKey:@"areaTree"] writeToFile:filePath atomically:YES]) {
    
                FxLog(@"区域树数据写入成功");
                
                [self requestHomeData:[sessionDic objectForKey:@"sessionId"]];
                
            }else {
    
                FxLog(@"区域树数据写入失败");
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"资源下载失败，请检查网络并重新下载" preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self getAreasTreeJson:[sessionDic objectForKey:@"sessionId"]];
                    
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        } failure:^(NSError *error) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"资源下载失败，请检查网络并重新下载" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [self getAreasTreeJson:[sessionDic objectForKey:@"sessionId"]];
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
        }];
    }else {
    
        [self requestHomeData:[sessionDic objectForKey:@"sessionId"]];
    }
}


#pragma mark 获取资源分类
- (void)getProductCategoryTree:(NSString *)sessionId {

    [KSMNetworkRequest postRequest:KGetProductCategoryTree params:@{@"sessionId":sessionId} success:^(NSDictionary *dataDic) {
        
        FxLog(@"资源分类 = %@",dataDic);
        NSString *rootPath = [HYSandbox docPath];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",rootPath,CategoryTree];
        if ([[[dataDic objectForKey:@"retObj"] objectForKey:@"tree"] writeToFile:filePath atomically:YES]) {
            
            FxLog(@"资源分类数据写入成功");
        }else {
        
            FxLog(@"资源分类数据写入失败");
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 获取sessionId
- (void)getSessionID {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];;
    if ([Uitils getUserDefaultsForKey:TOKEN]) {
        
        [params setObject:[Uitils getUserDefaultsForKey:TOKEN] forKey:@"sessionId"];
    }
    
    [KSMNetworkRequest postRequest:KGetSessionID params:params success:^(NSDictionary *dataDic) {
        
        FxLog(@"sessionID = %@",dataDic);
        sessionDic = [[NSDictionary alloc]initWithDictionary:dataDic];
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [self getProductCategoryTree:[dataDic objectForKey:@"sessionId"]];
            
            [self getAreasTreeJson:[dataDic objectForKey:@"sessionId"]];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  请求主页的数据
 */
- (void)requestHomeData:(NSString *)sessionId {

    [KSMNetworkRequest postRequest:KHomePageStatic params:@{@"sessionId":sessionId} success:^(NSDictionary *dataDic) {
        
        FxLog(@"dataDic = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                mainStaticModel = [MainStaticModel mj_objectWithKeyValues:[dataDic objectForKey:@"retObj"]];
            }
            //请求成功后，进入主页
            [self hideLanch];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 进入主界面
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
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
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
