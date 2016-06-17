//
//  PersonalViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/30.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "PersonalViewController.h"

@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.automaticallyAdjustsScrollViewInsets = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
#pragma mark UITAbleViewDelegate&&DataSource


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 1;
}



@end
