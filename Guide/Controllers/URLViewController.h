//
//  URLViewController.h
//  Guide
//
//  Created by 张海勇 on 16/7/25.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseViewController.h"

@interface URLViewController : BaseViewController

@property (weak, nonatomic ) IBOutlet UIWebView *webView;
@property (nonatomic,strong) NSString  *urlString;
@end
