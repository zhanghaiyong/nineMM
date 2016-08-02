//
//  MsgCenterModel.h
//  Guide
//
//  Created by 张海勇 on 16/8/2.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgCenterModel : NSObject

@property (nonatomic,strong)NSString *code;
@property (nonatomic,strong)NSString *firstUnread;
@property (nonatomic,strong)NSString *icon;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *unreadCount;

@end
