#import "MyCoinsController.h"
#import "TitleView.h"
@interface MyCoinsController ()

@end

@implementation MyCoinsController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的酒币";
    //头部
    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    titleView.normalColor = lever2Color;
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.selectedColor = specialRed;
    titleView.titleArray = @[@"全部",@"金币",@"绿币",@"黑币",@"红币",@"蓝币"];
    
    [titleView TitleViewCallBack:^(NSInteger btnTag) {
        
    }];
    
    self.tableView.tableHeaderView = titleView;
    
}


#pragma mark UITableView Delegate &&DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}
@end
