//
//  ClassifyTerm2.m
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ClassifyTerm2.h"

@interface ClassifyTerm2 ()

@property (nonatomic,strong)BirthdayView *birthdayView;

@end

@implementation ClassifyTerm2

-(BirthdayView *)birthdayView {

    if (_birthdayView == nil) {
        
        BirthdayView *birthdayView = [[[NSBundle mainBundle] loadNibNamed:@"BirthdayView" owner:self options:nil] lastObject];
        birthdayView.delegate = self;
        birthdayView.frame = CGRectMake(0, self.height-250, self.width, 250);
        _birthdayView = birthdayView;
        
    }
    return _birthdayView;
}

//确定日期
- (IBAction)sureDateAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(classsifyTrem2SureData:)]) {
        
        [self.delegate classsifyTrem2SureData:@"dsfsd"];
    }
    
}


//显示年月选择器
- (IBAction)TimeSelector:(id)sender {
    
    if (_birthdayView == nil) {
        
        [self addSubview:self.birthdayView];
    }else {
    
        [_birthdayView removeFromSuperview];
        _birthdayView = nil;
    }
}

- (void)selectedBirthday:(NSString *)birthdayString {

    [_birthdayView removeFromSuperview];
    _birthdayView = nil;
    
    [self.dateButton setTitle:birthdayString forState:UIControlStateNormal];
    
}

@end
