#ifndef NSURLs_h
#define NSURLs_h


#define  BaseURLString (@"http://101.200.131.198:8090/custwine/gw?cmd=")
#define  BaseImageURL  (@"http://101.200.131.198:8090/custwine/dimg/")

#endif /* NSURLs_h */

//获取sessionID
#define KGetSessionID [BaseURLString stringByAppendingString:@"hello"]

//首页上面
#define KHomePageStatic [BaseURLString stringByAppendingString:@"appQueryIndexStaticContent"]

//验证成功 首页商品列表
#define KHomePageProcudeList [BaseURLString stringByAppendingString:@"appQueryProductList"]
