//
//  MethodBagCell.h
//  Guide
//
//  Created by 张海勇 on 16/5/28.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MethodBagCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *isSelected;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UITextView *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *reduceButton;
@property (weak, nonatomic) IBOutlet UILabel *count;

@end
