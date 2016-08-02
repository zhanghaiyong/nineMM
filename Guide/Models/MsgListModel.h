//
//  MsgListModel.h
//  Guide
//
//  Created by 张海勇 on 16/8/2.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgListModel : NSObject
@property (nonatomic,strong)NSString *createDate;
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *readFlag;
@property (nonatomic,strong)NSString *summary;
@property (nonatomic,strong)NSString *title;

@end
