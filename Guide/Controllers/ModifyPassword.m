
#import "ModifyPassword.h"
#import "UpdatePwdParams.h"
@interface ModifyPassword ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oldPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdNewTF;
@property (weak, nonatomic) IBOutlet UITextField *sureNewPwdTF;
@end

@implementation ModifyPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";

}

- (IBAction)showPwdAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    if (button.selected == NO) {
        
        button.selected               = YES;
        _pwdNewTF.secureTextEntry     = NO;
        _oldPwdTF.secureTextEntry     = NO;
        _sureNewPwdTF.secureTextEntry = NO;
    }else {
        
        button.selected = NO;
        _oldPwdTF.secureTextEntry     = YES;
        _pwdNewTF.secureTextEntry     = YES;
        _sureNewPwdTF.secureTextEntry = YES;
    }
}

- (IBAction)updatePwdAction:(id)sender {
    
    if (self.oldPwdTF.text.length == 0) {
        
        [[HUDConfig shareHUD]Tips:@"请输入原始密码" delay:DELAY];
        return;
    }
    
    if (self.pwdNewTF.text.length == 0) {
        
        [[HUDConfig shareHUD]Tips:@"请输新密码" delay:DELAY];
        return;
    }
    
    if (self.sureNewPwdTF.text.length == 0) {
        
        [[HUDConfig shareHUD]Tips:@"请确认密码" delay:DELAY];
        return;
    }
    
    if (![self.pwdNewTF.text isEqual:self.sureNewPwdTF.text]) {
        
        [[HUDConfig shareHUD]Tips:@"两次输入的密码不一致" delay:DELAY];
        return;
    }
    
    
     [[HUDConfig shareHUD]alwaysShow];
     
     UpdatePwdParams *params = [[UpdatePwdParams alloc]init];
    params.oldPassword = self.oldPwdTF.text;
    params.password = self.pwdNewTF.text;
     
     [KSMNetworkRequest postRequest:KUpdatePassword params:params.mj_keyValues success:^(NSDictionary *dataDic) {
     
     FxLog(@"KUpdatePassword = %@",dataDic);
     
     [self.tableView.mj_header endRefreshing];
     
     if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
     
         [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
         [self.navigationController popViewControllerAnimated:YES];
     
     }else {
     
         [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
     }
     
     } failure:^(NSError *error) {
     
    
     }];


    
}

#pragma mark UITextField
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *temp = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //看剩下的字符串的长度是否为零
    if ([temp length]==0 && textField.text.length == 0) {
        return NO;
    }
    NSLog(@"%ld",temp.length);
    if (range.location >= 20) {
        
        [[HUDConfig shareHUD]Tips:@"密码长度不超过20" delay:DELAY];
        return NO;
    }
    
    return YES;
}

#pragma  mark UITableVIewDelegate&&UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 3) {
        return 0.1;
    }
    
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}


@end
