#import "ZHYBannerView.h"

@interface ZHYBannerView ()

@property (nonatomic,strong)UIScrollView *ScrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic, strong)NSTimer *timer;

@end

@implementation ZHYBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {

    self.ScrollView = [[UIScrollView alloc]init];
    self.ScrollView.delegate = self;
    self.ScrollView.showsHorizontalScrollIndicator = NO;
    self.ScrollView.pagingEnabled = YES;
    self.ScrollView.scrollEnabled = YES;
    [self addSubview:self.ScrollView];
    
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:self.pageControl];
}

- (void)layoutSubviews {

    self.ScrollView.frame = CGRectMake(0, 0, self.width, self.height);
    self.pageControl.frame = CGRectMake(0, self.height-30, self.width, 30);
}

-(void)setImageArray:(NSArray *)imageArray {
    
    _imageArray = imageArray;
    
    self.pageControl.numberOfPages = imageArray.count;
    self.pageControl.currentPage = 0;
//            [self addTimer];
    
    [self.ScrollView setContentSize:CGSizeMake((imageArray.count + 2) * self.width, 0)];
    CGSize scrollViewSize = self.size;
    
    NSLog(@"afssrhfjg = %@",NSStringFromCGSize(scrollViewSize));
    
    
    // 遍历创建子控件
    [imageArray enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.frame = CGRectMake((idx+1) * scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height);
        [Uitils cacheImagwWithSize:CGSizeMake(scrollViewSize.width, scrollViewSize.height) imageID:imageArray[idx] imageV:imageView placeholder:@""];
        imageView.userInteractionEnabled = YES;
        [self.ScrollView addSubview:imageView];
        imageView.tag = idx+1000;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
        [imageView addGestureRecognizer:tap];
    }];
    
    // 将最后一张图片弄到第一张的位置
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height);
    [Uitils cacheImagwWithSize:CGSizeMake(scrollViewSize.width, scrollViewSize.height) imageID:imageArray[[imageArray count] - 1] imageV:imageView placeholder:@""];
    imageView.userInteractionEnabled = YES;
    [self.ScrollView addSubview:imageView];
    imageView.tag = [imageArray count] - 1+1000;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    [imageView addGestureRecognizer:tap1];
    
    // 将第一张图片放到最后位置，造成视觉上的循环
    UIImageView *lastImageView = [[UIImageView alloc] init];
    lastImageView.image = [UIImage imageNamed:imageArray[0]];
    [Uitils cacheImagwWithSize:CGSizeMake(scrollViewSize.width, scrollViewSize.height) imageID:imageArray[0] imageV:lastImageView placeholder:@""];
    lastImageView.frame = CGRectMake(scrollViewSize.width * ([imageArray count] + 1), 0, scrollViewSize.width, scrollViewSize.height);
    lastImageView.userInteractionEnabled = YES;
    [self.ScrollView addSubview:lastImageView];
    [self.ScrollView setContentOffset:CGPointMake(scrollViewSize.width, 0)];
    lastImageView.tag = 1000;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    [lastImageView addGestureRecognizer:tap2];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
        NSInteger page = scrollView.contentOffset.x / scrollView.width;
        FxLog(@"page = %ld",page);
        // 如果当前页是第0页就跳转到数组中最后一个地方进行跳转
        self.pageControl.currentPage = page-1;
        if (page == 0) {
            
            self.pageControl.currentPage = _imageArray.count-1;
            [scrollView setContentOffset:CGPointMake(scrollView.width * ([self.imageArray count]), 0)];
            
        }else if (page == [self.imageArray count] + 1){
            
            self.pageControl.currentPage = 0;
            // 如果是第最后一页就跳转到数组第一个元素的地点
            [scrollView setContentOffset:CGPointMake(scrollView.width, 0)];
            
        }
}

- (void)imageTap:(UITapGestureRecognizer *)gesture {

    UIImageView *imageV = (UIImageView *)gesture.view;
    
    if ([self.delegate respondsToSelector:@selector(tapBannerImage:)]) {
        
        [self.delegate tapBannerImage:imageV.tag];
    }
    
    NSLog(@"%ld",imageV.tag);
}

@end
