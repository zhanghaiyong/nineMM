//
//  PayAlertViewController.m
//  Guide
//
//  Created by 张海勇 on 16/7/16.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "PayAlertViewController.h"

@interface PayAlertViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation PayAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"线下支付";
    
    NSURL *url = [[NSURL alloc]initWithString:@"http://www.baidu.com"];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (IBAction)sureAction:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
