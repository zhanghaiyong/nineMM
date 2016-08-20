#import "MethodBagCell.h"

@implementation MethodBagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectAction:(id)sender {
    
}

- (IBAction)addAction:(id)sender {
    
    _count.text = [NSString stringWithFormat:@"%ld",[_count.text integerValue]+1];
    
    self.block(self.count.text,@"add");
}

- (IBAction)reduceAction:(id)sender {
    
    if ([_count.text integerValue] > 0) {
        
        _count.text = [NSString stringWithFormat:@"%ld",[_count.text integerValue]-1];
    }
    
    self.block(self.count.text,@"reduce");
}

- (void)repeatCount:(MethodBagCellBlock)block {

    _block = block;
}

- (IBAction)selectedAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    if (button.selected) {
        
        self.isSelected.selected = NO;
    }else {
    
        self.isSelected.selected = YES;
    }
    
}

@end
