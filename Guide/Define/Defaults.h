#ifndef Defaults_h
#define Defaults_h


#endif /* Defaults_h */

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//边距
#define BORDER_VALUE 10

//圆角
#define CORNER_RADIUS 5


//#define RGBC(r,g,b)      [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

#define TintColor        RGB(255, 255, 255)
#define MainColor        RGB(215, 158, 9)

#define backgroudColor   RGB(244, 244, 244)  //f4f4f4
#define lever1Color      RGB(53, 53, 53)     //353535
#define lineColor        RGB(216, 216, 216)  //d8d8d8
#define riceRedColor      RGB(249, 70, 78)   //ea5858


#define lever1Font         [UIFont systemFontOfSize:17]
#define lever2Font         [UIFont systemFontOfSize:14]
#define lever3Font         [UIFont systemFontOfSize:12]
#define lever4Font         [UIFont systemFontOfSize:10]

#define ORDERTYPE1 @"全部订单"
#define ORDERTYPE2 @"待审核"
#define ORDERTYPE3 @"已取消"
#define ORDERTYPE4 @"执行中"
#define ORDERTYPE5 @"申诉订单"

#define MEUM_CELL_H 35



//#define LaunchImage (@"LaunchImage")
#define LaunchCaches  (@"LaunchCaches")
#define TOKEN         (@"SessionID")
#define CategoryTree  (@"CategoryTree")
#define ARESTREE      (@"AreasTree")
#define APPVERSION    (@"appVersion")
#define USERSOURCE    (@"userSource")
#define DELAY 2


#define queryGoodsFeature    (@"queryGoodsFeature")
#define openUri              (@"openUri")
#define showGoodsListByTag   (@"showGoodsListByTag")
#define openCoinRechargePage (@"openCoinRechargePage")



#if (DEBUG || TESTCASE)
#define FxLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define FxLog(format, ...)
#endif

// 日志输出宏
#define BASE_LOG(cls,sel) FxLog(@"%@-%@",NSStringFromClass(cls), NSStringFromSelector(sel))
#define BASE_ERROR_LOG(cls,sel,error) FxLog(@"ERROR:%@-%@-%@",NSStringFromClass(cls), NSStringFromSelector(sel), error)
#define BASE_INFO_LOG(cls,sel,info) FxLog(@"INFO:%@-%@-%@",NSStringFromClass(cls), NSStringFromSelector(sel), info)

// 日志输出函数
#if (DEBUG || TESTCASE)
#define BASE_LOG_FUN()         BASE_LOG([self class], _cmd)
//BASE_ERROR_FUN([error localizedDescription]);
#define BASE_ERROR_FUN(error)  BASE_ERROR_LOG([self class],_cmd,error)
//BASE_INFO_FUN(@"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信");
#define BASE_INFO_FUN(info)    BASE_INFO_LOG([self class],_cmd,info)
#else
#define BASE_LOG_FUN()
#define BASE_ERROR_FUN(error)
#define BASE_INFO_FUN(info)
#endif

#define kAppDelegate   ((AppDelegate *)[[UIApplication sharedApplication] delegate])


//#define DEBUG_MODE 1
//#if DEBUG_MODE
//#define DLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
//#else
//#define DLog( s, ... )
//#endif

