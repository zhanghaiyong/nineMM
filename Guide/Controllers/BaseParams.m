#import "BaseParams.h"

@implementation BaseParams

- (NSString *)sessionId {
    
    if ([Uitils getUserDefaultsForKey:TOKEN]) {
        _sessionId = [Uitils getUserDefaultsForKey:TOKEN];
    }
    
    KSMLog(@"baseParams = %@",_sessionId);
    return _sessionId;
}

@end
