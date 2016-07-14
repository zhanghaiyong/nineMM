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

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {

    imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    
    label = [[UILabel alloc]init];
    label.textColor = lever1Color;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:13];
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

    imageView.frame = CGRectMake(self.width/2-20, 5, 40, 40);
    imageView.contentMode = UIViewContentModeCenter;
    
    self.badgeBtn.frame = CGRectMake(imageView.right-25, imageView.top+10, 20, 20);
    self.badgeBtn.layer.cornerRadius = 10;
    self.badgeBtn.clipsToBounds = YES;
    [self.badgeBtn setTitle:@"0" forState:UIControlStateNormal];
    
    label.frame = CGRectMake(0, imageView.bottom-3, self.width, 20);
    label.text = self.labelTitle;
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
    
    [Uitils cacheImagwWithSize:CGSizeMake(38, 38) imageID:imageName imageV:imageView placeholder:@"下载(5)"];
    
//    imageView.image = [UIImage imageNamed:imageName];
}

//添加的手势方法
- (void)tapAction:(UITapGestureRecognizer *)gesture {

    if ([self.delegate respondsToSelector:@selector(buttonViewTap:)]) {
        [self.delegate buttonViewTap:self.tag];
    }
}

@end
