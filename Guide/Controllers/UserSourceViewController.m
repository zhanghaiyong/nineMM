//
//  UserSourceViewController.m
//  Guide
//
//  Created by 张海勇 on 16/6/22.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "UserSourceViewController.h"
#import "UserSourceCell.h"
@interface UserSourceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark UITableView Delegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ideitifier = @"UserSourceCell";
    UserSourceCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserSourceCell" owner:nil options:nil] lastObject];
    }
    return cell;
}


@end
