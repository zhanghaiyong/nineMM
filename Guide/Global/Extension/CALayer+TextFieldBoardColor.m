#import "CALayer+TextFieldBoardColor.h"

@implementation CALayer (TextFieldBoardColor)

- (void)setBorderUIColor:(UIColor *)borderUIColor
{
    self.borderColor=borderUIColor.CGColor;
}
- (UIColor *)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
