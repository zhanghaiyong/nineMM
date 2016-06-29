//
//  SourceListViewController.m
//  Guide
//
//  Created by 张海勇 on 16/6/28.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "SourceListViewController.h"
#import "SourceListCell.h"
#import "SourceListHead.h"
@interface SourceListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SourceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"资源清单";
    self.tableView.backgroundColor = backgroudColor;
}

#pragma mark UITableView Delegate && DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SourceListHead *sourceListHead = [[[NSBundle mainBundle]loadNibNamed:@"SourceListHead" owner:self options:nil]lastObject];
    sourceListHead.frame = CGRectMake(0, 0, self.tableView.width, 30);
    return sourceListHead;

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
