#import "MainStaticModel.h"

@implementation MainStaticModel

//实现这个方法，就会自动吧数组中的字典转化成对应的模型
+ (NSDictionary *)objectClassInArray {
    
    return @{@"buttons":[ButtonsModel class],@"goodsTypes":[GoodsTypeModel class],@"topBanners":[TopBannersModel class]};
}


@end
