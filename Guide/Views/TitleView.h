//
//  TitleView.h
//  Guide
//
//  Created by 张海勇 on 16/5/27.
//  Copyright © 2016年 ksm. All rights reserved.
//
typedef void(^TitleViewBlock)(NSInteger btnTag);
#import <UIKit/UIKit.h>

@interface TitleView : UIView

@property (nonatomic,strong)NSArray *titleArray;

@property (nonatomic,copy)TitleViewBlock callBlock;

- (void)TitleViewCallBack:(TitleViewBlock)block;

@end
