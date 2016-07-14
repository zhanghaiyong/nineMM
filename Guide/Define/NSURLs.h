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
