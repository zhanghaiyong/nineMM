//
//  FirstRegisterViewController.m
//  Guide
//
//  Created by ksm on 16/4/7.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "FirstRegisterViewController.h"

@interface FirstRegisterViewController ()

@end

@implementation FirstRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"完善资料（1/3）";
    self.view.backgroundColor = backgroudColor;
    self.tableView.backgroundColor = backgroudColor;
    
    
}

#pragma mark UITablrViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 0) {
        return 5;
    }
    return 0.0;
}


@end
