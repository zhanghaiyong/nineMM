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
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sender.tag = 10086+i;
        [sender addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sender];
        
        if (i == 0) {
            line = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-3, self.width/titleArray.count, 1.5)];
            line.backgroundColor = [UIColor blackColor];
            [self addSubview:line];
        }
        
    }
}

- (void)TitleViewCallBack:(TitleViewBlock)block {

    self.callBlock = block;
}

- (void)tapButton:(UIButton *)sender {

    self.callBlock(sender.tag);
    
    [UIView animateWithDuration:0.3 animations:^{
        line.frame = CGRectMake(sender.left, self.height-3, self.width/_titleArray.count, 1.5);
    }];

}
@end
