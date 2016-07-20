//
//  ClassifyTerm2.h
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BirthdayView.h"

@protocol ClassifyTerm2Delegate <NSObject>

- (void)classsifyTrem2Start:(NSString *)start end:(NSString *)end;

@end

@interface ClassifyTerm2 : UIView<BirthdayViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UITextField *startDayLabel;
@property (weak, nonatomic) IBOutlet UITextField *endDayLabel;

@property (nonatomic,assign)id<ClassifyTerm2Delegate>delegate;

@end
