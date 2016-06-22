//
//  MethodBagViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/28.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MethodBagViewController.h"
#import "MethodBagCell.h"
@interface MethodBagViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableV;

@end

@implementation MethodBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"方案包";
    
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
}

#pragma mark UITableViewDelegate&&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    static NSString *ideitifier = @"MethodBagCell";
//    MethodBagCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"MethodBagCell" owner:nil options:nil] lastObject];
//    }
    MethodBagCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MethodBagCell" owner:self options:nil] lastObject];
    cell.tag = 100+indexPath.row;
    return cell;
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.tableV.separatorInset = UIEdgeInsetsZero;
    self.tableV.layoutMargins = UIEdgeInsetsZero;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.tableV.separatorInset = UIEdgeInsetsZero;
    self.tableV.layoutMargins = UIEdgeInsetsZero;
}

@end
