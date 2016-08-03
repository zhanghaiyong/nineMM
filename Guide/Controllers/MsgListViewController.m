//
//  MsgListViewController.m
//  Guide
//
//  Created by 张海勇 on 16/8/2.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MsgListViewController.h"
#import "MsgListParams.h"
#import "MsgListModel.h"
#import "MsgListCell.h"
#import "MsgDetailViewController.h"
@interface MsgListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)MsgListParams *params;
@property (nonatomic,strong)NSMutableArray *msgLists;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MsgListViewController

- (MsgListParams *)params {

    if (_params == nil) {
        MsgListParams *params = [[MsgListParams alloc]init];
        params.rows = 20;
        params.categoryCode = self.categoryCode;
        _params = params;
    }
    return _params;
}

-(NSMutableArray *)msgLists {

    if (_msgLists == nil) {
        NSMutableArray *msgLists = [NSMutableArray array];
        _msgLists = msgLists;
    }
    return _msgLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"消息列表";
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.params.page = 1;
        
        [self loadMsgList];
        
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.params.page += 1;
        
        [self loadMsgList];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadMsgList {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    FxLog(@"params = %@",self.params.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KNotificationList params:self.params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"KNotificationList = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *rows = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                
                //等于1，说明是刷新
                if (self.params.page == 1) {
                    
                    self.msgLists = [MsgListModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.tableView.mj_header endRefreshing];
                    
                }else {
                    
                    NSArray *array = [MsgListModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.msgLists addObjectsFromArray:array];
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
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark UITableView Delegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.msgLists.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 80;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ideitifier = @"UserSourceCell";
    MsgListCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MsgListCell" owner:nil options:nil] lastObject];
    }
    
    MsgListModel *model = self.msgLists[indexPath.row];
    cell.title.text = model.title;
    cell.summary.text = model.summary;
    cell.date.text = [model.createDate substringToIndex:10];
    
    //未读
    if ([model.readFlag integerValue] == 0) {
        
        cell.title.textColor = riceRedColor;
        
    }else {
    
        cell.title.textColor = HEX_RGB(0x999999);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MsgListModel *model = self.msgLists[indexPath.row];
    
    
    MsgListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.title.textColor = HEX_RGB(0x999999);
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    MsgDetailViewController *msgList = [mainSB instantiateViewControllerWithIdentifier:@"MsgDetailViewController"];
    msgList.ID = model.id;
    [self.navigationController pushViewController:msgList animated:YES];
}

@end
