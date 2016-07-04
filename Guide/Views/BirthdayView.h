#import <UIKit/UIKit.h>

@protocol BirthdayViewDelegate <NSObject>

- (void)selectedBirthday:(NSString *)birthdayString;

@end

@interface BirthdayView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,assign)id<BirthdayViewDelegate>delegate;



@end
