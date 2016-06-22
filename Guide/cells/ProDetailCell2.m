//
//  ProDetailCell2.m
//  Guide
//
//  Created by 张海勇 on 16/6/21.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ProDetailCell2.h"

@implementation ProDetailCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.viewWidth.constant = SCREEN_WIDTH*3;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setScrollTag:(NSInteger)scrollTag {

    _scrollTag = scrollTag;
    switch (scrollTag) {
        case 0:{
           self.scrollView.contentOffset = CGPointMake(0, 0);
        }
            break;
        case 1:{
            self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        }
            break;
        case 2:{
            self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*2, 0);
        }
            break;
        default:
            break;
    }
}


@end
