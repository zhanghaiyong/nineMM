#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDate (Tools)

//计算自然日
- (long)naturalDaysSinceDate:(NSDate *)date;

//转换为 yyyy-MM-dd
- (NSString *)toYMDString;
//转换为 yyyyMMdd
- (NSString *)toYMD1String;
//转换为 yyyy/MM/dd
- (NSString *)toYMD2String;
//转换为 yyyy年MM月dd日
- (NSString *)toYMD3String;

//转换为 yyyy-MM
- (NSString *)toYMString;
//转换为 yyyy/MM
- (NSString *)toYM2String;
//转换为 yyyy年MM月
- (NSString *)toYM3String;

//转换为 MM-dd
- (NSString *)toMDString;
//转换为 MM/dd
- (NSString *)toMD2String;
//转换为 MM月dd日
- (NSString *)toMD3String;

//转换为 HH:SS
- (NSString *)toHSString;

/*距离当前的时间间隔描述*/
- (NSString *)toTimeDescription;

@end
