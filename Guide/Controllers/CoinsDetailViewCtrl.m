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
        _params = params;
    }
    return _params;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    coinsDetailMsgArr = [NSMutableArray array];
    self.title = @"酒币明细";
    
    [self getCoinsDetail];
    
}

- (void)getCoinsDetail {

    [[HUDConfig shareHUD]alwaysShow];
    
    self.params.page += 1;
    
    [KSMNetworkRequest postRequest:KCoinsDetail params:self.params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"getCoinsDetail = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {

                coinsDetailMsgArr = [CoinsDetailModel mj_objectArrayWithKeyValuesArray:[[dataDic objectForKey:@"retObj"] objectForKey:@"rows"]];
                
                [self.tableView reloadData];
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
        [[HUDConfig shareHUD]ErrorHUD:error.localizedDescription delay:DELAY];
    }];
}


#pragma mark UITableViewDelegate&&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return coinsDetailMsgArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SourceListHead *sourceListHead = [[[NSBundle mainBundle]loadNibNamed:@"SourceListHead" owner:self options:nil]lastObject];
    sourceListHead.backgroundColor = backgroudColor;
    sourceListHead.frame = CGRectMake(0, 0, self.tableView.width, 30);
    sourceListHead.titleLabel.text = @"我的酒币";
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
        cell.logIdLabel.text = [NSString stringWithFormat:@"操作流水 %@",model.logId];
        cell.coinCountLabel.text = [NSString stringWithFormat:@"+%@%@",model.amount,model.coinTypeName];
    return cell;
}



@end
