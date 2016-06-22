//
//  PersonalViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/30.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "PersonalViewController.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;

    self.edgesForExtendedLayout = UIRectEdgeNone;
        self.tableView.frame = CGRectMake(0, -20, SCREEN_WIDTH, self.tableView.height);
    self.automaticallyAdjustsScrollViewInsets = NO;
}


#pragma mark UITableViewDelegate&&DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}
@end
