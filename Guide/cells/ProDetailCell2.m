#import "ProDetailCell2.h"

@implementation ProDetailCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
//    self.webView.scalesPageToFit = YES;
//    self.webView. = lever2Font;
    
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
    
    NSString *height_str = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
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
