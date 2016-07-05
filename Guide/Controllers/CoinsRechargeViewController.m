
// 酒币充值

#import "CoinsRechargeViewController.h"

@interface CoinsRechargeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CoinsRechargeViewController

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"酒币充值";
}

#pragma mark UITableViewDelegate&&UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 1) {
        
        return 40;
    }else if (section == 2) {
    
        return 0.1;
    }
    return 10;
}

@end
