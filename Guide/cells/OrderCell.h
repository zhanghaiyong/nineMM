
//点击进入详情
typedef void(^toOrderDetail)(void);
//处理订单
typedef void(^dealOrder)(void);
#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailViewHeight;

@property (nonatomic,copy)toOrderDetail toOrderDetailBlock;
@property (nonatomic,copy)dealOrder dealOrderBlock;

- (void)tapToChechOrderDetail:(toOrderDetail)block;
- (void)tapDealOrder:(dealOrder)block;

@end
