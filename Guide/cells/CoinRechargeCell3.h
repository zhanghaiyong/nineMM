//
//  CoinRechargeCell3.h
//  Guide
//
//  Created by 张海勇 on 16/7/16.
//  Copyright © 2016年 ksm. All rights reserved.
//

typedef void(^toChosePayMethodBlock)(void);

#import <UIKit/UIKit.h>

@interface CoinRechargeCell3 : UITableViewCell

- (IBAction)toChosePayMethod:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (nonatomic,copy)toChosePayMethodBlock block;

- (void)userBlockToVC:(toChosePayMethodBlock)block;

@end
