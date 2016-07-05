#import <UIKit/UIKit.h>

@interface MethodBagCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *isSelected;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedBtnWidth;

@property (weak, nonatomic) IBOutlet UILabel *produceName;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *reduceButton;
@property (weak, nonatomic) IBOutlet UILabel *count;

@end
