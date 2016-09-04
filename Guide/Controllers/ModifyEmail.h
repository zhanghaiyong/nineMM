
#import "BaseViewController.h"

typedef void(^modifiedEmailBlock)(NSString *modifiedString,NSString *type);

@interface ModifyEmail : BaseViewController

@property (nonatomic,copy)modifiedEmailBlock block;

- (void)returnModifiedEmail:(modifiedEmailBlock)block;

@end
