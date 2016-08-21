//
//  BagOrderCell.h
//  Guide
//
//  Created by 张海勇 on 16/8/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@interface OtherOrderCell : UITableViewCell

@property (nonatomic,strong)OrderModel *orderModel;

@property (weak, nonatomic) IBOutlet UILabel *orderCode;
@property (weak, nonatomic) IBOutlet UIButton *orderStatus;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *coins;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UILabel *rmb;

@end
