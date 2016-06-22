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
//    
//    [_accountTF setValue:lever3Color forKeyPath:@"_placeholderLabel.textColor"];
//    [_accountTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
//    
//    [_pwdTF setValue:lever3Color forKeyPath:@"_placeholderLabel.textColor"];
//    [_pwdTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
}


- (IBAction)loginAction:(id)sender {
    
//    [self presentViewController:[PageInfo pageControllers] animated:YES completion:nil];
}

@end
