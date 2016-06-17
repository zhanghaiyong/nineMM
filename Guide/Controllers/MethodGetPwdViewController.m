//
//  PhoneGetPwdViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/26.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MethodGetPwdViewController.h"
#import "FindPwdViewController.h"
@interface MethodGetPwdViewController ()

@end

@implementation MethodGetPwdViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendCodeAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    //100为手机，101为邮箱
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    FindPwdViewController *findPwdVC = [loginSB instantiateViewControllerWithIdentifier:@"FindPwdViewController"];
    findPwdVC.type = button.tag;
    [self.navigationController pushViewController:findPwdVC animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
