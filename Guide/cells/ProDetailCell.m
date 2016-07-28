#import "ProDetailCell.h"

@implementation ProDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLineIndex:(NSInteger)lineIndex {

    FxLog(@"lineIndex = %ld",lineIndex);
    
    UIButton *button = (UIButton *)[self.contentView viewWithTag:lineIndex+100];
     FxLog(@"buttonTitle = %@",button.currentTitle);
    self.lineView.center = CGPointMake(button.center.x, self.lineView.center.y);
}

- (IBAction)typeAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.center = CGPointMake(button.center.x, self.lineView.center.y);
    }];
    
    switch (button.tag) {
        case 100:
            break;
        case 101:
            break;
        case 102:
            break;
            
        default:
            break;
    }
    
    self.block(button.tag-100);
}

- (void)proDetailTypeChange:(ProDetailCell2Block)block {
    
    _block = block;
}
- (void)toUserSource:(toUserSourceVC)block {

    _toUserSurBlock = block;
}

- (void)toStores:(toStoresVC)block {

    _toStores = block;
}
- (IBAction)toStoresVCAction:(id)sender {
    
    self.toStores();
}


- (IBAction)userSourceAction:(id)sender {
    
    self.toUserSurBlock();
}

@end
