#import "BaseViewController.h"

@protocol UserSourceDelegate <NSObject>

- (void)chosedUserSource:(NSArray *)array;

@end

@interface UserSourceViewController : BaseViewController

@property (nonatomic,assign)id<UserSourceDelegate>delegate;


@end
