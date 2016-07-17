//
//  OrderListParams.h
//  Guide
//
//  Created by 张海勇 on 16/7/17.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface OrderListParams : BaseParams

//不传为全部订单,可选项（unconfirmed:待审核,shipping:执行中,cancelled:已取消,complained:申诉订单）
@property (nonatomic,strong)NSString *orderStatus;
@property (nonatomic,assign)int    rows;
@property (nonatomic,assign)int    page;

@end
