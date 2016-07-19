
//点击进入详情
typedef void(^toOrderDetail)(void);
//处理订单
typedef void(^dealOrder)(void);
#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderStatusButton;
@property (weak, nonatomic) IBOutlet UILabel *produceName;
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowPriceRed;
@property (weak, nonatomic) IBOutlet UILabel *oriPrice;
@property (weak, nonatomic) IBOutlet UIButton *appealButton;
@property (weak, nonatomic) IBOutlet UIButton *lookDetailButton;

@property (nonatomic,copy)toOrderDetail toOrderDetailBlock;
@property (nonatomic,copy)dealOrder dealOrderBlock;

- (void)tapToChechOrderDetail:(toOrderDetail)block;
- (void)tapDealOrder:(dealOrder)block;

@end
