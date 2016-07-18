//
//  sureOrderCell2.h
//  Guide
//
//  Created by 张海勇 on 16/7/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

typedef void(^sureOrderCell2Block)(NSString *coinStatus);

#import <UIKit/UIKit.h>

@interface sureOrderCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (nonatomic,copy)sureOrderCell2Block block;

- (void)choseCoinPay:(sureOrderCell2Block)block;

@end
