//
//  ProDetailCell.h
//  Guide
//
//  Created by 张海勇 on 16/6/21.
//  Copyright © 2016年 ksm. All rights reserved.
//

typedef void(^ProDetailCell2Block)(NSInteger flag);
typedef void(^toUserSourceVC)(void);
#import <UIKit/UIKit.h>

@interface ProDetailCell : UITableViewCell
@property (nonatomic,copy)ProDetailCell2Block block;
@property (nonatomic,copy)toUserSourceVC toUserSurBlock;

- (IBAction)typeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *lineView;

- (void)proDetailTypeChange:(ProDetailCell2Block)block;
- (void)toUserSource:(toUserSourceVC)block;

@property (nonatomic,assign)NSInteger lineIndex;

@end
