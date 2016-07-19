//
//  sureOrderFoorView.m
//  Guide
//
//  Created by 张海勇 on 16/7/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "sureOrderFoorView.h"

@implementation sureOrderFoorView

- (IBAction)nowBuyAction:(id)sender {
    
    self.block();
    
}

- (void)nowBuyProduce:(sureOrderFootBlock)block {

    _block = block;
}

@end
