//
//  ClassifyDetailViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ClassifyDetailViewController.h"
#import "ClassifyDetailHead.h"
#import "ClassifyDetailCell.h"
#import "ClassifyDetailSearchView.h"
#import "ProduceDetailViewController.h"
@interface ClassifyDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ClassifyDetailHeadDelegate>
{
  UITableView *classifyDetailTab;
}
@end

@implementation ClassifyDetailViewController

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

//- (void)viewWillDisappear:(BOOL)animated {
//    
//    [super viewWillDisappear:animated];
//    self.hidesBottomBarWhenPushed = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initTableViews];
}

- (void)initTableViews {

    ClassifyDetailHead *headView = [[[NSBundle mainBundle] loadNibNamed:@"ClassifyDetailHead" owner:self options:nil] lastObject];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    headView.delegate = self;
    
    classifyDetailTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    classifyDetailTab.delegate = self;
    classifyDetailTab.dataSource = self;
    classifyDetailTab.separatorColor = [UIColor clearColor];
    classifyDetailTab.tableHeaderView = headView;
    [self.view addSubview:classifyDetailTab];

}

#pragma mark UITableViewDelegate&&dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identtifier = @"cell";
    ClassifyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identtifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ClassifyDetailCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
    [self.navigationController pushViewController:produceDetail animated:YES];
}

#pragma mark ClassifyDetailHeadDelegate
-(void)searchterm:(NSInteger)buttonTag {

    switch (buttonTag) {
        case 1000:
            
            break;
        case 1001:
            
            break;
        case 1002:{
        
           __block ClassifyDetailSearchView *searchView = [[[NSBundle mainBundle] loadNibNamed:@"ClassifyDetailSearchView" owner:self options:nil] lastObject];
            [searchView callBack:^(BOOL isMove) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    searchView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
                }completion:^(BOOL finished) {
                    [searchView removeFromSuperview];
                    searchView = nil;
                }];
            }];
            searchView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
            searchView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
            [self.view addSubview:searchView];
            [UIView animateWithDuration:0.3 animations:^{
                
                searchView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
            }];
        }
            break;
            
        default:
            break;
    }
}



@end
