#import <UIKit/UIKit.h>

typedef void(^MethodBagCellBlock)(NSString *count,NSString *add_reduce);

typedef void(^toDetailBlock)(void);

@interface MethodBagCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *isSelected;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedBtnWidth;

@property (weak, nonatomic) IBOutlet UILabel *produceName;

@property (weak, nonatomic) IBOutlet UILabel *price;
//@property (weak, nonatomic) IBOutlet UIButton *addButton;
//@property (weak, nonatomic) IBOutlet UIButton *reduceButton;
//@property (weak, nonatomic) IBOutlet UILabel *count;

@property (nonatomic,copy)MethodBagCellBlock block;
@property (nonatomic,copy)toDetailBlock toDetailblock;

- (void)repeatCount:(MethodBagCellBlock)block;
- (void)toDetailAction:(toDetailBlock)block;

@end
