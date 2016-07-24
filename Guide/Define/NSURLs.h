#ifndef NSURLs_h
#define NSURLs_h

//http://9mama.top:8080
//http://101.200.131.198:8090/promot
#define  BaseURLString (@"http://101.200.131.198:8090/promot/gw?cmd=")
#define  BaseImageURL  (@"http://9mama.top:8080/dimg/")
#define HTMLURL (@"http://9mama.top:8080/goods/mobile/")

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

//获取登录用户全部酒币余额
#define KGetLoginMemberCoinBalance [BaseURLString stringByAppendingString:@"getLoginMemberCoinBalance"]

//APP可见酒币套餐列表
#define KCoinRechargePackageList [BaseURLString stringByAppendingString:@"getAppCoinRechargePackageList"]

//计算酒币充值套餐人民币与酒币的换算
#define KRMBtoCoins [BaseURLString stringByAppendingString:@"calculateCoinPackageRecharge"]

//app发起酒币套餐充值
#define KInitiatePackageCoinRecharge [BaseURLString stringByAppendingString:@"appInitiatePackageCoinRecharge"]

//获取登录用户账户明细
#define KCoinsDetail [BaseURLString stringByAppendingString:@"getLoginMemberCoinAccountLog"]

//订单列表
#define KOrderList [BaseURLString stringByAppendingString:@"appOrderHistory"]

//订单详情
#define KAppOrderDetail [BaseURLString stringByAppendingString:@"appOrderDetail"]

//获取用户可选酒品列表
#define KUserSource [BaseURLString stringByAppendingString:@"appGetMemberWineList"]

//获取商品区域ID列表
#define KGetProductAreaIds [BaseURLString stringByAppendingString:@"getProductAreaIds"]

//检索资源商品所绑定门店
#define KSearchProductStores [BaseURLString stringByAppendingString:@"searchProductStores"]


//根据门店或区域选择计算资源商品价格
#define KGetProductPriceByStoreSelection [BaseURLString stringByAppendingString:@"getProductPriceByStoreSelection"]


//下单
#define KAppSubOrder [BaseURLString stringByAppendingString:@"appSubOrder"]


#pragma mark LinkAction-----------------
//根据特征查找商品列表
#define appQueryProductListByFeature [BaseURLString stringByAppendingString:@"appQueryProductListByFeature"]

