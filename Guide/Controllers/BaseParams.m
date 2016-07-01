//
//  BaseParams.m
//  Guide
//
//  Created by 张海勇 on 16/7/1.
//  Copyright © 2016年 ksm. All rights reserved.
//

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
