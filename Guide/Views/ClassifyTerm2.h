//
//  ClassifyTerm2.h
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerView.h"

@protocol ClassifyTerm2Delegate <NSObject>

- (void)classsifyTrem2Start:(NSString *)start end:(NSString *)end;
- (void)closeTerm2View;

@end

@interface ClassifyTerm2 : UIView<DatePickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;


@property (nonatomic,assign)id<ClassifyTerm2Delegate>delegate;

@end
