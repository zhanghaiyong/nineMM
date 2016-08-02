//
//  MsgDetailViewController.m
//  Guide
//
//  Created by 张海勇 on 16/8/3.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MsgDetailViewController.h"
#import "MsgDetailParams.h"
@interface MsgDetailViewController ()

@end

@implementation MsgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMsgDetail];
}

- (void)loadMsgDetail {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    MsgDetailParams *params = [[MsgDetailParams alloc]init];
    params.id = self.ID;

    [KSMNetworkRequest postRequest:KNotificationContent params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"loadMsgDetail = %@",dataDic);
    
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
