#import "HUDConfig.h"

@implementation HUDConfig

+(HUDConfig *)shareHUD {

    static HUDConfig *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[HUDConfig alloc] init];
    });
    
    return hud;
}

- (void)Tips:(NSString *)tips delay:(NSTimeInterval)second {

        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showInfoWithStatus:tips];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:second];
}

- (void)SuccessHUD:(NSString *)tips delay:(NSTimeInterval)second {

    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showSuccessWithStatus:tips];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:second];
}

- (void)ErrorHUD:(NSString *)tips delay:(NSTimeInterval)second {
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showErrorWithStatus:tips];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:second];
}

- (void)LoadHUD:(NSString *)tips delay:(NSTimeInterval)second {

    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:tips];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:second];
}


- (void)alwaysShow {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
}

- (void)dismiss {

    [SVProgressHUD dismiss];
}


@end
