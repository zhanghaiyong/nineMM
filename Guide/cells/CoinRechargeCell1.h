//
//  CoinRechargeCell1.h
//  Guide
//
//  Created by 张海勇 on 16/7/15.
//  Copyright © 2016年 ksm. All rights reserved.
//

typedef void(^CoinRechargeCell1Block)(NSString *coinType);
typedef void(^sureRecharge)(void);

#import <UIKit/UIKit.h>

@interface CoinRechargeCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

- (IBAction)RechargeCoinType:(id)sender;

- (IBAction)sureRechargeAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UITableView *smallTableVIew;
@property (nonatomic,copy)CoinRechargeCell1Block block;
@property (nonatomic,copy)sureRecharge sureRechargeBlock;

- (void)getPackageList:(CoinRechargeCell1Block)block;

- (void)sureRechargeBlock:(sureRecharge)block;

@end

