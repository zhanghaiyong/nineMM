//
//  ClassifyDetailHead.h
//  Guide
//
//  Created by 张海勇 on 16/5/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassifyDetailHeadDelegate <NSObject>

- (void)searchterm:(NSInteger)buttonTag;

@end

@interface ClassifyDetailHead : UIView

@property (nonatomic,assign)id<ClassifyDetailHeadDelegate>delegate;

@end
