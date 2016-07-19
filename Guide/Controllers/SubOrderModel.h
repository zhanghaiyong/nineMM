//
//  SubOrderModel.h
//  Guide
//
//  Created by 张海勇 on 16/7/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubOrderModel : NSObject

@property (nonatomic,assign)int productId;
@property (nonatomic,assign)int quantity;
@property (nonatomic,strong)NSString *items;
@property (nonatomic,strong)NSString *storeSelectingType;
@property (nonatomic,strong)NSString *stores;
@property (nonatomic,strong)NSString *areas;

@end
