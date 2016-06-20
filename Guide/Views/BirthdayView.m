//
//  BirthdayView.m
//  Guide
//
//  Created by ksm on 16/4/12.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "BirthdayView.h"

@implementation BirthdayView {

    NSString *yearStr;
    NSString *monthStr;
    NSMutableArray *yearArr;
    NSMutableArray *monthArr;
    NSInteger  YearRow;
    NSInteger  MonthRow;
}

- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.4];
    monthArr = [NSMutableArray array];
    yearArr  = [NSMutableArray array];
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    
    //设置月份数据
    for (int i = 0; i<12; i++) {
        [monthArr addObject:[NSString stringWithFormat:@"%d月",i+1]];
        if (i+1 == month) {
            monthStr = [NSString stringWithFormat:@"%d月",i+1];
            MonthRow = i;
        }
        
    }
    //设置年份数据
    for (int i =0; i < 70; i++) {
        [yearArr addObject:[NSString stringWithFormat:@"%d年",i+1970]];
        if ((i+1970) == year) {
            yearStr = [NSString stringWithFormat:@"%d年",i+1970];
            YearRow = i;
        }
    }
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    [self.pickerView selectRow:YearRow inComponent:0 animated:YES];
    [self.pickerView selectRow:MonthRow inComponent:1 animated:YES];
//    [self.pickerView reloadAllComponents];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

        
    }
    return self;
}

#pragma mark UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (component == 0) {
        return yearArr.count;
        
    }else {
        
       return monthArr.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    if (component == 0) {
        
        return yearArr[row];
    }else
        return monthArr[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (component == 0) {
        yearStr = yearArr[row];
    }else {
    
        monthStr = monthArr[row];
    }
}



- (IBAction)cancleAction:(id)sender {
    
    [self removeFromSuperview];
}

- (IBAction)sureAction:(id)sender {
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",yearStr,monthStr]);
    if ([self.delegate respondsToSelector:@selector(selectedBirthday:)]) {
        
        [self.delegate selectedBirthday:[NSString stringWithFormat:@"%@%@",yearStr,monthStr]];
        [self removeFromSuperview];
    }
}


@end
