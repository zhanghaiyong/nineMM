
#import "ClassifyTerm2.h"

@interface ClassifyTerm2 () {
    
    NSDate   *startDate;
    NSDate   *endDate;
    DatePickerView *dateP;
}



@end

@implementation ClassifyTerm2

//确定日期
- (IBAction)sureDateAction:(id)sender {
    
    if ([self.startDateLabel.text isEqualToString:@"开始时间"]) {
        
        [[HUDConfig shareHUD]Tips:@"请选择开始时间" delay:DELAY];
        return;
    }
    
    if ([self.endDateLabel.text isEqualToString:@"结束时间"]) {
        
        [[HUDConfig shareHUD]Tips:@"请选择结束时间" delay:DELAY];
        return;
    }
        
    if ([self.delegate respondsToSelector:@selector(classsifyTrem2Start:end:)]) {
        
        [self.delegate classsifyTrem2Start:self.startDateLabel.text end:self.endDateLabel.text];
    }
}

- (IBAction)showDatePicker:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    dateP = [[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:nil] lastObject];
    dateP.frame = self.bounds;
    //开始按钮
    if (button.tag == 100) {
        
        if (endDate) {
            
            dateP.maxDate = endDate;
            
        }else {
        
            dateP.nowDate = [NSDate date];
        }
        
    }else {
    
        if (startDate) {
            
            dateP.minDate = startDate;
            
        }else {
        
            dateP.nowDate = [NSDate date];
        }
        
    }
        dateP.delegate = self;
        dateP.tag = button.tag;
        [self addSubview:dateP];
    
}

#pragma mark DatePickerViewDelegate
- (void)selectedDate:(NSDate *)date btnTag:(NSInteger)btnTag{

    switch (btnTag) {
        case 100:
            
            startDate = date;
            
            self.startDateLabel.text = [date toYMDString];
            
            break;
        case 101:
            
            endDate = date;
            self.endDateLabel.text = [date toYMDString];
            
            break;
            
        default:
            break;
    }
    
    NSString *dateStr = [date toYMDString];
    NSLog(@"%@  %@",dateStr,date);
}

- (void)clearView {

    [dateP removeFromSuperview];
    dateP = nil;
}

#pragma mark UITextField
- (void)textFieldDidEndEditing:(UITextField *)textField {

//    if (textField == self.startDayLabel) {
//        
//        if (self.endDayLabel.text.length > 0) {
//            
//            //开始时间必须小于结束时间
//            if ([self.startDayLabel.text integerValue] > [self.endDayLabel.text integerValue]) {
//                [[HUDConfig shareHUD] ErrorHUD:@"开始时间必须小于结束时间" delay:DELAY];
//                self.startDayLabel.text = @"";
//            }
//        }
//        
//        //输入的数字必需小于本月天数
//        if ([self.startDayLabel.text integerValue] > dayCount || [self.startDayLabel.text integerValue]< 0) {
//            [[HUDConfig shareHUD] ErrorHUD:@"输入的数字必须介于本月天数之间" delay:DELAY];
//            self.startDayLabel.text = @"";
//        }
//        
//    }else {
//        
//        if (self.startDayLabel.text.length > 0) {
//            
//            //结束时间必须大于开始时间
//            if ([self.endDayLabel.text integerValue] < [self.startDayLabel.text integerValue]) {
//                [[HUDConfig shareHUD] ErrorHUD:@"结束时间必须大于开始时间" delay:DELAY];
//                self.endDayLabel.text = @"";
//            }
//        }
//        
//        //输入的数字必需小于本月天数
//        if ([self.endDayLabel.text integerValue] > dayCount || [self.endDayLabel.text integerValue]< 0) {
//            [[HUDConfig shareHUD] ErrorHUD:@"输入的数字必须介于本月天数之间" delay:DELAY];
//            self.endDayLabel.text = @"";
//        }
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if ([self.delegate respondsToSelector:@selector(closeTerm2View)]) {
        
        [self.delegate closeTerm2View];
    }
    
}

@end
