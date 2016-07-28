#ifndef NSURLs_h
#define NSURLs_h

//http://9mama.top:8080
//http://101.200.131.198:8090/promot
#define  BaseURLString (@"http://9mama.top:8080")
#define  BaseImageURL  (@"http://9mama.top:8080/dimg/")
#define HTMLURL (@"http://9mama.top:8080/product/mobile/")

#endif /* NSURLs_h */

//获取sessionID
#define KGetSessionID [BaseURLString stringByAppendingString:@"/gw?cmd=hello"]

//用户登录
#define KLogin [BaseURLString stringByAppendingString:@"/gw?cmd=memberLogin"]


//首页上面
#define KHomePageStatic [BaseURLString stringByAppendingString:@"/gw?cmd=appQueryIndexStaticContent"]

// 首页商品列表
#define KHomePageProcudeList [BaseURLString stringByAppendingString:@"/gw?cmd=appQueryProductList"]

//商品详情
#define KProduceDetail [BaseURLString stringByAppendingString:@"/gw?cmd=appProductDetail"]


//获取资源分类
#define KGetProductCategoryTree [BaseURLString stringByAppendingString:@"/gw?cmd=getProductCategoryTree"]


//获取区域树
#define KGetAreasTreeJson [BaseURLString stringByAppendingString:@"/gw?cmd=getAreasTreeJson"]

//个人中心
#define KPersionCenter [BaseURLString stringByAppendingString:@"/gw?cmd=appMemberCenterIndex"]

//获取登录用户全部酒币余额
#define KGetLoginMemberCoinBalance [BaseURLString stringByAppendingString:@"/gw?cmd=getLoginMemberCoinBalance"]

//APP可见酒币套餐列表
#define KCoinRechargePackageList [BaseURLString stringByAppendingString:@"/gw?cmd=getAppCoinRechargePackageList"]

//计算酒币充值套餐人民币与酒币的换算
#define KRMBtoCoins [BaseURLString stringByAppendingString:@"/gw?cmd=calculateCoinPackageRecharge"]

//app发起酒币套餐充值
#define KInitiatePackageCoinRecharge [BaseURLString stringByAppendingString:@"/gw?cmd=appInitiatePackageCoinRecharge"]

//获取登录用户账户明细
#define KCoinsDetail [BaseURLString stringByAppendingString:@"/gw?cmd=getLoginMemberCoinAccountLog"]

//订单列表
#define KOrderList [BaseURLString stringByAppendingString:@"/gw?cmd=appOrderHistory"]

//订单详情
#define KAppOrderDetail [BaseURLString stringByAppendingString:@"/gw?cmd=appOrderDetail"]

//获取用户可选酒品列表
#define KUserSource [BaseURLString stringByAppendingString:@"/gw?cmd=appGetMemberWineList"]

//获取商品区域ID列表
#define KGetProductAreaIds [BaseURLString stringByAppendingString:@"/gw?cmd=getProductAreaIds"]

//检索资源商品所绑定门店
#define KSearchProductStores [BaseURLString stringByAppendingString:@"/gw?cmd=searchProductStores"]


//根据门店或区域选择计算资源商品价格
#define KGetProductPriceByStoreSelection [BaseURLString stringByAppendingString:@"/gw?cmd=getProductPriceByStoreSelection"]


//下单
#define KAppSubOrder [BaseURLString stringByAppendingString:@"/gw?cmd=appSubOrder"]


#pragma mark LinkAction-----------------
//根据特征查找商品列表
#define appQueryProductListByFeature [BaseURLString stringByAppendingString:@"/gw?cmd=appQueryProductListByFeature"]

