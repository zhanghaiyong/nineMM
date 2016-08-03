#import "BaseViewController.h"
#import "MainProduceModel.h"
#import "ProPriceByStoreParams.h"
@interface SureOrdersViewController : BaseViewController


@property (nonatomic,strong)NSString *produceId;
@property (nonatomic,strong)NSArray *userSourceArr;
@property (nonatomic,strong)NSString *proPrice;
@property (nonatomic,strong)ProPriceByStoreParams *proPriceByStoreParams;
@property (nonatomic,strong)NSArray *acceptableCoinTypes;
@end
