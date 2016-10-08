#import "Main3Cell.h"

@interface Main3Cell ()


@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation Main3Cell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    [self.imageV addGestureRecognizer:tap0];
}

- (void)imageTap:(UITapGestureRecognizer *)gesture {
    
    UIImageView *imageV = (UIImageView *)gesture.view;
    
    if ([self.delegate respondsToSelector:@selector(main3CellTapImage:)]) {
        
        [self.delegate main3CellTapImage:imageV.tag];
    }
    FxLog(@"%ld",imageV.tag);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
