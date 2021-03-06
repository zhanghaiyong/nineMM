#import "ButtonView.h"

@implementation ButtonView
{
    UILabel *label;
    UIImageView *imageView;
}
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image{

    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        _labelTitle = title;
        _imageName = image;
        [self loadSubViews];
}
    return self;
}

-(void)setSize:(CGSize)size {

    [super setSize:size];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
    [self loadSubViews];
    
}
//
//- (instancetype)initWithCoder:(NSCoder *)coder {
//    self = [super initWithCoder:coder];
//    if (self) {
//        
//        [self loadSubViews];
//    }
//    return self;
//}

- (void)setImageSize:(CGSize)imageSize {

    _imageSize = imageSize;
    imageView.frame = CGRectMake(self.width/2-imageSize.width/2, 10, imageSize.width, imageSize.height);
    label.frame = CGRectMake(0, imageView.bottom, self.width, 20);
}

- (void)loadSubViews {

    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2-19, 10, 38, 38)];
    imageView.contentMode = UIViewContentModeCenter;
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:imageView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom, self.width, 20)];
    label.textColor = lever1Color;
    label.text = self.labelTitle;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:12.5];
    label.adjustsFontSizeToFitWidth = YES;
    [self addSubview:label];
    
    self.badgeBtn = [[UIButton alloc]init];
    self.badgeBtn.backgroundColor = [UIColor redColor];
    [self.badgeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.badgeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    self.badgeBtn.hidden = YES;
    [self addSubview:self.badgeBtn];
}

- (void)layoutSubviews {

    [super layoutSubviews];

    if (!_isNetImage) {
        imageView.image = [UIImage imageNamed:_imageName];
    }
//
//    self.badgeBtn.frame = CGRectMake(imageView.right-25, imageView.top+10, 20, 20);
//    self.badgeBtn.layer.cornerRadius = 10;
//    self.badgeBtn.clipsToBounds = YES;
//    [self.badgeBtn setTitle:@"0" forState:UIControlStateNormal];
//    
//    label.frame = CGRectMake(0, imageView.bottom-3, self.width, 20);
    
}

/**
 *  labelTitle setting方法
 */
-(void)setLabelTitle:(NSString *)labelTitle {

    _labelTitle = labelTitle;
    label.text = labelTitle;
}

/**
 *  imageName setting方法
 */
- (void)setImageName:(NSString *)imageName {

    _imageName = imageName;
    if (_isNetImage) {
       [Uitils cacheImagwWithSize:CGSizeMake(38*2, 38*2) imageID:imageName imageV:imageView placeholder:nil];
        
    }else {
        imageView.image = [UIImage imageNamed:imageName];   
    }
}

//添加的手势方法
- (void)tapAction:(UITapGestureRecognizer *)gesture {

    if ([self.delegate respondsToSelector:@selector(buttonViewTap:)]) {
        [self.delegate buttonViewTap:self.tag];
    }
}

@end
