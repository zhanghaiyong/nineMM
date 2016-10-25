//
//  MainViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/26.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MainViewController.h"
#import "ButtonView.h"
#import "ZHYBannerView.h"
#import "Main1Cell.h"
#import "Main2Cell.h"
#import "Main3Cell.h"
#import "Main4Cell.h"
#import "SearchBar.h"
#import "TopBannersModel.h"
#import "ShortcutsModel.h"
#import "NewsModel.h"
#import "GroupButtonsModel.h"
#import "SecondBannerModel.h"
#import "MainProduceListParams.h"
#import "MainProduceModel.h"
#import "ProduceDetailViewController.h"
#import "CoinsRechargeViewController.h"
#import "URLViewController.h"
#import "FeatureViewController.h"
#import "GoodsViewController.h"
#import "PackageViewController.h"

#import "VersionModel.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,ButtonViewDeleage,ZHYBannerViewDelegte,Main2CellDelegate,Main3CellDelegate,UITextFieldDelegate>
{

    SearchBar *searchBar;
    BOOL isRefresh;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)MainProduceListParams *produceListParams;
@property (nonatomic,strong)NSMutableArray *produces;
@end

@implementation MainViewController
-(NSMutableArray *)produces {

    if (_produces == nil) {
        
        NSMutableArray *produces = [NSMutableArray array];
        _produces = produces;
    }
    return _produces;
}

-(MainProduceListParams *)produceListParams {

    if (_produceListParams == nil) {
        
        MainProduceListParams *produceListParams = [[MainProduceListParams alloc]init];
        produceListParams.rows = 20;
        _produceListParams = produceListParams;
    }
    return _produceListParams;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginLinkAction:) name:@"LoginLinkAction" object:nil];
}

- (void)LoginLinkAction:(NSNotification *)notifation {

    FxLog(@"FZzsfg = %@",notifation.userInfo);
    NSArray *array = [[notifation.userInfo objectForKey:@"linkAction"] componentsSeparatedByString:@":"];
    //酒币充值
    if ([array containsObject:openCoinRechargePage]) {
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        CoinsRechargeViewController *CoinsRechargeVC = [mainSB instantiateViewControllerWithIdentifier:@"CoinsRechargeViewController"];
        [self.navigationController pushViewController:CoinsRechargeVC animated:YES];
        
        
    }else if ([array containsObject:openUri]) { //内网
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.urlString = [NSString stringWithFormat:@"%@%@?sessionId=%@",BaseURLString,array.lastObject,[Uitils getUserDefaultsForKey:TOKEN]];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }else if ([array containsObject:queryGoodsFeature]) { //资源 通过feature来获取
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        FeatureViewController *FeatureVC = [mainSB instantiateViewControllerWithIdentifier:@"FeatureViewController"];
        FeatureVC.feature = array.lastObject;
        [self.navigationController pushViewController:FeatureVC animated:YES];
        
    }else if ([array containsObject:showGoodsListByTag]) { //指定场景商品列表
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        GoodsViewController *GoodsVC = [mainSB instantiateViewControllerWithIdentifier:@"GoodsViewController"];
        GoodsVC.tag = array.lastObject;
        [self.navigationController pushViewController:GoodsVC animated:YES];
        
    }else if ([array containsObject:queryPackagedGoods]) { //打包套餐
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        PackageViewController *packageVC = [mainSB instantiateViewControllerWithIdentifier:@"PackageViewController"];
        [self.navigationController pushViewController:packageVC animated:YES];
        
    }else if ([array containsObject:openUrl]) { //外网
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.urlString = [NSString stringWithFormat:@"%@:%@",array[2],array[3]];
        [self.navigationController pushViewController:URLVC animated:YES];
    }
    
    FxLog(@"%@",array);
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    //隐藏
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //检查版本更新
    [self testVersion];
    
    searchBar = [[[NSBundle mainBundle] loadNibNamed:@"SearchBar" owner:self options:nil] lastObject];
    searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    searchBar.searchTF.backgroundColor = [UIColor whiteColor];
    searchBar.searchTF.delegate = self;
    searchBar.backgroundColor = [UIColor clearColor];
    
    [searchBar connectTwoBlock:^{
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        MsgCenterViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"MsgCenterViewController"];
        [self.navigationController pushViewController:produceDetail animated:YES];
        
    }];
    
    searchBar.searchTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-fangdajing"]];
    //将左边的图片向右移动一定距离
    searchIcon.width +=10;
    searchIcon.contentMode = UIViewContentModeCenter;
    searchBar.searchTF.leftView = searchIcon;
    [self.view addSubview:searchBar];
    
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.produceListParams.page = 1;
        
        isRefresh = YES;
        [self loadProduceList];
        
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.produceListParams.page += 1;
        isRefresh = NO;
        [self loadProduceList];
    }];
    
    [self loadProduceList];
    
}

