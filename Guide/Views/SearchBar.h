#import <UIKit/UIKit.h>

typedef void(^toMsgCenterBlock)(void);

@interface SearchBar : UIView
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIButton *msgFlagButton;
@property (nonatomic,copy)toMsgCenterBlock block;

- (void)connectTwoBlock:(toMsgCenterBlock)block;

@end
