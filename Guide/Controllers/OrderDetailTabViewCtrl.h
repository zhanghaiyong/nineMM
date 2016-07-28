//
//  OrderDetailTabViewCtrl.h
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseTableViewController.h"

@interface OrderDetailTabViewCtrl : BaseTableViewController

@property (nonnull,strong)NSString *orderId;
@property (nonatomic,assign)BOOL surePayProduce;

@end
