//
//  ClassifyTerm1.h
//  Guide
//
//  Created by 张海勇 on 16/7/3.
//  Copyright © 2016年 ksm. All rights reserved.
//

typedef void(^ClassifyTerm1Block)(NSString *qryCategoryId);

#import <UIKit/UIKit.h>

@protocol ClassifyTerm1Delegate <NSObject>

- (void)closeClassifyTerm1;

@end

@interface ClassifyTerm1 : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray            *produceSource;
@property (nonatomic,copy  ) ClassifyTerm1Block block;
@property (nonatomic,assign)id<ClassifyTerm1Delegate>delegate;


- (void)selectedCategoryId:(ClassifyTerm1Block)block;


@end
