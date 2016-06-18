//
//  PersonalViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/30.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "PersonalViewController.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.alpha = 0;

    
}

#pragma mark UITableViewDelegate&&DataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 1;
//}



@end