- (void)testVersion {
    
    [KSMNetworkRequest postRequest:KVersion params:nil success:^(NSDictionary *dataDic) {
        
        FxLog(@"c当时的 =%@",dataDic);
        
        VersionModel *model = [VersionModel mj_objectWithKeyValues:[[dataDic objectForKey:@"ios"] objectForKey:@"promot"]];
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        if ([app_Version integerValue] != [model.version integerValue]) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"有新版本，马上升级？" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
                
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            }]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSError *error) {
        
        FxLog(@"version fail = %@",error);
        
    }];
}

- (void)loadProduceList {
    
    [[HUDConfig shareHUD]alwaysShow];
    
     FxLog(@"produceListParams = %@",self.produceListParams.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KHomePageProcudeList params:self.produceListParams.mj_keyValues success:^(NSDictionary *dataDic) {

        if (!isRefresh) {

            [[HUDConfig shareHUD]dismiss];
        }
        
        FxLog(@"loadProduceList = %@",dataDic);
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            if (isRefresh ) {
             
                [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            }
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *rows = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                
                //等于1，说明是刷新
                if (self.produceListParams.page == 1) {
                    
                    self.produces = [MainProduceModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.tableView.mj_header endRefreshing];
                    
                }else {
                
                    NSArray *array = [MainProduceModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.produces addObjectsFromArray:array];
                    
                }
                
                if (rows.count < self.produceListParams.rows) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                }else {
                    
                    [self.tableView.mj_footer endRefreshing];
                }
                
                NSIndexSet *nd=[[NSIndexSet alloc]initWithIndex:3];//刷新第3个section
                [self.tableView reloadSections:nd withRowAnimation:UITableViewRowAnimationTop];
            }
            
        }else {
        
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSError *error) {
        
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [searchBar.searchTF resignFirstResponder];
    
    if (textField.text.length != 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"search" object:self userInfo:@{@"keyword":textField.text}];
        textField.text = @"";
        self.tabBarController.selectedIndex = 1;
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return YES;
}


#pragma mark UITableViewDelegate&&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return self.produces.count;
            break;
            
        default:
            break;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 10;
            break;
        case 1:
            return 10;
            break;
        case 2:
            return 0.1;
            break;
        case 3:
            return 0.1;
            break;
        default:
            break;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
            return 380;
            break;
        case 1:
            return 150;
            break;
        case 2:
            return 120;
            break;
        case 3:{
            
            MainProduceModel *model = self.produces[indexPath.row];
            CGFloat cellH = 105.0;
            
            if (model.terms.length > 0) {
                
                cellH += 30.0;
            }
            
            if (model.tags.count > 0) {
                cellH += 25.0;
            }
            return cellH;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0: {
            
            Main1Cell *cell = [[[NSBundle mainBundle] loadNibNamed:@"Main1Cell" owner:self options:nil] lastObject];
            
            if (self.mainStaticModel.topBanners.count > 0) {
                
                //滚动试图
                ZHYBannerView *bannerView = [cell.contentView viewWithTag:100];
                bannerView.delegate = self;
                bannerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
                NSMutableArray *topImages = [NSMutableArray array];
                for (TopBannersModel *bannerModel in self.mainStaticModel.topBanners) {
                    
                    [topImages addObject:bannerModel.imageId];
                }
                bannerView.imageArray = topImages;
            }
            
            //按钮
            for (int i = 0; i<self.mainStaticModel.shortcuts.count; i++) {
                
                ButtonView *buttonView = [cell.contentView viewWithTag:i+101];
                buttonView.size = CGSizeMake(SCREEN_WIDTH/5, 60);
                ShortcutsModel *buttonModel = self.mainStaticModel.shortcuts[i];
                buttonView.isNetImage = YES;
                buttonView.delegate = self;
                buttonView.labelTitle = buttonModel.title;
                buttonView.imageName = buttonModel.imageId;
            }
            
            //新资源
            if (self.mainStaticModel.news.count > 0) {
               
                NewsModel *newsModel = self.mainStaticModel.news[0];
                UILabel *title = [cell.contentView viewWithTag:112];
                title.text = newsModel.title;
                
                UILabel *subTitle = [cell.contentView viewWithTag:113];
                subTitle.text = newsModel.subtitle;
                
                [cell tapNewSourceAction:^{
                    
                    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
                    URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
                    URLVC.title = newsModel.title;
                    URLVC.urlString = [NSString stringWithFormat:@"%@/article/mobile/%@.page",BaseURLString,newsModel.id];
                    [self.navigationController pushViewController:URLVC animated:YES];
                }];
            }

            return cell;
        }
            
            break;
        case 1:{
            
            Main2Cell *cell = [[[NSBundle mainBundle] loadNibNamed:@"Main2Cell" owner:self options:nil] lastObject];
            cell.delegate = self;
            cell.userInteractionEnabled = YES;
            for (int i = 0; i<self.mainStaticModel.groupButtons.count; i++) {
                UIImageView *imageV = [cell.contentView viewWithTag:i+200];
                
                NSLog(@"zdvz = %@",NSStringFromCGSize(imageV.size));
                
                CGSize imageSize;
                if (i == 0) {
                    imageSize = CGSizeMake((SCREEN_WIDTH+20)/2.0, 150);
                }else {
                
                    imageSize = CGSizeMake((SCREEN_WIDTH+20)/2.0, 150/2.0);
                }
                
                GroupButtonsModel *groupButton = self.mainStaticModel.groupButtons[i];
                [Uitils cacheImagwWithSize:CGSizeMake(imageSize.width*2, imageSize.height*2) imageID:groupButton.imageId imageV:imageV placeholder:@""];
            }
            
            return cell;
        }
            
            break;
        case 2:{
            
            Main3Cell *cell = [[[NSBundle mainBundle] loadNibNamed:@"Main3Cell" owner:self options:nil] lastObject];
            cell.delegate = self;
            for (int i = 0; i<self.mainStaticModel.secondBanner.count; i++) {
                UIImageView *imageV = [cell.contentView viewWithTag:i+100];
                SecondBannerModel *groupButton = self.mainStaticModel.secondBanner[i];
                [Uitils cacheImagwWithSize:CGSizeMake(imageV.size.width*2, imageV.size.height*2) imageID:groupButton.imageId imageV:imageV placeholder:@""];
            }
            
            return cell;
        }
            
            break;
        case 3:{
            
            Main4Cell *cell = [[[NSBundle mainBundle] loadNibNamed:@"Main4Cell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (self.produces.count > 0) {
             
                MainProduceModel *model = self.produces[indexPath.row];
                cell.NameLabel.text     = model.name;
                
                if ([model.isPackagePrice integerValue] == 1) {
                    
                    if (model.price.length == 0) {
                        
                        cell.CoinsLabel.text    = [NSString stringWithFormat:@"%@~%@",model.minPrice,model.maxPrice];
                        
                    }else {
                    
                        cell.CoinsLabel.text    = model.price;
                    }
                }else {
                
                    cell.CoinsLabel.text    = [NSString stringWithFormat:@"%@~%@",model.minPrice,model.maxPrice];
                }
                
                cell.timeLabel.text     = model.scheduleDesc;
                cell.StockLabel.text    = [NSString stringWithFormat:@"库存 %@",model.stock];
                if (model.terms.length > 0) {
                    
                    cell.termsHeight.constant = 30;
                    cell.termsLabel.text    = model.terms;
                    
                }else {
                    
                    cell.termsHeight.constant = 0;
                }
                
                //是否收藏
                if ([model.favorite integerValue] != 0) {
                    
                    cell.collectBtn.selected = YES;
                    
                }else {
                    
                    cell.collectBtn.selected = NO;
                }
                
                for (int i = 0; i<model.acceptableCoinTypes.count; i++) {
                    
                    UIImageView *coinImg = (UIImageView *)[cell.contentView viewWithTag:i+100];
                    coinImg.hidden = NO;
                    coinImg.image  = [UIImage imageNamed:[Uitils toImageName:model.acceptableCoinTypes[i]]];
                }
                
                
                    for (int i = 0; i< model.tags.count; i++) {
                        
                        if (((NSString *)model.tags[i]).length > 0) {
                            UIButton *tagsButton = (UIButton *)[cell.contentView viewWithTag:i+200];
                            tagsButton.hidden    = NO;
                            [tagsButton setTitle:[NSString stringWithFormat:@" %@ ",model.tags[i]] forState:UIControlStateNormal];
                        }
                    }
            }
            return cell;
        }
            
            break;
            
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 3) {
        
        self.tabBarController.tabBar.hidden = YES;
        
        MainProduceModel *model = self.produces[indexPath.row];
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
        produceDetail.produceId = model.id;
        [self.navigationController pushViewController:produceDetail animated:YES];
    }
}

-  (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offSet = scrollView.contentOffset.y;
    
    CGFloat alpha = (offSet - 64)/64;
    searchBar.backgroundColor = RGBA(231, 231, 231, alpha);
    searchBar.bottomLine.alpha = alpha;
}


#pragma mark ButtonViewDelegate
- (void)buttonViewTap:(NSInteger)aFlag {

    ShortcutsModel *model = self.mainStaticModel.shortcuts[aFlag-101];
    NSArray *array = [model.linkAction componentsSeparatedByString:@":"];
    
    //酒币充值
    if ([array containsObject:openCoinRechargePage]) {
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        CoinsRechargeViewController *CoinsRechargeVC = [mainSB instantiateViewControllerWithIdentifier:@"CoinsRechargeViewController"];
        [self.navigationController pushViewController:CoinsRechargeVC animated:YES];
        
        
    }else if ([array containsObject:openUri]) { //内网
      
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@%@?sessionId=%@",BaseURLString,array.lastObject,[Uitils getUserDefaultsForKey:TOKEN]];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }else if ([array containsObject:queryGoodsFeature]) { //资源 通过feature来获取
    
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        FeatureViewController *FeatureVC = [mainSB instantiateViewControllerWithIdentifier:@"FeatureViewController"];
        FeatureVC.feature = array.lastObject;
        FeatureVC.title = model.title;
        [self.navigationController pushViewController:FeatureVC animated:YES];
        
    }else if ([array containsObject:showGoodsListByTag]) { //指定场景商品列表
    
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        GoodsViewController *GoodsVC = [mainSB instantiateViewControllerWithIdentifier:@"GoodsViewController"];
        GoodsVC.tag = array.lastObject;
        GoodsVC.title = model.title;
        [self.navigationController pushViewController:GoodsVC animated:YES];
        
    }else if ([array containsObject:queryPackagedGoods]) { //打包套餐
    
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        PackageViewController *packageVC = [mainSB instantiateViewControllerWithIdentifier:@"PackageViewController"];
        packageVC.title = model.title;
        [self.navigationController pushViewController:packageVC animated:YES];
        
    }else if ([array containsObject:openUrl]) { //外网
    
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@:%@",array[2],array[3]];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }else if ([array containsObject:showGoodsDetail]) {
        
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
        produceDetail.produceId = array.lastObject;
        [self.navigationController pushViewController:produceDetail animated:YES];
        
    }else if ([array containsObject:showArticleListByCategory]) { //打开指定文章列表页
        
        
    }else if ([array containsObject:showArticleContent]) { //打开指定文章内容页
        
        
    }else if (model.linkAction.length == 0) {
    
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@/%@.page",KArticleHtml,model.imageId];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }
    FxLog(@"%@",array);
}


#pragma  mark ZHYBannerViewDelegte
- (void)tapBannerImage:(NSInteger)imageTag {

    TopBannersModel *model = self.mainStaticModel.topBanners[imageTag-1000];
    NSArray *array = [model.linkAction componentsSeparatedByString:@":"];
    
    //酒币充值
    if ([array containsObject:openCoinRechargePage]) {
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        CoinsRechargeViewController *CoinsRechargeVC = [mainSB instantiateViewControllerWithIdentifier:@"CoinsRechargeViewController"];
        [self.navigationController pushViewController:CoinsRechargeVC animated:YES];
        
        
    }else if ([array containsObject:openUri]) { //内网
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@%@?sessionId=%@",BaseURLString,array.lastObject,[Uitils getUserDefaultsForKey:TOKEN]];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }else if ([array containsObject:queryGoodsFeature]) { //资源 通过feature来获取
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        FeatureViewController *FeatureVC = [mainSB instantiateViewControllerWithIdentifier:@"FeatureViewController"];
        FeatureVC.feature = array.lastObject;
        FeatureVC.title = model.title;
        [self.navigationController pushViewController:FeatureVC animated:YES];
        
    }else if ([array containsObject:showGoodsListByTag]) { //指定场景商品列表
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        GoodsViewController *GoodsVC = [mainSB instantiateViewControllerWithIdentifier:@"GoodsViewController"];
        GoodsVC.tag = array.lastObject;
        GoodsVC.title = model.title;
        [self.navigationController pushViewController:GoodsVC animated:YES];
        
    }else if ([array containsObject:queryPackagedGoods]) { //打包套餐
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        PackageViewController *packageVC = [mainSB instantiateViewControllerWithIdentifier:@"PackageViewController"];
        packageVC.title = model.title;
        [self.navigationController pushViewController:packageVC animated:YES];
        
    }else if ([array containsObject:openUrl]) { //外网
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@:%@",array[2],array[3]];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }else if ([array containsObject:showGoodsDetail]) {
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
        produceDetail.produceId = array.lastObject;
        [self.navigationController pushViewController:produceDetail animated:YES];
        
    }else if ([array containsObject:showArticleListByCategory]) { //打开指定文章列表页
        
        
    }else if ([array containsObject:showArticleContent]) { //打开指定文章内容页
        
        
    }else if (model.linkAction.length == 0) {
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@/%@.page",KArticleHtml,model.imageId];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }else if ([array containsObject:None]) {
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@/article/mobile/%@.page",BaseURLString,model.id];
        [self.navigationController pushViewController:URLVC animated:YES];
    }
    FxLog(@"%@",array);
    
}

#pragma mark Main2CelleDelegate
- (void)main2CellTapImage:(NSInteger)imageTag {
    
    GroupButtonsModel *model = self.mainStaticModel.groupButtons[imageTag-200];
    NSArray *array = [model.linkAction componentsSeparatedByString:@":"];
    
    //酒币充值
    if ([array containsObject:openCoinRechargePage]) {
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        CoinsRechargeViewController *CoinsRechargeVC = [mainSB instantiateViewControllerWithIdentifier:@"CoinsRechargeViewController"];
        [self.navigationController pushViewController:CoinsRechargeVC animated:YES];
        
        
    }else if ([array containsObject:openUri]) { //内网
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@%@?sessionId=%@",BaseURLString,array.lastObject,[Uitils getUserDefaultsForKey:TOKEN]];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }else if ([array containsObject:queryGoodsFeature]) { //资源 通过feature来获取
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        FeatureViewController *FeatureVC = [mainSB instantiateViewControllerWithIdentifier:@"FeatureViewController"];
        FeatureVC.feature = array.lastObject;
        FeatureVC.title = model.title;
        [self.navigationController pushViewController:FeatureVC animated:YES];
        
    }else if ([array containsObject:showGoodsListByTag]) { //指定场景商品列表
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        GoodsViewController *GoodsVC = [mainSB instantiateViewControllerWithIdentifier:@"GoodsViewController"];
        GoodsVC.tag = array.lastObject;
        GoodsVC.title = model.title;
        [self.navigationController pushViewController:GoodsVC animated:YES];
        
    }else if ([array containsObject:queryPackagedGoods]) { //打包套餐
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        PackageViewController *packageVC = [mainSB instantiateViewControllerWithIdentifier:@"PackageViewController"];
        packageVC.title = model.title;
        [self.navigationController pushViewController:packageVC animated:YES];
        
    }else if ([array containsObject:openUrl]) { //外网
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@:%@",array[2],array[3]];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }else if ([array containsObject:showGoodsDetail]) {
        
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
        produceDetail.produceId = array.lastObject;
        [self.navigationController pushViewController:produceDetail animated:YES];
        
    }else if ([array containsObject:showArticleListByCategory]) { //打开指定文章列表页
        
        
    }else if ([array containsObject:showArticleContent]) { //打开指定文章内容页
        
        
    }else if (model.linkAction.length == 0) {
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@/%@.page",KArticleHtml,model.imageId];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }
    FxLog(@"%@",array);
}

#pragma mark Main3CellDelegate
- (void)main3CellTapImage:(NSInteger)imageTag {

    NewsModel *model = self.mainStaticModel.news[imageTag-100];
    NSArray *array = [model.linkAction componentsSeparatedByString:@":"];
    FxLog(@"%ld ",model.linkAction.length); //0
    
    //酒币充值
    if ([array containsObject:openCoinRechargePage]) {
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        CoinsRechargeViewController *CoinsRechargeVC = [mainSB instantiateViewControllerWithIdentifier:@"CoinsRechargeViewController"];
        [self.navigationController pushViewController:CoinsRechargeVC animated:YES];
        
        
    }else if ([array containsObject:openUri]) { //内网
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@%@?sessionId=%@",BaseURLString,array.lastObject,[Uitils getUserDefaultsForKey:TOKEN]];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }else if ([array containsObject:queryGoodsFeature]) { //资源 通过feature来获取
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        FeatureViewController *FeatureVC = [mainSB instantiateViewControllerWithIdentifier:@"FeatureViewController"];
        FeatureVC.feature = array.lastObject;
        FeatureVC.title = model.title;
        [self.navigationController pushViewController:FeatureVC animated:YES];
        
    }else if ([array containsObject:showGoodsListByTag]) { //指定场景商品列表
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        GoodsViewController *GoodsVC = [mainSB instantiateViewControllerWithIdentifier:@"GoodsViewController"];
        GoodsVC.tag = array.lastObject;
        GoodsVC.title = model.title;
        [self.navigationController pushViewController:GoodsVC animated:YES];
        
    }else if ([array containsObject:queryPackagedGoods]) { //打包套餐
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        PackageViewController *packageVC = [mainSB instantiateViewControllerWithIdentifier:@"PackageViewController"];
        packageVC.title = model.title;
        [self.navigationController pushViewController:packageVC animated:YES];
        
    }else if ([array containsObject:openUrl]) { //外网
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@:%@",array[2],array[3]];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }else if ([array containsObject:showGoodsDetail]) {
        
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
        produceDetail.produceId = array.lastObject;
        [self.navigationController pushViewController:produceDetail animated:YES];
        
    }else if ([array containsObject:showArticleListByCategory]) { //打开指定文章列表页
        
        
    }else if ([array containsObject:showArticleContent]) { //打开指定文章内容页
        
        
    }else if (model.linkAction.length == 0) {
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
        URLVC.title = model.title;
        URLVC.urlString = [NSString stringWithFormat:@"%@/%@.page",KArticleHtml,model.imageId];
        [self.navigationController pushViewController:URLVC animated:YES];
        
    }
    
    NSLog(@"%@",array);
}


@end
