
#import "BaseViewController.h"

typedef void(^modifiedEmailBlock)(NSString *email);

@interface ModifyEmail : BaseViewController

@property (nonatomic,assign)modifiedEmailBlock block;

- (void)returnModifiedEmail:(modifiedEmailBlock)block;

@end
