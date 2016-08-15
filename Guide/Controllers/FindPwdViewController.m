//
//  FindPwdViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/26.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "FindPwdViewController.h"
#import "ValidCodeParams.h"
#import "ResetPwdParams.h"
@interface FindPwdViewController ()
{
    /**
     *  定时器
     */
    NSTimer *timer;
    /**
     *  获取验证码倒计时
     */
    NSInteger  count;
}
@property (weak, nonatomic) IBOutlet UITextField *regedPhone;
@property (weak, nonatomic) IBOutlet UITextField *phoneCode;
@property (weak, nonatomic) IBOutlet UIButton *senderCode;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UITextField *resetPwd;
@property (weak, nonatomic) IBOutlet UITextField *repeatPwd;

@end

@implementation FindPwdViewController

- (IBAction)showPwdAction:(id)sender {
    
    
    UIButton *button = (UIButton *)sender;
    if (button.selected == NO) {
        
        button.selected               = YES;
        _resetPwd.secureTextEntry     = NO;
        _repeatPwd.secureTextEntry     = NO;
    }else {
        
        button.selected = NO;
        _resetPwd.secureTextEntry     = YES;
        _repeatPwd.secureTextEntry     = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    count = 60;
}

- (IBAction)sendCodeAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    if (self.regedPhone.text.length == 0) {
        
        [[HUDConfig shareHUD]Tips:@"请输入注册手机号" delay:DELAY];
        return;
    }
    
    if (![self.regedPhone.text isMobilphone]) {
     
        [[HUDConfig shareHUD]Tips:@"请输入正确的手机号" delay:DELAY];
        return;
    }
    
    self.tipsLabel.hidden = NO;

    [self.regedPhone resignFirstResponder];
    count = 60;
    
    if ([button.currentTitle isEqualToString:@"发送验证码"]) {
     
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
        [self.senderCode setTitle:[NSString stringWithFormat:@"%ld",(long)count] forState:UIControlStateNormal];
        
        ValidCodeParams *validCodeParams = [[ValidCodeParams alloc]init];
        validCodeParams.phone = self.regedPhone.text;
        validCodeParams.username = self.regedPhone.text;
        validCodeParams.busiType = @"resetPsw";
        [KSMNetworkRequest postRequest:KValidCode params:validCodeParams.mj_keyValues success:^(NSDictionary *dataDic) {
            
            NSLog(@"validCodeParams = %@ \n dataDic = %@",validCodeParams.mj_keyValues,dataDic);
            if ([[dataDic objectForKey:@"retCode"] integerValue] != 0) {
                
                [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            }
            
        } failure:^(NSError *error) {
            
            
        }];
    }
}

#pragma mark 验证倒计时
- (void)countDown:(NSTimer *)time {
    
    if (count == 1) {
        [self.senderCode setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.senderCode.userInteractionEnabled = YES;
        [time invalidate];
    }else {
        count--;
        
        if (count == 57) {
            
            self.tipsLabel.hidden = YES;
        }
        
        [self.senderCode setTitle:[NSString stringWithFormat:@"%ld",(long)count] forState:UIControlStateNormal];
        self.senderCode.userInteractionEnabled = NO;
    }
    
}

- (IBAction)nextStep:(id)sender {
    
    if (self.regedPhone.text.length == 0) {
        
        [[HUDConfig shareHUD]Tips:@"请输入注册手机号" delay:DELAY];
        return;
    }
    
    if (![self.regedPhone.text isMobilphone]) {
        
        [[HUDConfig shareHUD]Tips:@"请输入正确的手机号" delay:DELAY];
        return;
    }
    
    if (self.phoneCode.text.length == 0) {
        
        [[HUDConfig shareHUD]Tips:@"请输入验证码" delay:DELAY];
        return;
    }
    
    if (self.resetPwd.text.length == 0) {
        
        [[HUDConfig shareHUD]Tips:@"请输入新密码" delay:DELAY];
        return;
    }
    
    if (![self.resetPwd.text isEqual:self.repeatPwd.text]) {
        
        [[HUDConfig shareHUD]Tips:@"两次输入的密码不一致" delay:DELAY];
        return;
    }
    
    
    [[HUDConfig shareHUD]alwaysShow];
    
    ResetPwdParams *resetPwdParams = [[ResetPwdParams alloc]init];
    resetPwdParams.username        = self.regedPhone.text;
    resetPwdParams.password        = self.resetPwd.text;
    resetPwdParams.validCode       = self.phoneCode.text;
    resetPwdParams.phone           = self.self.regedPhone.text;
    
    [KSMNetworkRequest postRequest:KResetPwd params:resetPwdParams.mj_keyValues success:^(NSDictionary *dataDic) {
        
        NSLog(@"resetPwdParams = %@ \n dataDic = %@",resetPwdParams.mj_keyValues,dataDic);
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
        
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
        
    }];


}


@end
