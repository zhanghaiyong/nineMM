//
//  CategoryList.h
//  UniClubber
//
//  Created by 张海勇 on 16/1/19.
//  Copyright © 2016年 张海勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryListDelegate <NSObject>

- (void)closeTableV;

@end

@interface CategoryList : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)CGFloat arrowX;

@property (nonatomic,assign)id<CategoryListDelegate>delegate;
- (id)initWithFrame:(CGRect)frame;
@end
