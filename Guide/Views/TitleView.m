//
//  TitleView.m
//  Guide
//
//  Created by 张海勇 on 16/5/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView
{
    UIView *line;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)setTitleArray:(NSArray *)titleArray {

    _titleArray = titleArray;
    
    for (int i = 0; i<titleArray.count; i++) {
        UIButton *sender = [[UIButton alloc]initWithFrame:CGRectMake(i*self.width/titleArray.count, 0, self.width/titleArray.count, self.height)];
        [sender setTitle:titleArray[i] forState:UIControlStateNormal];
        sender.tag = 10086+i;
        sender.titleLabel.font = lever2Font;
        [sender addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sender];
        
        if (i == 0) {
            [sender setTitleColor:self.selectedColor forState:UIControlStateNormal];
            CGRect frame = [(NSString *)titleArray[0] boundingRectWithSize:CGSizeMake(0, self.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:lever2Font} context:nil];
            line = [[UIView alloc]initWithFrame:CGRectMake(sender.width/2-frame.size.width/2, self.height-10, frame.size.width, 1.5)];
            line.backgroundColor = self.selectedColor;
            [self addSubview:line];
        }else {
        
            [sender setTitleColor:self.normalColor forState:UIControlStateNormal];
        }
        
    }
}

- (void)TitleViewCallBack:(TitleViewBlock)block {

    self.callBlock = block;
}

- (void)tapButton:(UIButton *)sender {

    self.callBlock(sender.tag);
    
    for (int i = 0; i<_titleArray.count; i++) {
        
        UIButton *btn = (UIButton *)[self viewWithTag:10086+i];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
    }
    
    [sender setTitleColor:self.selectedColor forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        line.center = CGPointMake(sender.center.x, line.center.y);
    }];

}
@end
