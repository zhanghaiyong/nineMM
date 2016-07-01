#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define IOS8_OR_LATER	(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)
#define IOS7_OR_LATER	(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
#define IOS6_OR_LATER	(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_5_1)
#define IOS5_OR_LATER	(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_4_3)
#define IOS4_OR_LATER	(NSFoundationVersionNumber > NSFoundationVersionNumber_iPhoneOS_3_2)
#define IOS3_OR_LATER	(NSFoundationVersionNumber > NSFoundationVersionNumber_iPhoneOS_2_2)

#else

#define IOS6_OR_LATER	(NO)
#define IOS5_OR_LATER	(NO)
#define IOS4_OR_LATER	(NO)
#define IOS3_OR_LATER	(NO)

#endif

@interface HYSystem : NSObject

+ (NSString *)osVersion;
+ (NSString *)appVersion;
+ (NSString *)appBuild;
+ (NSString *)appName;
+ (NSString *)appIdentifier;
+ (NSString *)deviceModel;
+ (NSString *)deviceUUID;

+ (CGFloat)statuBarHeight;
+ (CGFloat)navBarHeight;


+ (BOOL)isJailBroken		NS_AVAILABLE_IOS(4_0);
+ (NSString *)jailBreaker	NS_AVAILABLE_IOS(4_0);

+ (BOOL)isDevicePhone;
+ (BOOL)isDevicePad;

+ (BOOL)isPhone35;
+ (BOOL)isPhoneRetina35;
+ (BOOL)isPhoneRetina4;
+ (BOOL)isPhoneRetina6;
+ (BOOL)isPhoneRetina6Plus;
+ (BOOL)isPad;
+ (BOOL)isPadRetina;
+ (BOOL)isScreenSize:(CGSize)size;

//获得设备型号
+ (NSString *)getCurrentDeviceModel;

@end
