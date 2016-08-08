//
//  DatePickerViewController.m
//  text
//
//  Created by ksm on 16/3/16.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "DatePickerView.h"

@interface DatePickerView ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation DatePickerView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
       self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];

    }
    return self;
}

-(void)setNowDate:(NSDate *)nowDate {

    _nowDate = nowDate;
    self.datePicker.date = nowDate;
}

-(void)setMinDate:(NSDate *)minDate {

    _minDate = minDate;
    self.datePicker.minimumDate = minDate;
}

- (void)setMaxDate:(NSDate *)maxDate {

    _maxDate = maxDate;
    self.datePicker.maximumDate = maxDate;
}

- (IBAction)clickSureBtn:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(selectedDate:btnTag:)]) {
        // 获取用户通过UIDatePicker设置的日期和时间
        NSDate *selected = [self.datePicker date];
        
        NSTimeZone *timeZone=[NSTimeZone systemTimeZone];
        NSInteger seconds=[timeZone secondsFromGMTForDate:selected];
        NSDate *newDate=[selected dateByAddingTimeInterval:seconds];
        [self.delegate selectedDate:newDate btnTag:self.tag];
    }
    
    if ([self.delegate respondsToSelector:@selector(clearView)]) {
        
        [self.delegate clearView];
    }
}


@end
