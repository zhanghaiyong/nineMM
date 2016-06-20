//
//  BirthdayView.h
//  Guide
//
//  Created by ksm on 16/4/12.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BirthdayViewDelegate <NSObject>

- (void)selectedBirthday:(NSString *)birthdayString;

@end

@interface BirthdayView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,assign)id<BirthdayViewDelegate>delegate;



@end
