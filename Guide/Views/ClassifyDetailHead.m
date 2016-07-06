#import "ClassifyDetailHead.h"

@implementation ClassifyDetailHead


//1000为时间 1001为折扣 1002为筛选
- (IBAction)tapButtonAction:(id)sender {
    
    for (int i = 0; i<3; i++) {
        
        UIButton *btn =  (UIButton *)[self viewWithTag:i+1000];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.selected = NO;
    }
    
    UIButton *button = (UIButton *)sender;
    [button setTitleColor:MainColor forState:UIControlStateNormal];
    button.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(searchTerm:)]) {
        
        [self.delegate searchTerm:button.tag];
    }
}

@end
