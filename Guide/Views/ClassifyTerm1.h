//
//  ClassifyTerm1.h
//  Guide
//
//  Created by 张海勇 on 16/7/3.
//  Copyright © 2016年 ksm. All rights reserved.
//

typedef void(^ClassifyTerm1Block)(NSString *qryCategoryId);

#import <UIKit/UIKit.h>

@interface ClassifyTerm1 : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray            *produceSource;
@property (nonatomic,copy  ) ClassifyTerm1Block block;


- (void)selectedCategoryId:(ClassifyTerm1Block)block;


@end
