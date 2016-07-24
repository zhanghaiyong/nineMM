#import <UIKit/UIKit.h>

@protocol ZHYBannerViewDelegte <NSObject>

- (void)tapBannerImage:(NSInteger)imageTag;

@end

@interface ZHYBannerView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong)NSArray *imageArray;
@property (nonatomic,assign)id<ZHYBannerViewDelegte>delegate;

@end
