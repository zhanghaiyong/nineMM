//
//  CoinRechargeCell2.h
//  Guide
//
//  Created by 张海勇 on 16/7/16.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoinRechargeCell2 : UITableViewCell
/**
 *  币种
 */
@property (weak, nonatomic) IBOutlet UILabel *coinType;
/**
 *  金额
 */
@property (weak, nonatomic) IBOutlet UILabel *coins;
/**
 *  现金
 */
@property (weak, nonatomic) IBOutlet UILabel *rmbLabel;
/**
 *  有效期
 */
@property (weak, nonatomic) IBOutlet UILabel *validDate;
@end
