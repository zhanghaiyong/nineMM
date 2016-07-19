#import "BaseViewController.h"
#import "MainProduceModel.h"
#import "ProPriceByStoreParams.h"
@interface SureOrdersViewController : BaseViewController


@property (nonatomic,strong)MainProduceModel *produceModel;
@property (nonatomic,strong)NSArray *userSourceArr;
@property (nonatomic,strong)NSString *proPrice;
@property (nonatomic,strong)ProPriceByStoreParams *proPriceByStoreParams;

@end
