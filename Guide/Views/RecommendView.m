//
//  RecommendView.m
//  Guide
//
//  Created by 张海勇 on 16/5/26.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "RecommendView.h"

@interface RecommendView ()

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *produce;
@property (nonatomic,strong)UILabel *now;
@property (nonatomic,strong)UILabel *original;

@end

@implementation RecommendView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {

    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    
    self.produce = [[UILabel alloc]init];
    self.produce.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.produce];
    
    self.now = [[UILabel alloc]init];
    self.now.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.now];
    
    self.original = [[UILabel alloc]init];
    self.original.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.original];
}

- (void)layoutSubviews {

    self.imageView.frame = CGRectMake(0, 0, self.width, self.height);
    
    self.produce.frame = CGRectMake(0, self.height/2-10, self.width, 20);
    
    self.now.frame = CGRectMake(0, self.height-20, self.width/2, 20);
    
    self.original.frame = CGRectMake(self.now.right, self.height-20, self.width/2, 20);
}

-(void)setImageName:(NSString *)imageName {

    _imageName = imageName;
    _imageView.image = [UIImage imageNamed:imageName];
}

-(void)setProduceName:(NSString *)produceName {

    _produceName = produceName;
    _produce.text = produceName;
}

- (void)setNowPrice:(NSString *)nowPrice {

    _nowPrice = nowPrice;
    _now.text = nowPrice;
}

- (void)setOriginalPirce:(NSString *)originalPirce {

    _originalPirce = originalPirce;
    _original.text = originalPirce;
}

@end
