//
//  NewsModel.h
//  Guide
//
//  Created by 张海勇 on 16/7/14.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *imageId;
@property (nonatomic,strong)NSString *linkAction;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *subtitle;

@end
