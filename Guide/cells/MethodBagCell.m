//
//  MethodBagCell.m
//  Guide
//
//  Created by 张海勇 on 16/5/28.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MethodBagCell.h"

@implementation MethodBagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectAction:(id)sender {
    
}

- (IBAction)addAction:(id)sender {
    
    _count.text = [NSString stringWithFormat:@"%ld",[_count.text integerValue]+1];
}

- (IBAction)reduceAction:(id)sender {
    
    if ([_count.text integerValue] > 0) {
        
        _count.text = [NSString stringWithFormat:@"%ld",[_count.text integerValue]-1];
    }
}

@end
