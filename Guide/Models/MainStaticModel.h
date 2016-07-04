#import <Foundation/Foundation.h>
#import "ButtonsModel.h"
#import "GoodsTypeModel.h"
#import "TopBannersModel.h"

@interface MainStaticModel : NSObject<MJKeyValue>

@property (nonatomic,strong)NSArray *buttons;
@property (nonatomic,strong)NSArray *goodsTypes;
@property (nonatomic,strong)NSArray *topBanners;
@end
