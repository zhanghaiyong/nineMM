#import "SearchBar.h"

@implementation SearchBar

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
- (IBAction)buttonAction:(id)sender {
    
    self.block();
    
}

- (void)connectTwoBlock:(toMsgCenterBlock)block {

    _block = block;
}

@end
