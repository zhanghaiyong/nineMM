//
//  RecommendView.h
//  Guide
//
//  Created by 张海勇 on 16/5/26.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendView : UIView
//图片名字
@property (nonatomic,strong)NSString *imageName;
//产品名字
@property (nonatomic,strong)NSString *produceName;
//现价
@property (nonatomic,strong)NSString *nowPrice;
//原价
@property (nonatomic,strong)NSString *originalPirce;
@end
