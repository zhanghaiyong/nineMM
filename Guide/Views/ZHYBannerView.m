//
//  ZHYBannerView.m
//  Guide
//
//  Created by 张海勇 on 16/5/26.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ZHYBannerView.h"

@interface ZHYBannerView ()

@property (nonatomic,strong)UIScrollView *ScrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

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
    [self addSubview:self.ScrollView];
    
    self.pageControl = [[UIPageControl alloc]init];
    [self addSubview:self.pageControl];
}

- (void)layoutSubviews {

    self.ScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height);
    self.pageControl.frame = CGRectMake(0, self.height-30, self.width, 30);
}

-(void)setImageArray:(NSArray *)imageArray {
    
    _imageArray = imageArray;
    FxLog(@"%@",imageArray);
    
    self.pageControl.numberOfPages = imageArray.count;
    self.pageControl.currentPage = 0;
//            [self addTimer];
    
    [self.ScrollView setContentSize:CGSizeMake((imageArray.count + 2) * self.width, 0)];
    CGSize scrollViewSize = self.size;
    
    // 遍历创建子控件
    [imageArray enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.frame = CGRectMake((idx+1) * scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height);
        [Uitils cacheImagwWithSize:CGSizeMake(self.width, scrollViewSize.height) imageID:imageArray[idx] imageV:imageView placeholder:@"001"];
        [self.ScrollView addSubview:imageView];
    }];
    
    // 将最后一张图片弄到第一张的位置
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height);
    [Uitils cacheImagwWithSize:CGSizeMake(self.width, scrollViewSize.height) imageID:imageArray[[imageArray count] - 1] imageV:imageView placeholder:@"002"];
    [self.ScrollView addSubview:imageView];
    
    // 将第一张图片放到最后位置，造成视觉上的循环
    UIImageView *lastImageView = [[UIImageView alloc] init];
    lastImageView.image = [UIImage imageNamed:imageArray[0]];
    [Uitils cacheImagwWithSize:CGSizeMake(self.width, scrollViewSize.height) imageID:imageArray[0] imageV:lastImageView placeholder:@"002"];
    lastImageView.frame = CGRectMake(scrollViewSize.width * ([imageArray count] + 1), 0, scrollViewSize.width, scrollViewSize.height);
    [self.ScrollView addSubview:lastImageView];
    
    [self.ScrollView setContentOffset:CGPointMake(scrollViewSize.width, 0)];
    
    FxLog(@"%f",self.ScrollView.contentSize.width);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    FxLog(@"page = %ld",page);
    // 如果当前页是第0页就跳转到数组中最后一个地方进行跳转
    self.pageControl.currentPage = page-1;
    if (page == 0) {
        
        self.pageControl.currentPage = _imageArray.count-1;
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * ([self.imageArray count]), 0)];
        
    }else if (page == [self.imageArray count] + 1){
        
        self.pageControl.currentPage = 0;
        // 如果是第最后一页就跳转到数组第一个元素的地点
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
        
    }
}
@end
