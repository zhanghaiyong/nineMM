//
//  sureOrderFoorView.h
//  Guide
//
//  Created by 张海勇 on 16/7/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

typedef void(^sureOrderFootBlock)(void);

#import <UIKit/UIKit.h>

@interface sureOrderFoorView : UIView
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@property (nonatomic,copy)sureOrderFootBlock block;

- (void)nowBuyProduce:(sureOrderFootBlock)block;

@end
