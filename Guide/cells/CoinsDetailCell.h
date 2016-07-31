//
//  CoinsDetailCell.h
//  Guide
//
//  Created by 张海勇 on 16/7/5.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoinsDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *logIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *summary;

@property (weak, nonatomic) IBOutlet UILabel *coinCountLabel;
@end
