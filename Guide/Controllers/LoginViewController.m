//
//  LoginViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/26.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "LoginViewController.h"
#import "TabBarViewController.h"
#import "PageInfo.h"
#import "LoginParams.h"
#import "FindPwdViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *visualView;
@property (weak, nonatomic) IBOutlet UILabel *tipsLbel;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.visualView.hidden = YES;
    [_accountTF setValue:@5 forKey:@"paddingLeft"];
    [_pwdTF setValue:@5 forKey:@"paddingLeft"];
    
    if ([Uitils getUserDefaultsForKey:USERNAME]) {
        _accountTF.text = [Uitils getUserDefaultsForKey:USERNAME];
    }
}
- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showPwdAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    if (button.selected == NO) {
        
        button.selected = YES;
        _pwdTF.secureTextEntry = NO;
    }else {
    
        button.selected = NO;
        _pwdTF.secureTextEntry = YES;
    }
}

#pragma mark UITextField

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@" "] || [string isEqualToString:@"\n"]) {
        return NO;
    }
    
    if (textField == self.pwdTF) {
        
        NSString *tempString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSLog(@"%ld",tempString.length);
        if (tempString.length > 20) {
            
            [[HUDConfig shareHUD]Tips:@"密码长度不超过20" delay:DELAY];
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    [self loginMethod];
    
    return YES;
}

- (IBAction)loginAction:(id)sender {
    
    [self loginMethod];
}

- (void)loginMethod {

    //    [self presentViewController:[PageInfo pageControllers] animated:YES completion:nil];
    
    if (_accountTF.text.length == 0) {
        
        [[HUDConfig shareHUD]Tips:@"请输入帐号" delay:DELAY];
        return;
    }
    
    if (_pwdTF.text.length == 0) {
        
        [[HUDConfig shareHUD]Tips:@"请输入密码" delay:DELAY];
        return;
        
    }
    
    [[HUDConfig shareHUD] alwaysShow];
    LoginParams *params = [[LoginParams alloc]init];
    params.username     = _accountTF.text;
    params.password     = _pwdTF.text;
    
    
    NSLog(@"params = %@  %@",params.mj_keyValues,KLogin);
    
    [KSMNetworkRequest postRequest:KLogin params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        NSLog(@"dataDic = %@",dataDic);
        [[HUDConfig shareHUD]dismiss];
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD] SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            [Uitils setUserDefaultsObject:_pwdTF.text ForKey:PASSWORD];
            [Uitils setUserDefaultsObject:_accountTF.text ForKey:USERNAME];
            
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[[[dataDic objectForKey:@"retObj"]objectForKey:@"alertMsg"] objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginLinkAction" object:self userInfo:[[dataDic objectForKey:@"retObj"] objectForKey:@"alertMsg"]];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                     [self dismissViewControllerAnimated:YES completion:nil];
                    
                }]];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }else {
            
                 [self dismissViewControllerAnimated:YES completion:nil];
            }

            
            
        }else {
            
            [[HUDConfig shareHUD] ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (IBAction)forgetPwdAction:(id)sender {
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    FindPwdViewController *findPwd = [mainSB instantiateViewControllerWithIdentifier:@"FindPwdViewController"];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:findPwd];
    [self presentViewController:navi animated:YES completion:nil];
}

@end
