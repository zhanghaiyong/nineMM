#import "ControlAccount.h"
//#import "NavigationBarView.h"
@interface ControlAccount ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ControlAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NavigationBarView *navigationBarView = [[[NSBundle mainBundle] loadNibNamed:@"NavigationBarView" owner:self options:nil] lastObject];
//    navigationBarView.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
//    self.navigationItem.titleView = navigationBarView;

    self.title = @"我的帐户";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
}

#pragma mark UITableViewDelegate&&UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 1) {
        return 0.1;
    }
    return 15;
}



@end
