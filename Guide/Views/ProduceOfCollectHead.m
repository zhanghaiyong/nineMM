#import "ProduceOfCollectHead.h"

@implementation ProduceOfCollectHead

- (void)ProduceOfCollectHeadBack:(ProduceOfCollectHeadBlock)block {

    self.callBlock = block;
}
- (IBAction)typeButtonAction:(id)sender {
    
    UIButton *bt= (UIButton *)sender;
    
    self.callBlock(bt.tag);

}

@end
