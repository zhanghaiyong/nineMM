//
//  PersonalViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/30.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "PersonalViewController.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableViewCell *cell1;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell2;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell3;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell4;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.frame=CGRectMake(0,0,self.view.width,-44);
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark UITableViewDelegate&&DataSource

@end
