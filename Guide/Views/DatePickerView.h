//
//  DatePickerViewController.h
//  text
//
//  Created by ksm on 16/3/16.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

- (void)selectedDate:(NSDate *)date btnTag:(NSInteger)btnTag;
- (void)clearView;

@end

@interface DatePickerView : UIView

@property (nonatomic,strong)NSDate *nowDate;
@property (nonatomic,strong)NSDate *minDate;
@property (nonatomic,strong)NSDate *maxDate;

@property (nonatomic,assign)id<DatePickerViewDelegate>delegate;

@end
