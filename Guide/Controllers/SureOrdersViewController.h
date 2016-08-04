#import "BaseViewController.h"
#import "MainProduceModel.h"
#import "ProPriceByStoreParams.h"
@interface SureOrdersViewController : BaseViewController


/**
 *  商品id
 */
@property (nonatomic,strong)NSString *produceId;
/**
 *  酒品
 */
@property (nonatomic,strong)NSArray *userSourceArr;
/**
 *  商品价格
 */
@property (nonatomic,strong)NSString *proPrice;
@property (nonatomic,strong)ProPriceByStoreParams *proPriceByStoreParams;
@property (nonatomic,strong)NSArray *acceptableCoinTypes;

/**
 *  所有商品的资源
 */
@property (nonatomic,strong)NSArray *allSource;
/**
 *  所有区域或门店
 */
@property (nonatomic,strong)NSArray *allStoreArea;

//门店或者区域
@property (nonatomic,strong)NSArray *storeOrArea;

@property (nonatomic,strong)NSArray *packageproduce;

@property (nonatomic,strong)NSString *packageId;

@end
