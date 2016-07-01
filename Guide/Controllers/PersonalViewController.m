//
//  PersonalViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/30.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "PersonalViewController.h"
#import "ButtonView.h"
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,ButtonViewDeleage>

@end

@implementation PersonalViewController

- (void)awakeFromNib {

    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell1  = [self.tableView cellForRowAtIndexPath:indexPath1];
    
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:0 inSection:1];
    UITableViewCell *cell2  = [self.tableView cellForRowAtIndexPath:indexPath2];
    
    NSArray *images         = @[@"icon_guide_iphone",@"icon_me_iphone",@"icon_news_iphone",@"icon_order_iphone",@"icon_talk_iphone"];
    NSArray *titles         = @[@"全部订单",@"等待审核",@"已经取消",@"取消中",@"申述订单"];
    NSArray *iconNames      = @[@"金币",@"绿币",@"红币",@"蓝币",@"黑币"];
    
    for (int i = 0; i<5; i++) {
        
        //订单
        ButtonView *orderBV = (ButtonView *)[cell1.contentView viewWithTag:i+100];
        orderBV.delegate = self;
        orderBV.labelTitle = titles[i];
        orderBV.imageName  = images[i];
        
        //金币
        ButtonView *coinBV = (ButtonView *)[cell2.contentView viewWithTag:i+200];
        coinBV.delegate = self;
        coinBV.labelTitle = iconNames[i];
        coinBV.imageName  = @"icon_gender_selected_iphoe";
    }
}

//隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.frame = CGRectMake(0, -20, SCREEN_WIDTH, self.tableView.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark UITableViewDelegate&&DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

/**
 *  ButtonViewDeleage
 *
 *  @param aFlag buttonView的tag
 */
- (void)buttonViewTap:(NSInteger)aFlag {

    FxLog(@"ButtonViewTag = %ld",aFlag);
}

@end
