//
//  BaseViewController.h
//  Guide
//
//  Created by ksm on 16/4/7.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  用图片设置navigationBar的title
 */
- (void)setNavigationTitleImage:(NSString *)imageName;
/**
 *  用图片设置左边BarButton
 */
- (void)setNavigationLeft:(NSString *)imageName;
/**
 *  用图片设置右边的barButton
 */
- (void)setNavigationRight:(NSString *)imageName;
/**
 *  用字符串设置右边barButton
 */
- (void)setNavigationRightTitle:(NSString *)title;
/**
 *  用字符串设置左边barButton
 */
- (void)setNavigationLeftTitle:(NSString *)title;
/**
 *  左边barButton的响应事件
 */
- (void)doBack:(UIButton *)sender;
/**
 *  右边barButton响应事件
 */
- (void)doRight:(UIButton *)sender;
@end
