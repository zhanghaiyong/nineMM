//
//  SourceListViewController.m
//  Guide
//
//  Created by 张海勇 on 16/6/28.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "SourceListViewController.h"
#import "SourceListCell.h"
@interface SourceListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SourceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"资源清单";
}

#pragma mark UITableView Delegate && DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ideitifier = @"cell";
    SourceListCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SourceListCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
