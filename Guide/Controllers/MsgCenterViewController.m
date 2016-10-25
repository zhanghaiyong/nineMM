//
//  MsgCenterViewController.m
//  Guide
//
//  Created by 张海勇 on 16/7/8.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MsgCenterViewController.h"
#import "MsgCenterModel.h"
#import "MsgCenterCell.h"
#import "MsgListViewController.h"
@interface MsgCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *msgArray;
@end

@implementation MsgCenterViewController

-(NSMutableArray *)msgArray {

    if (_msgArray == nil) {
        NSMutableArray *msgArray = [NSMutableArray array];
        _msgArray = msgArray;
    }
    return _msgArray;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self loadMsg];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"消息中心";
    self.tableView.tableFooterView = [[UIView alloc]init];
}


- (void)loadMsg {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    BaseParams *params = [[BaseParams alloc]init];
    
    [KSMNetworkRequest postRequest:KNotificationCenter params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"NotificationCenter = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                self.msgArray = [MsgCenterModel mj_objectArrayWithKeyValuesArray:[[dataDic objectForKey:@"retObj"] objectForKey:@"categories"]];
                [self.tableView reloadData];
                
            }
            
        }else if ([[dataDic objectForKey:@"retCode"]integerValue] == -2){
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            LoginViewController *loginVC = [SB instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self presentViewController:loginVC animated:YES completion:^{
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark UITablrViewDelegate && UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.msgArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    
    MsgCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MsgCenterCell" owner:self options:nil] lastObject];
    }
    MsgCenterModel *model = self.msgArray[indexPath.row];
    [Uitils cacheImagwWithSize:CGSizeMake(cell.logo.width*2, cell.logo.height*2) imageID:model.icon imageV:cell.logo placeholder:nil];
    
    if ([model.unreadCount integerValue] > 0) {
        
        cell.unreadFlag.hidden = NO;
        cell.unreadFlag.text = [NSString stringWithFormat:@"%@",model.unreadCount];
    }else {
    
        cell.unreadFlag.hidden = YES;
    }
    
    cell.title.text = model.title;
    cell.firstUnread.text = model.firstUnread;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MsgCenterModel *model = self.msgArray[indexPath.row];
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    MsgListViewController *msgList = [mainSB instantiateViewControllerWithIdentifier:@"MsgListViewController"];
    msgList.categoryCode = model.code;
    msgList.title = model.title;
    [self.navigationController pushViewController:msgList animated:YES];
}


@end
