//
//  MyCoinsCell3.h
//  Guide
//
//  Created by 张海勇 on 16/7/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCoinsCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coinImage;
@property (weak, nonatomic) IBOutlet UILabel *coinName;
@property (weak, nonatomic) IBOutlet UILabel *usableCoin;
@property (weak, nonatomic) IBOutlet UILabel *freezeCoin;
@property (weak, nonatomic) IBOutlet UILabel *expireLabel;

@end
