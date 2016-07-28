#import "ProDetailCell2.h"

@implementation ProDetailCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    self.webView.delegate = self;
    
//    self.viewWidth.constant = SCREEN_WIDTH*3;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setHtmlUrl:(NSURL *)htmlUrl {

    _htmlUrl = htmlUrl;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:htmlUrl]];
}

#pragma mark UIWe=bViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *height_str = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
    float webViewH = [height_str floatValue];
    NSLog(@"height_str = %lf",webViewH);
    
    if (self.isRefreshWebView) {   
        self.block(webViewH);
    }
    
}

- (void)countWebViewHeight:(countWebViewHBlock)block {

    _block = block;
}


@end
