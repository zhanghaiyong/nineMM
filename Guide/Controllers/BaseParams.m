#import "BaseParams.h"

@implementation BaseParams

- (NSString *)sessionId {
    
    if ([Uitils getUserDefaultsForKey:TOKEN]) {
        _sessionId = [Uitils getUserDefaultsForKey:TOKEN];
    }
    
    KSMLog(@"baseParams = %@",_sessionId);
    return _sessionId;
}

- (NSString *)clientVer {

    _clientVer = @"17010501";
    return _clientVer;
}

- (NSString *)termType {
    
    _termType = @"010101";
    return _termType;
}

@end
