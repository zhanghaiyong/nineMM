//
//  PackageViewController.m
//  Guide
//
//  Created by 张海勇 on 16/8/3.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "PackageViewController.h"
#import "PackageParams.h"
#import "PackageModel.h"
#import "PackageMealCell.h"
#import "PackageMealBannerCell.h"
#import "PackageDetailViewController.h"
#import "PackageBannerModel.h"
#import "ZHYBannerView.h"
@interface PackageViewController ()<UITableViewDelegate,UITableViewDataSource,ZHYBannerViewDelegte>
{
    BOOL isRefresh;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *packageArray;
@property (nonatomic,strong)NSMutableArray *bannerArray;
@property (nonatomic,strong)PackageParams *params;
@end

@implementation PackageViewController

-(NSMutableArray *)bannerArray {
    
    if (_bannerArray == nil) {
        NSMutableArray *bannerArray = [NSMutableArray array];
        _bannerArray = bannerArray;
    }
    return _bannerArray;
}

-(NSMutableArray *)packageArray {

    if (_packageArray == nil) {
        NSMutableArray *packageArray = [NSMutableArray array];
        _packageArray = packageArray;
    }
    return _packageArray;
}

-(PackageParams *)params {

    if (_params == nil) {
        
        PackageParams *params = [[PackageParams alloc]init];
        params.rows = 20;
        _params = params;
    }
    return _params;
}

#pragma mark ZHYBannerViewDelegte
- (void)tapBannerImage:(NSInteger)imageTag {

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self loadBanners];
    
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.params.page = 1;
        isRefresh = YES;
        [self loadPackageData];
        
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.params.page += 1;
        isRefresh = NO;
        [self loadPackageData];
    }];
    
    [self loadPackageData];
}


- (void)loadBanners {

    [[HUDConfig shareHUD]alwaysShow];
    NSDictionary *dic = @{@"categoryName":@"套餐轮播",@"rows":@"100",@"page":@"1"};
    
    FxLog(@"loadBanners = %@",dic);
    
    [KSMNetworkRequest postRequest:KArticleList params:dic success:^(NSDictionary *dataDic) {
        
        if (!isRefresh) {
            
            [[HUDConfig shareHUD]dismiss];
        }
        FxLog(@"loadBanners = %@",dataDic);
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            if (isRefresh) {
                
                [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            }
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *rows = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
            
                self.bannerArray = [PackageBannerModel mj_objectArrayWithKeyValuesArray:rows];
               
                //一个section刷新
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];

}


- (void)loadPackageData {

    
    [[HUDConfig shareHUD]alwaysShow];
    
    FxLog(@"loadPackageData = %@",self.params.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KPackageList params:self.params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"loadPackageData = %@",dataDic);
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *rows = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                
                //等于1，说明是刷新
                if (self.params.page == 1) {
                    
                    self.packageArray = [PackageModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.tableView.mj_header endRefreshing];
                    
                }else {
                    
                    NSArray *array = [PackageModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.packageArray addObjectsFromArray:array];
                    
                }
                
                if (rows.count < self.params.rows) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                }else {
                    
                    [self.tableView.mj_footer endRefreshing];
                }
                
                [self.tableView reloadData];
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSError *error) {
        
        [self.tableView.mj_footer endRefreshing];
    }];

}

#pragma mark UITableViewDelegate&&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.packageArray.count+1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 220;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.section == 0) {
        
        PackageMealBannerCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PackageMealBannerCell" owner:self options:nil] lastObject];
        
        if (self.bannerArray.count > 0) {
            
            //滚动试图
            ZHYBannerView *bannerView = [cell.contentView viewWithTag:100];
            bannerView.delegate = self;
            bannerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
            NSMutableArray *topImages = [NSMutableArray array];
            for (PackageBannerModel *bannerModel in self.bannerArray) {
                
                [topImages addObject:bannerModel.thumbnail];
            }
            bannerView.imageArray = topImages;
        }
        return cell;
        
    }else {
    
    static NSString *identifier = @"cell";
    PackageMealCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PackageMealCell" owner:self options:nil] lastObject];
    }
    
    PackageModel *model = self.packageArray[indexPath.section-1];
    cell.nameLabel.text = model.name;
    cell.priceLabel.text = model.price;
    cell.stockLabel.text = [NSString stringWithFormat:@"库存 %@",model.stock];
    
    for (int i = 0; i<model.acceptableCoinTypes.count; i++) {
        
        UIImageView *coinImg = (UIImageView *)[cell.contentView viewWithTag:i+100];
        coinImg.hidden = NO;
        coinImg.image  = [UIImage imageNamed:[Uitils toImageName:model.acceptableCoinTypes[i]]];
    }
        
    return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section != 0) {
     
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        PackageModel *model = self.packageArray[indexPath.section-1];
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        PackageDetailViewController *packageDetailVC = [mainSB instantiateViewControllerWithIdentifier:@"PackageDetailViewController"];
        packageDetailVC.packageModel = model;
        [self.navigationController pushViewController:packageDetailVC animated:YES];
    }
}

@end
