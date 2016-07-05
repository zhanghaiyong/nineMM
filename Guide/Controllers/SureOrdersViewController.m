#import "SureOrdersViewController.h"

@interface SureOrdersViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SureOrdersViewController

//- (void)viewWillAppear:(BOOL)animated {
//
//    [super viewWillAppear:animated];
//    
//    self.hidesBottomBarWhenPushed = YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//
//    [super viewWillDisappear:animated];
//    
//    self.hidesBottomBarWhenPushed = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认下单";
    
}

#pragma mark UITableViewDelegate&&UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 2) {
        
        return 40;
        
    }else if (section == 3) {
    
        return 0.1;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

@end
