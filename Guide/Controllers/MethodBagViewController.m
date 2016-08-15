#import "MethodBagViewController.h"
#import "MethodBagCell.h"
#import "NoChatList.h"
#import "ShopingCarModel.h"
@interface MethodBagViewController ()<UITableViewDelegate,UITableViewDataSource>{

    NSArray *productArr;
    NSMutableArray *countArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (weak, nonatomic) IBOutlet UIButton *checkoutOrDelete;
@property (weak, nonatomic) IBOutlet UIButton *collect;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UIButton *selectAll;

@end

@implementation MethodBagViewController {
    BOOL isEdit;
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"购物车";
    
//    self.tableV.delegate = self;
//    self.tableV.dataSource = self;
    
    
    //刷新
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",[HYSandbox docPath],SHOPPING_CAR];
        productArr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        countArray = [NSMutableArray array];
        for (int i = 0; i<productArr.count; i++) {
            
            [countArray addObject:@"1"];
        }
        
        [self.tableV reloadData];
        [self.tableV.mj_header endRefreshing];
        
    }];
    
    
    [self.tableV.mj_header beginRefreshing];
    
//    NoChatList *noChatList = [[[NSBundle mainBundle]loadNibNamed:@"NoChatList" owner:self options:nil] lastObject];
//    noChatList.frame = self.view.frame;
//    noChatList.label1.text = @"";
//    noChatList.label2.text = @"购物车暂时为空";
//    [self.view addSubview:noChatList];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 44);
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

    return productArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ideitifier = @"MethodBagCell";
    MethodBagCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MethodBagCell" owner:nil options:nil] lastObject];
    }
    ShopingCarModel *model = productArr[indexPath.section];
    
    [cell repeatCount:^(NSString *count,NSString *add_reduce) {
        
        
        if ([add_reduce isEqualToString:@"add"]) {
            
            self.totalPrice.text = [NSString stringWithFormat:@"%ld",[self.totalPrice.text integerValue] + [model.amount integerValue]];
            
        }else {
        
            self.totalPrice.text = [NSString stringWithFormat:@"%ld",[self.totalPrice.text integerValue] - [model.amount integerValue]];
        }
        
        
        [countArray replaceObjectAtIndex:indexPath.section withObject:count];
        cell.price.text = [NSString stringWithFormat:@"酒币：%ld",[model.amount integerValue]*[cell.count.text integerValue]];
        
    }];
    
//    NSLog(@"awfSDF = %@",dic);
    cell.produceName.text = model.fullName;
    cell.count.text = countArray[indexPath.section];
    cell.price.text = [NSString stringWithFormat:@"酒币：%ld",[model.amount integerValue]*[cell.count.text integerValue]];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MethodBagCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.isSelected.selected) {
    
        cell.isSelected.selected = NO;
        self.totalPrice.text = [NSString stringWithFormat:@"%ld",[self.totalPrice.text integerValue] - [cell.price.text integerValue]];
        
    }else {
        cell.isSelected.selected = YES;
        
        self.totalPrice.text = [NSString stringWithFormat:@"%ld",[self.totalPrice.text integerValue] + [cell.price.text integerValue]];
    
        
    }
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
