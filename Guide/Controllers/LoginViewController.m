//
//  LoginViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/26.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "LoginViewController.h"
#import "MethodGetPwdViewController.h"
#import "TabBarViewController.h"
#import "PageInfo.h"
#import "LoginParams.h"

@interface LoginViewController ()

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.visualView.hidden = YES;
    [_accountTF setValue:@5 forKey:@"paddingLeft"];
    [_pwdTF setValue:@5 forKey:@"paddingLeft"];
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

- (IBAction)loginAction:(id)sender {
    
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
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD] SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else {
        
            [[HUDConfig shareHUD] ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
         
    }];
}


@end
