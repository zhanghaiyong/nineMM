
#import "ClassifyTerm2.h"

@interface ClassifyTerm2 () {
    
    NSDate   *startDate;
    NSDate   *endDate;
    DatePickerView *dateP;
}



@end

@implementation ClassifyTerm2

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"zxvzx = %@%@",startDate,endDate);
    }
    return self;
}

//-(void)awakeFromNib {
//
//    NSDate *now = [NSDate date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
//    yearString = [NSString stringWithFormat:@"%ld",[dateComponent year]];
//    monthString = [NSString stringWithFormat:@"%ld",[dateComponent month]];
//    dayCount = [Uitils dayCountWithYear:[dateComponent year] month:[dateComponent month]];
//    [self.dateButton setTitle:[NSString stringWithFormat:@"%@年%@月",yearString,monthString] forState:UIControlStateNormal];
//    
//    self.startDayLabel.delegate = self;
//    self.endDayLabel.delegate = self;
//}

//确定日期
- (IBAction)sureDateAction:(id)sender {
    
//    if ([self.delegate respondsToSelector:@selector(classsifyTrem2Start:end:)]) {
//    
//        NSDate *start    = [[NSString stringWithFormat:@"%@-%@-%ld",yearString,monthString,[self.startDayLabel.text integerValue]] dateWithFormate:@"yyyy-MM-dd"];
//        NSDate *end      = [[NSString stringWithFormat:@"%@-%@-%ld",yearString,monthString,[self.endDayLabel.text integerValue]] dateWithFormate:@"yyyy-MM-dd"];
//        NSString *startS = [start toYMDString];
//        NSString *endS   = [end toYMDString];
//        FxLog(@"%@ ....%@",startS,endS);
//        
//        [self.delegate classsifyTrem2Start:startS end:endS];
//    }
}

- (IBAction)showDatePicker:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    dateP = [[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:nil] lastObject];
    dateP.frame = self.bounds;
    //开始按钮
    if (button.tag == 100) {
        
        if ([endDate isEqual:[NSNull null]]) {
            
            dateP.maxDate = endDate;
            
        }else {
        
            dateP.nowDate = [NSDate date];
        }
        
    }else {
    
        if (![startDate isEqual:[NSNull null]]) {
            
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
            
            self.startDateLabel.text = [date toYMDString];
            
            break;
        case 101:
            
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

////显示年月选择器
//- (IBAction)TimeSelector:(id)sender {
//    
//    if (_birthdayView == nil) {
//        
//        [self addSubview:self.birthdayView];
//    }else {
//    
//        [_birthdayView removeFromSuperview];
//        _birthdayView = nil;
//    }
//}
//
//#pragma mark BirthdayViewDelegate
//- (void)selectedYear:(NSString *)year month:(NSString *)month {
//
//    [_birthdayView removeFromSuperview];
//    _birthdayView = nil;
//    
//    yearString = year;
//    monthString = month;
//    
//    dayCount = [Uitils dayCountWithYear:[year integerValue] month:[month integerValue]];
//    
//    [self.dateButton setTitle:[NSString stringWithFormat:@"%@年%@月",year,month] forState:UIControlStateNormal];
//    
//}


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
