#ifndef NSURLs_h
#define NSURLs_h

//http://9mama.top:8080
//http://101.200.131.198:8090/promot
#define  BaseURLString (@"http://9mama.top:8080")

#endif /* NSURLs_h */

//上传头像
#define KUpdateAvatar [BaseURLString stringByAppendingString:@"/dimg/upload"]

//文章页
#define KArticleHtml [BaseURLString stringByAppendingString:@"/article/mobile"]


//版本更新
#define KVersion [BaseURLString stringByAppendingString:@"/update/ios"]

//更新登录用户的基础信息
#define KUpdateUserInfo [BaseURLString stringByAppendingString:@"/gw?cmd=updateLoginMemberInfo"]

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

//订单详情获取门店
#define KGetOrderShops [BaseURLString stringByAppendingString:@"/gw?cmd=appGetOrderItemShops"]

//获取商品区域ID列表
#define KGetProductAreaIds [BaseURLString stringByAppendingString:@"/gw?cmd=getProductAreaIds"]

//检索资源商品所绑定门店
#define KSearchProductStores [BaseURLString stringByAppendingString:@"/gw?cmd=searchProductStores"]

//根据门店或区域选择计算资源商品价格
#define KGetProductPriceByStoreSelection [BaseURLString stringByAppendingString:@"/gw?cmd=getProductPriceByStoreSelection"]

//下单
#define KAppSubOrder [BaseURLString stringByAppendingString:@"/gw?cmd=appSubOrder"]


//获取用户信息
#define KLoginMemberInfo [BaseURLString stringByAppendingString:@"/gw?cmd=getAdvresLoginMemberInfo"]

////查看登录用户的基础信息
//#define KLoginMemberInfo [BaseURLString stringByAppendingString:@"/gw?cmd=getLoginMemberInfo"]

//修改已登录用户密码
#define KUpdatePassword [BaseURLString stringByAppendingString:@"/gw?cmd=updateLoginMemberPassword"]

//消息中心
#define KNotificationCenter [BaseURLString stringByAppendingString:@"/gw?cmd=appNotificationCenter"]

//消息列表
#define KNotificationList [BaseURLString stringByAppendingString:@"/gw?cmd=appNotificationList"]

//消息详情
#define KNotificationContent [BaseURLString stringByAppendingString:@"/gw?cmd=appNotificationContent"]

//打包商品列表
#define KPackageList [BaseURLString stringByAppendingString:@"/gw?cmd=appAdvresPackagedProductList"]

//打包商品Banner
#define KArticleList [BaseURLString stringByAppendingString:@"/gw?cmd=appArticleList"]

//打包商品详情
#define KPackageDetail [BaseURLString stringByAppendingString:@"/gw?cmd=appAdvresPackagedProductDetail"]

//更新登录用户的基础信息
#define KModifyInfo [BaseURLString stringByAppendingString:@"/gw?cmd=updateLoginMemberInfo"]

//获取手机验证码
#define KValidCode [BaseURLString stringByAppendingString:@"/gw?cmd=getMobileValidCode"]

//通过手机验证码重置密码
#define KResetPwd [BaseURLString stringByAppendingString:@"/gw?cmd=resetPasswordByMobile"]

#pragma mark LinkAction-----------------
//根据特征查找商品列表
#define appQueryProductListByFeature [BaseURLString stringByAppendingString:@"/gw?cmd=appQueryProductListByFeature"]

