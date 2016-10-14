//
//  CoinsDetailViewCtrl.m
//  Guide
//
//  Created by 张海勇 on 16/7/5.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "CoinsDetailViewCtrl.h"
#import "CoinsDetailCell.h"
#import "SourceListHead.h"
#import "CoinsDetailParams.h"
#import "CoinsDetailModel.h"
@interface CoinsDetailViewCtrl ()<UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray *coinsDetailMsgArr;
    BOOL isRefresh;
}
@property (nonatomic,strong)CoinsDetailParams *params;
@end

@implementation CoinsDetailViewCtrl

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}

-(CoinsDetailParams *)params {

    if (_params == nil) {
        CoinsDetailParams *params = [[CoinsDetailParams alloc]init];
        params.rows = 20;
        params.page = 0;
        params.coinTypeCode = self.coinTypeCode;
        _params = params;
    }
    return _params;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    coinsDetailMsgArr = [NSMutableArray array];
    self.title = @"酒币明细";
    
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.params.page = 1;
        isRefresh = YES;
        [self getCoinsDetail];
        
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.params.page += 1;
        isRefresh = NO;
        [self getCoinsDetail];
    }];
    
    [self getCoinsDetail];
    
}

- (void)getCoinsDetail {

    [[HUDConfig shareHUD]alwaysShow];
    FxLog(@"params = %@",self.params.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KCoinsDetail params:self.params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"getCoinsDetail = %@",dataDic);
        
        if (!isRefresh) {
            
            [[HUDConfig shareHUD]dismiss];
        }
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            if (isRefresh) {
                
                [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            }
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *sourceData = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                
                if (sourceData.count == 0) {
                    
                    [[HUDConfig shareHUD]SuccessHUD:@"暂无酒币明细" delay:DELAY];
                }
                
                //等于1，说明是刷新
                if (self.params.page == 1) {
                    
                    coinsDetailMsgArr = [CoinsDetailModel mj_objectArrayWithKeyValuesArray:sourceData];
                    [self.tableView.mj_header endRefreshing];
                    
                }else {
                    
                    NSArray *array = [CoinsDetailModel mj_objectArrayWithKeyValuesArray:sourceData];
                    [coinsDetailMsgArr addObjectsFromArray:array];
                    
                    if (array.count < self.params.rows) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }else {
                        
                        [self.tableView.mj_footer endRefreshing];
                    }
                }
                
                [self.tableView reloadData];
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark UITableViewDelegate&&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return coinsDetailMsgArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SourceListHead *sourceListHead = [[[NSBundle mainBundle]loadNibNamed:@"SourceListHead" owner:self options:nil]lastObject];
    sourceListHead.backgroundColor = backgroudColor;
    sourceListHead.frame = CGRectMake(0, 0, self.tableView.width, 40);
    
//    sourceListHead.countLabel.text = [NSString stringWithFormat:@"共%ld件",coinsDetailMsgArr.count];
    
    if (self.coinTypeCode.length == 0) {
        sourceListHead.titleLabel.text = @"我的酒币(全部)";
    }else {
    
        if ([self.coinTypeCode isEqualToString:@"golden"]) {
            
            sourceListHead.titleLabel.text = @"我的酒币(金币)";
            
        }else if ([self.coinTypeCode isEqualToString:@"black"]) {
            
            sourceListHead.titleLabel.text = @"我的酒币(黑币)";
            
        }else if ([self.coinTypeCode isEqualToString:@"red"]) {
            
            sourceListHead.titleLabel.text = @"我的酒币(红币)";
            
        }else if ([self.coinTypeCode isEqualToString:@"blue"]) {
            
            sourceListHead.titleLabel.text = @"我的酒币(蓝币)";
            
        }else {
        
            sourceListHead.titleLabel.text = @"我的酒币(白币)";
        }
    }
    
    return sourceListHead;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    CoinsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CoinsDetailCell" owner:self options:nil] lastObject];
    }
    
        CoinsDetailModel *model = coinsDetailMsgArr[indexPath.row];
        cell.dataLabel.text = model.createDate;
        cell.logIdLabel.text = model.summary;
        cell.coinCountLabel.textColor = [Uitils colorWithHex:(unsigned long)model.textColor];
    if ([model.amount integerValue] > 0) {
        
        cell.coinCountLabel.text = [NSString stringWithFormat:@"+%@%@",model.amount,model.coinTypeName];
        
    }else {
        
        cell.coinCountLabel.text = [NSString stringWithFormat:@"%@%@",model.amount,model.coinTypeName];
    }
    return cell;
}



@end
