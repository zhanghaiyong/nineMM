#import <Foundation/Foundation.h>
#import <SVProgressHUD.h>

@interface HUDConfig : NSObject

+(HUDConfig *)shareHUD;

- (void)Tips:(NSString *)tips delay:(NSTimeInterval)second;

- (void)SuccessHUD:(NSString *)tips delay:(NSTimeInterval)second;

- (void)ErrorHUD:(NSString *)tips delay:(NSTimeInterval)second;

- (void)LoadHUD:(NSString *)tips delay:(NSTimeInterval)second;

- (void)alwaysShow;

- (void)dismiss;
@end
