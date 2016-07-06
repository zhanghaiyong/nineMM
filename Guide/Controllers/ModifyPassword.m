
#import "ModifyPassword.h"

@interface ModifyPassword ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ModifyPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma  mark UITableVIewDelegate&&UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 3) {
        return 0.1;
    }
    
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}


@end
