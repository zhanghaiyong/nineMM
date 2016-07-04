#import <UIKit/UIKit.h>

@protocol selectEDUDelegate <NSObject>

- (void)selectedEDU:(NSString *)eduString;

@end

@interface SelectEDU : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,assign)id<selectEDUDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@end
