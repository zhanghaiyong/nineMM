#import "MethodBagViewController.h"
#import "MethodBagCell.h"

@interface MethodBagViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (weak, nonatomic) IBOutlet UIButton *checkoutOrDelete;
@property (weak, nonatomic) IBOutlet UIButton *collect;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UIButton *selectAll;

@end

@implementation MethodBagViewController
{

    BOOL isEdit;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"购物车";
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 44);
//    [btn sizeToFit];
    [btn setTitleColor:lever1Color forState:UIControlStateNormal];
    btn.titleLabel.font = lever2Font;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
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
//    if (isEdit) {
//        
//        cell.isSelected.hidden = NO;
//        cell.selectedBtnWidth.constant = 19;
//        
//    }else {
//        
//        cell.isSelected.hidden = YES;
//        cell.selectedBtnWidth.constant = 0;
//    }
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

- (void)edit:(UIButton *)sender {
    
    if (isEdit) {
        
        self.collect.hidden = YES;
        [self.checkoutOrDelete setTitle:@"立即购买" forState:UIControlStateNormal];
        isEdit = NO;
    }else {
    
        isEdit = YES;
        self.collect.hidden = NO;
        self.collect.backgroundColor = [UIColor whiteColor];
        [self.checkoutOrDelete setTitle:@"删除" forState:UIControlStateNormal];
    }
    
    
    [self.tableV reloadData];

}

@end
