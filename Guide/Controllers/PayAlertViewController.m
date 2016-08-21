//
//  PayAlertViewController.m
//  Guide
//
//  Created by 张海勇 on 16/7/16.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "PayAlertViewController.h"
#import "OrderTypeTableVC.h"
@interface PayAlertViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation PayAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"线下支付";
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/offlinePaymentInfo/%@.page",BaseURLString,self.orderId];
    NSURL *url = [[NSURL alloc]initWithString:strUrl];
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (IBAction)sureAction:(id)sender {
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    OrderTypeTableVC *orderType = [mainSB instantiateViewControllerWithIdentifier:@"OrderTypeTableVC"];
    orderType.orderType = 100;
    
    [self.navigationController pushViewController:orderType animated:YES];
}
@end
