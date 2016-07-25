//
//  FeatureViewController.m
//  Guide
//
//  Created by 张海勇 on 16/7/25.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "FeatureViewController.h"
#import "FeatureParams.h"
#import "Main4Cell.h"
#import "MainProduceModel.h"
#import "ProduceDetailViewController.h"
@interface FeatureViewController ()


@property (nonatomic,strong)FeatureParams *params;
@property (nonatomic,strong)NSMutableArray *features;
@end

@implementation FeatureViewController
-(NSMutableArray *)features {
    
    if (_features == nil) {
        
        NSMutableArray *features = [NSMutableArray array];
        _features = features;
    }
    return _features;
}


-(FeatureParams *)params {
    
    if (_params == nil) {
        
        FeatureParams *params = [[FeatureParams alloc]init];
        params.rows = 20;
        params.feature = self.feature;
        _params = params;
    }
    return _params;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.params.page = 1;
        
        [self featureList];
        
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.params.page += 1;
        
        [self featureList];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}


- (void)featureList {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    FxLog(@"featureList = %@",self.params.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KHomePageProcudeList params:self.params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"featureList = %@",dataDic);
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *rows = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                
                //等于1，说明是刷新
                if (self.params.page == 1) {
                    
                    self.features = [MainProduceModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.tableView.mj_header endRefreshing];
                    
                }else {
                    
                    NSArray *array = [MainProduceModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.features addObjectsFromArray:array];
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
        
        [[HUDConfig shareHUD]Tips :error.localizedDescription delay:DELAY];
        [self.tableView.mj_footer endRefreshing];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.features.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 170;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
            
        Main4Cell *cell = [[[NSBundle mainBundle] loadNibNamed:@"Main4Cell" owner:self options:nil] lastObject];
        
        if (self.features.count > 0) {
            
            MainProduceModel *model = self.features[indexPath.row];
            cell.NameLabel.text     = model.name;
            
            if ([model.isPackagePrice integerValue] == 1) {
                
                cell.CoinsLabel.text    = model.marketPrice;
            }else {
                
                cell.CoinsLabel.text    = [NSString stringWithFormat:@"%@~%@",model.minPrice,model.maxPrice];
            }
            
            cell.timeLabel.text     = model.scheduleDesc;
            cell.termsLabel.text    = [NSString stringWithFormat:@"资源限制说明：%@",model.terms];
            cell.StockLabel.text    = [NSString stringWithFormat:@"库存 %@",model.stock];
            
            //是否收藏
            if ([model.favorite integerValue] != 0) {
                
                cell.collectBtn.selected = YES;
                
            }else {
                
                cell.collectBtn.selected = NO;
            }
            
            for (int i = 0; i<model.acceptableCoinTypes.count; i++) {
                
                UIImageView *coinImg = (UIImageView *)[cell.contentView viewWithTag:i+100];
                coinImg.hidden       = NO;
                coinImg.image        = [UIImage imageNamed:[Uitils toImageName:model.acceptableCoinTypes[i]]];
            }
            
            for (int i = 0; i<model.tags.count; i++) {
                
                UIButton *tagsButton = (UIButton *)[cell.contentView viewWithTag:i+200];
                tagsButton.hidden    = NO;
                [tagsButton setTitle:model.tags[i] forState:UIControlStateNormal];
            }
            
        }
        return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        MainProduceModel *model = self.features[indexPath.row];
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
        produceDetail.produceModel = model;
        [self.navigationController pushViewController:produceDetail animated:YES];
}



@end
