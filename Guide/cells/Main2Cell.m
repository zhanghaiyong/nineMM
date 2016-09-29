#import "Main2Cell.h"

@interface Main2Cell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV1;
@property (weak, nonatomic) IBOutlet UIImageView *imageV2;
@property (weak, nonatomic) IBOutlet UIImageView *imageV3;
@end

@implementation Main2Cell


- (void)imageTap:(UITapGestureRecognizer *)gesture {
    
    UIImageView *imageV = (UIImageView *)gesture.view;
    
    if ([self.delegate respondsToSelector:@selector(main2CellTapImage:)]) {
        
        [self.delegate main2CellTapImage:imageV.tag];
    }
    NSLog(@"%ld",imageV.tag);
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    [self.imageV1 addGestureRecognizer:tap0];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    [self.imageV2 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    [self.imageV3 addGestureRecognizer:tap2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
