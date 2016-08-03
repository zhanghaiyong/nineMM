//
//  MsgDetailViewController.m
//  Guide
//
//  Created by 张海勇 on 16/8/3.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MsgDetailViewController.h"

@interface MsgDetailViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation MsgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"消息详情";
    
    NSString *urlStr = [NSString stringWithFormat:@"http://9mama.top/notify/mobile/%@.page?sessionId=%@",self.ID,[Uitils getUserDefaultsForKey:TOKEN]];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {

    [[HUDConfig shareHUD] alwaysShow];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [[HUDConfig shareHUD] dismiss];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

    [[HUDConfig shareHUD] dismiss];
}

@end
