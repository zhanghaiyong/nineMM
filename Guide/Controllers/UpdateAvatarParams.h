//
//  UpdateAvatarParams.h
//  Guide
//
//  Created by 张海勇 on 16/8/12.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BaseParams.h"

@interface UpdateAvatarParams : BaseParams

@property (nonatomic,strong)NSString *category;
@property (nonatomic,strong)NSString *fileTitle;
@property (nonatomic,strong)NSString *fileIntro;
@property (nonatomic,strong)NSData   *file;

@end
