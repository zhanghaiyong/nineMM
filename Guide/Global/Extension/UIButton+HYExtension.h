#import <UIKit/UIKit.h>

@interface UIButton (HYExtension)

//为按钮添加点击事件
- (void)setAction:(void (^)(void))action;
- (void)setAction1:(void (^)(UIButton *button))action;
@end
