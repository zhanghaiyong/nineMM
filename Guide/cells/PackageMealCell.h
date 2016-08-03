//
//  PackageMealCell.h
//  Guide
//
//  Created by 张海勇 on 16/8/3.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PackageMealCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;

@end
