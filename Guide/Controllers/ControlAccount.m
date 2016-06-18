//
//  ControlAccount.m
//  Guide
//
//  Created by 张海勇 on 16/6/18.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ControlAccount.h"
#import "NavigationBarView.h"
@interface ControlAccount ()

@end

@implementation ControlAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavigationBarView *navigationBarView = [[[NSBundle mainBundle] loadNibNamed:@"NavigationBarView" owner:self options:nil] lastObject];
    navigationBarView.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
    self.navigationItem.titleView = navigationBarView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
