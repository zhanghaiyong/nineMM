//
//  OrderDetailTabViewCtrl.h
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//




#import "BaseTableViewController.h"

@protocol cancleOrderSuccessDelegate <NSObject>

- (void)deleteOrder:(NSInteger)section;

@end

@interface OrderDetailTabViewCtrl : BaseViewController

@property (nonnull,strong)NSString *orderId;

@property (nonatomic,assign)BOOL surePayProduce;

@property (nonatomic,assign)NSInteger section;

@property (nonatomic,assign)id<cancleOrderSuccessDelegate>delegate;

@end
