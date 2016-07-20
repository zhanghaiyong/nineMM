#import <UIKit/UIKit.h>

@protocol BirthdayViewDelegate <NSObject>

- (void)selectedYear:(NSString *)year month:(NSString *)month;

@end

@interface BirthdayView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,assign)id<BirthdayViewDelegate>delegate;



@end
