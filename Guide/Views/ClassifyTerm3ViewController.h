//
//  ClassifyTerm3ViewController.h
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainProduceModel.h"
@protocol Term3Delegate <NSObject>

- (void)areaIdOrStoresId:(NSArray *)model type:(NSString *)type;

@end

@interface ClassifyTerm3ViewController : UIViewController

@property (nonatomic,strong)NSString *produceId;

@property (nonatomic,assign)id<Term3Delegate>delegate;

@end
