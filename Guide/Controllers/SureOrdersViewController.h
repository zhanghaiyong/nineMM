#import "BaseViewController.h"
#import "MainProduceModel.h"
#import "ProPriceByStoreParams.h"
@interface SureOrdersViewController : BaseViewController

@property (nonatomic,strong)NSArray *ProduceBag;

@property (nonatomic,strong)ProPriceByStoreParams *proPriceByStoreParams;
@property (nonatomic,strong)NSArray *acceptableCoinTypes;

/**
 *  商品名称
 */
@property (nonatomic,strong)NSString *fullName;
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



//套餐
//所有商品的资源  数组里面放 套餐商品所对应的资源
@property (nonatomic,strong)NSArray *allSource;
//所有区域或门店   套餐商品对应的区域或门店
@property (nonatomic,strong)NSArray *allStoreArea;
//门店或者区域  套餐里面商品对应的类型
@property (nonatomic,strong)NSArray *storeOrArea;
//套餐商品
@property (nonatomic,strong)NSArray *packageproduce;
//套餐id
@property (nonatomic,strong)NSString *packageId;

@end
