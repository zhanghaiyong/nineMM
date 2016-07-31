#import <UIKit/UIKit.h>

typedef void(^countWebViewHBlock)(float webViewH);

@interface ProDetailCell2 : UITableViewCell<UIWebViewDelegate>

@property (nonatomic,strong)NSURL *htmlUrl;
@property (nonatomic,assign)BOOL  isRefreshWebView;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic,copy)countWebViewHBlock block;

- (void)countWebViewHeight:(countWebViewHBlock)block;

@end
