//
//  MsgCenterCell.m
//  Guide
//
//  Created by 张海勇 on 16/8/2.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MsgCenterCell.h"

@implementation MsgCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.logo.contentMode = UIViewContentModeCenter;
    [self.logo setContentMode:UIViewContentModeScaleToFill];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
