#import "BaseViewController.h"

@protocol UserSourceDelegate <NSObject>

- (void)chosedUserSource:(NSArray *)array;

@end

@interface UserSourceViewController : BaseViewController

@property (nonatomic,assign)id<UserSourceDelegate>delegate;

//酒品可选择数据根据详情参数进行限制
@property (nonatomic,strong)NSString *itemsCount;
@property (nonatomic,strong)NSString *productId;

@end
