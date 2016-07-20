//
//  ClassifyTerm2.m
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ClassifyTerm2.h"

@interface ClassifyTerm2 ()
{
    
    NSString *yearString;
    NSString *monthString;
    NSInteger dayCount;
}

@property (nonatomic,strong)BirthdayView *birthdayView;

@end

@implementation ClassifyTerm2

-(void)awakeFromNib {

    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    yearString = [NSString stringWithFormat:@"%ld",[dateComponent year]];
    monthString = [NSString stringWithFormat:@"%ld",[dateComponent month]];
    dayCount = [Uitils dayCountWithYear:[dateComponent year] month:[dateComponent month]];
    [self.dateButton setTitle:[NSString stringWithFormat:@"%@年%@月",yearString,monthString] forState:UIControlStateNormal];
    
    self.startDayLabel.delegate = self;
    self.endDayLabel.delegate = self;
}


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
    
    if ([self.delegate respondsToSelector:@selector(classsifyTrem2Start:end:)]) {
    
        NSDate *start    = [[NSString stringWithFormat:@"%@-%@-%ld",yearString,monthString,[self.startDayLabel.text integerValue]] dateWithFormate:@"yyyy-MM-dd"];
        NSDate *end      = [[NSString stringWithFormat:@"%@-%@-%ld",yearString,monthString,[self.endDayLabel.text integerValue]] dateWithFormate:@"yyyy-MM-dd"];
        NSString *startS = [start toYMDString];
        NSString *endS   = [end toYMDString];
        FxLog(@"%@ ....%@",startS,endS);
        
        [self.delegate classsifyTrem2Start:startS end:endS];
        
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

#pragma mark BirthdayViewDelegate
- (void)selectedYear:(NSString *)year month:(NSString *)month {

    [_birthdayView removeFromSuperview];
    _birthdayView = nil;
    
    yearString = year;
    monthString = month;
    
    dayCount = [Uitils dayCountWithYear:[year integerValue] month:[month integerValue]];
    
    [self.dateButton setTitle:[NSString stringWithFormat:@"%@年%@月",year,month] forState:UIControlStateNormal];
    
}


#pragma mark UITextField
- (void)textFieldDidEndEditing:(UITextField *)textField {

    if (textField == self.startDayLabel) {
        
        if (self.endDayLabel.text.length > 0) {
            
            //开始时间必须小于结束时间
            if ([self.startDayLabel.text integerValue] > [self.endDayLabel.text integerValue]) {
                [[HUDConfig shareHUD] ErrorHUD:@"开始时间必须小于结束时间" delay:DELAY];
                self.startDayLabel.text = @"";
            }
        }
        
        //输入的数字必需小于本月天数
        if ([self.startDayLabel.text integerValue] > dayCount || [self.startDayLabel.text integerValue]< 0) {
            [[HUDConfig shareHUD] ErrorHUD:@"输入的数字必须介于本月天数之间" delay:DELAY];
            self.startDayLabel.text = @"";
        }
        
    }else {
        
        if (self.startDayLabel.text.length > 0) {
            
            //结束时间必须大于开始时间
            if ([self.endDayLabel.text integerValue] < [self.startDayLabel.text integerValue]) {
                [[HUDConfig shareHUD] ErrorHUD:@"结束时间必须大于开始时间" delay:DELAY];
                self.endDayLabel.text = @"";
            }
        }
        
        //输入的数字必需小于本月天数
        if ([self.endDayLabel.text integerValue] > dayCount || [self.endDayLabel.text integerValue]< 0) {
            [[HUDConfig shareHUD] ErrorHUD:@"输入的数字必须介于本月天数之间" delay:DELAY];
            self.endDayLabel.text = @"";
        }
    }
}

@end
