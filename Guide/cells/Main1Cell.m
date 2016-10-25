#import "Main1Cell.h"

@implementation Main1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)cell1tapAction:(id)sender {
    
    self.block();
}

- (void)tapNewSourceAction:(MainCell1Block)block {

    _block = block;
}

@end
