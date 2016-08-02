//
//  MsgListParams.h
//  Guide
//
//  Created by 张海勇 on 16/8/2.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface MsgListParams : BaseParams

@property (nonatomic,strong)NSString *categoryCode;
@property (nonatomic,assign)int rows;
@property (nonatomic,assign)int page;

@end
