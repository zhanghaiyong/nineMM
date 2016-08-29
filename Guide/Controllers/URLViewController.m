//
//  URLViewController.m
//  Guide
//
//  Created by 张海勇 on 16/7/25.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "URLViewController.h"

@interface URLViewController ()

@end

@implementation URLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"urlString = %@",self.urlString);
    
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSURL *url = [[NSURL alloc]initWithString:self.urlString];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}



@end
