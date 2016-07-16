#ifndef NSURLs_h
#define NSURLs_h


#define  BaseURLString (@"http://101.200.131.198:8090/promot/gw?cmd=")
#define  BaseImageURL  (@"http://101.200.131.198:8090/promot/dimg/")

#endif /* NSURLs_h */

//获取sessionID
#define KGetSessionID [BaseURLString stringByAppendingString:@"hello"]

//用户登录
#define KLogin [BaseURLString stringByAppendingString:@"memberLogin"]


//首页上面
#define KHomePageStatic [BaseURLString stringByAppendingString:@"appQueryIndexStaticContent"]

// 首页商品列表
#define KHomePageProcudeList [BaseURLString stringByAppendingString:@"appQueryProductList"]

//商品详情
#define KProduceDetail [BaseURLString stringByAppendingString:@"appProductDetail"]


//获取资源分类
#define KGetProductCategoryTree [BaseURLString stringByAppendingString:@"getProductCategoryTree"]


//获取区域树
#define KGetAreasTreeJson [BaseURLString stringByAppendingString:@"getAreasTreeJson"]

//个人中心
#define KPersionCenter [BaseURLString stringByAppendingString:@"appMemberCenterIndex"]

//APP可见酒币套餐列表
#define KCoinRechargePackageList [BaseURLString stringByAppendingString:@"getAppCoinRechargePackageList"]


//计算酒币充值套餐人民币与酒币的换算
#define KRMBtoCoins [BaseURLString stringByAppendingString:@"calculateCoinPackageRecharge"]


//获取登录用户账户明细
#define KCoinsDetail [BaseURLString stringByAppendingString:@"getLoginMemberCoinAccountLog"]
