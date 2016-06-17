//
//  ProduceOfCollectHead.m
//  Guide
//
//  Created by 张海勇 on 16/5/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ProduceOfCollectHead.h"

@implementation ProduceOfCollectHead

- (void)ProduceOfCollectHeadBack:(ProduceOfCollectHeadBlock)block {

    self.callBlock = block;
}
- (IBAction)typeButtonAction:(id)sender {
    
    UIButton *bt= (UIButton *)sender;
    
    self.callBlock(bt.tag);

}

@end
