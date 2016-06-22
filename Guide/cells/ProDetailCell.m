//
//  ProDetailCell.m
//  Guide
//
//  Created by 张海勇 on 16/6/21.
//  Copyright © 2016年 ksm. All rights reserved.
//

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

    NSLog(@"lineIndex = %ld",lineIndex);
    
    UIButton *button = (UIButton *)[self.contentView viewWithTag:lineIndex+100];
     NSLog(@"buttonTitle = %@",button.currentTitle);
    self.lineView.center = CGPointMake(button.center.x, self.lineView.center.y);
}

- (IBAction)typeAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.center = CGPointMake(button.center.x, self.lineView.center.y);
    }];
    
    NSLog(@"%@",NSStringFromCGPoint(self.lineView.center));
    
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

- (IBAction)userSourceAction:(id)sender {
    
    self.toUserSurBlock();
}

@end
