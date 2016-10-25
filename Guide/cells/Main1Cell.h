#import <UIKit/UIKit.h>
#import "ZHYBannerView.h"

typedef void(^MainCell1Block)(void);

@interface Main1Cell : UITableViewCell

@property (nonatomic,copy)MainCell1Block block;

- (void)tapNewSourceAction:(MainCell1Block)block;

@end
