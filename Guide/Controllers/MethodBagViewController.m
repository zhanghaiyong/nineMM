#import "MethodBagViewController.h"
#import "MethodBagCell.h"
#import "EditSourceViewController.h"
@interface MethodBagViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableV;

@end

@implementation MethodBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"购物车";
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self setNavigationRightTitle:@"编辑"];
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

- (void)doRight:(UIButton *)sender {
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    EditSourceViewController *editSourceList = [SB instantiateViewControllerWithIdentifier:@"EditSourceViewController"];
    [self.navigationController pushViewController:editSourceList animated:YES];
}

@end
