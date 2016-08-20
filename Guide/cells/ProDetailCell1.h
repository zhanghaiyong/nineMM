#import <UIKit/UIKit.h>
#import "ZHYBannerView.h"
@interface ProDetailCell1 : UITableViewCell

/**
 *  顶部的banner
 */
@property (weak, nonatomic) IBOutlet ZHYBannerView *Banner;
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/**
 *  库存：2件
 */
@property (weak, nonatomic) IBOutlet UILabel *termLabel;
/**
 *  限时优惠，购买立省1000酒币
 */
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PriceLending;

@end
