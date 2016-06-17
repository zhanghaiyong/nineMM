//
//  ProduceOfCollectHead.h
//  Guide
//
//  Created by 张海勇 on 16/5/27.
//  Copyright © 2016年 ksm. All rights reserved.
//
typedef void(^ProduceOfCollectHeadBlock)(NSInteger buttonTag);
#import <UIKit/UIKit.h>

@interface ProduceOfCollectHead : UIView

@property (nonatomic,copy)ProduceOfCollectHeadBlock callBlock;

- (void)ProduceOfCollectHeadBack:(ProduceOfCollectHeadBlock)block;

@end
