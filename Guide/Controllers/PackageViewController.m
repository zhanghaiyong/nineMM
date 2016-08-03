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
#import "PackageDetailViewController.h"
@interface PackageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *packageArray;
@property (nonatomic,strong)PackageParams *params;
@end

@implementation PackageViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.params.page = 1;
        
        [self loadPackageData];
        
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.params.page += 1;
        
        [self loadPackageData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.packageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    PackageMealCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PackageMealCell" owner:self options:nil] lastObject];
    }
    
    PackageModel *model = self.packageArray[indexPath.row];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PackageModel *model = self.packageArray[indexPath.row];
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    PackageDetailViewController *packageDetailVC = [mainSB instantiateViewControllerWithIdentifier:@"PackageDetailViewController"];
    packageDetailVC.packageModel = model;
    [self.navigationController pushViewController:packageDetailVC animated:YES];
}

@end
