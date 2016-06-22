//
//  ProDetailCell2.h
//  Guide
//
//  Created by 张海勇 on 16/6/21.
//  Copyright © 2016年 ksm. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface ProDetailCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (nonatomic,assign)NSInteger scrollTag;


@end
