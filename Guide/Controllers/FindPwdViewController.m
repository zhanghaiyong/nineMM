//
//  FindPwdViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/26.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "FindPwdViewController.h"
#import "RepeatPwdViewController.h"
@interface FindPwdViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@end

@implementation FindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.title = @"找回密码";
    
    if (_type == 101) {
        _tipsLabel.text = @"验证码已发送到手机邮箱XXXX@XX.com";
    }
}
- (IBAction)nextStep:(id)sender {
    
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    RepeatPwdViewController *repeatPwdVC = [loginSB instantiateViewControllerWithIdentifier:@"RepeatPwdViewController"];
    [self.navigationController pushViewController:repeatPwdVC animated:YES];
}


@end
