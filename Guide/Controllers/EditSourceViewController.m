#import "EditSourceViewController.h"
#import "MethodBagCell.h"
@interface EditSourceViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation EditSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"购物车";
}

#pragma mark UITableView Delegate && DataSource
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

@end
