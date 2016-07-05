//
//  CoinsDetailViewCtrl.m
//  Guide
//
//  Created by 张海勇 on 16/7/5.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "CoinsDetailViewCtrl.h"
#import "CoinsDetailCell.h"
#import "SourceListHead.h"
@interface CoinsDetailViewCtrl ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CoinsDetailViewCtrl

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark UITableViewDelegate&&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SourceListHead *sourceListHead = [[[NSBundle mainBundle]loadNibNamed:@"SourceListHead" owner:self options:nil]lastObject];
    sourceListHead.frame = CGRectMake(0, 0, self.tableView.width, 30);

    sourceListHead.titleLabel.text = @"我的酒币";
    return sourceListHead;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    CoinsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CoinsDetailCell" owner:self options:nil] lastObject];
    }
    return cell;
}

@end
