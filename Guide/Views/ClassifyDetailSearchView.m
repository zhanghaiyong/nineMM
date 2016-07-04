#import "ClassifyDetailSearchView.h"

@implementation ClassifyDetailSearchView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    }
    return self;
}

-(void)callBack:(RemoveView)block {

    self.moveBlock = block;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    self.moveBlock(YES);
}

@end
