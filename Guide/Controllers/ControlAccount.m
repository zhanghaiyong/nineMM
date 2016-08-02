#import "ControlAccount.h"
#import "MemberInfoModel.h"
@interface ControlAccount ()<UITableViewDataSource,UITableViewDelegate>
{

    MemberInfoModel *memberInfo;
}
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *userCode;
@property (weak, nonatomic) IBOutlet UILabel *userType;
@property (weak, nonatomic) IBOutlet UILabel *userLevel;
@end

@implementation ControlAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的帐户";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self getLoginMemberInfo];
}

- (void)getLoginMemberInfo {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    BaseParams *params = [[BaseParams alloc]init];
    
    [KSMNetworkRequest postRequest:KLoginMemberInfo params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"getLoginMemberInfo = %@",dataDic);
        
        [self.tableView.mj_header endRefreshing];
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                memberInfo = [MemberInfoModel mj_objectWithKeyValues:[dataDic objectForKey:@"retObj"]];
                
                self.name.text = memberInfo.name;
                self.ID.text = [NSString stringWithFormat:@"ID：%@",memberInfo.id];
                self.phone.text = memberInfo.phone;
//                self.email.text = memb
//                self.userCode
                self.userType.text = memberInfo.type;
//                self.userLevel.text
                
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)logoutAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否注销此账号?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [Uitils UserDefaultRemoveObjectForKey:TOKEN];
        [Uitils UserDefaultRemoveObjectForKey:PASSWORD];
        self.tabBarController.selectedIndex = 0;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clearPersionDara" object:self userInfo:nil];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark UITableViewDelegate&&UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 1) {
        return 0.1;
    }
    return 11;
}



@end
