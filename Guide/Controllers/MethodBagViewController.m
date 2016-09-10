#import "MethodBagViewController.h"
#import "MethodBagCell.h"
#import "NoChatList.h"
#import "ShopingCarModel.h"
#import "SureOrdersViewController.h"
@interface MethodBagViewController ()<UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray *productArr;
    NSMutableArray *SelectProArray;
    UIButton *editBtn;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (weak, nonatomic) IBOutlet UIButton *checkoutOrDelete;
//@property (weak, nonatomic) IBOutlet UIButton *collect;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UIButton *selectAll;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buyBtnWidth;

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
    SelectProArray = [NSMutableArray array];
    
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteLocalProduct:) name:@"deleteLocalProduct" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCart:) name:@"addCart" object:nil];
    
    
    //刷新
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",[HYSandbox docPath],SHOPPING_CAR];
        productArr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        [self.tableV reloadData];
        [self.tableV.mj_header endRefreshing];
        
    }];
    
    [self.tableV.mj_header beginRefreshing];
    
    editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(0, 0, 60, 44);
    [editBtn setTitleColor:lever1Color forState:UIControlStateNormal];
    editBtn.titleLabel.font = lever2Font;
    [editBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = item;
    
}


#pragma mark notificationAction
- (void)deleteLocalProduct:(NSNotification *)notifation {
    
    NSLog(@"删除已购买的购物车商品");
    for (ShopingCarModel *model in SelectProArray) {
        
        [productArr removeObject:model];
    }
    
    self.totalPrice.text = @"0";
    [SelectProArray removeAllObjects];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[HYSandbox docPath],SHOPPING_CAR];
    [NSKeyedArchiver archiveRootObject:productArr toFile:filePath];
    [self.tableV.mj_header beginRefreshing];
}

- (void)addCart:(NSNotification *)notifation {

    NSLog(@"加入购物车");
    [self.tableV.mj_header beginRefreshing];
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
    
    ShopingCarModel *model = productArr[indexPath.row];
    
    cell.isSelected.selected = NO;
    
    cell.produceName.text = model.fullName;
    cell.price.text = model.amount;
    NSLog(@"%@",model.mj_keyValues);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MethodBagCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ShopingCarModel *model = productArr[indexPath.row];
    
    
    if (cell.isSelected.selected) {
    
        cell.isSelected.selected = NO;
        self.totalPrice.text = [NSString stringWithFormat:@"%ld",[self.totalPrice.text integerValue] - [cell.price.text integerValue]];
        [SelectProArray removeObject:model];
        
    }else {
        
        cell.isSelected.selected = YES;
        [SelectProArray addObject:model];
        self.totalPrice.text = [NSString stringWithFormat:@"%ld",[self.totalPrice.text integerValue] + [cell.price.text integerValue]];
    }
    
    if (productArr != SelectProArray) {
        
        self.selectAll.selected = NO;
    }
    
     NSLog(@"DGrg = %ld",SelectProArray.count);
}

//- (void)viewDidLayoutSubviews {
//    
//    [super viewDidLayoutSubviews];
//    self.tableV.separatorInset = UIEdgeInsetsZero;
//    self.tableV.layoutMargins = UIEdgeInsetsZero;
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    self.tableV.separatorInset = UIEdgeInsetsZero;
//    self.tableV.layoutMargins = UIEdgeInsetsZero;
//}

- (IBAction)selectAllAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    if (button.selected) {
        
        [SelectProArray removeAllObjects];
        self.totalPrice.text = @"0";
        for (int i = 0; i< productArr.count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            MethodBagCell *cell = [self.tableV cellForRowAtIndexPath:indexPath];
            button.selected = NO;
            cell.isSelected.selected = NO;
            
        }
        
    }else {
        
        [SelectProArray addObjectsFromArray:productArr];
        for (int i = 0; i< productArr.count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            MethodBagCell *cell = [self.tableV cellForRowAtIndexPath:indexPath];
            self.totalPrice.text = [NSString stringWithFormat:@"%ld",[self.totalPrice.text integerValue] + [cell.price.text integerValue]];
            button.selected = YES;
            cell.isSelected.selected = YES;
        }
    }

}

- (void)edit:(UIButton *)sender {
    
    if (isEdit) {
        
        [self.checkoutOrDelete setTitle:@"立即购买" forState:UIControlStateNormal];
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        isEdit = NO;
        
//        self.buyBtnWidth.constant = 100;
//        self.totalPrice.hidden = NO;
        
    }else {
    
        isEdit = YES;
        [self.checkoutOrDelete setTitle:@"删除" forState:UIControlStateNormal];
        [sender setTitle:@"编辑..." forState:UIControlStateNormal];
        
//        self.buyBtnWidth.constant = SCREEN_WIDTH-70;
//        self.totalPrice.hidden = YES;
    }
    
    [self.view layoutIfNeeded];
}

- (IBAction)nowBuyAvtion:(id)sender {
    
    
    UIButton *button = (UIButton *)sender;

    if (SelectProArray.count == 0) {
        
        [[HUDConfig shareHUD]Tips:@"请选择商品" delay:DELAY];
        
    }else {
    
        if ([button.currentTitle isEqualToString:@"删除"]) {
            
            self.totalPrice.text = @"0";
            for (ShopingCarModel *model in SelectProArray) {
                
                [productArr removeObject:model];
            }
            
            [SelectProArray removeAllObjects];
            NSString *filePath = [NSString stringWithFormat:@"%@/%@",[HYSandbox docPath],SHOPPING_CAR];
            [NSKeyedArchiver archiveRootObject:productArr toFile:filePath];
            [self.tableV reloadData];
            
        }else {
        
            NSMutableArray *totalCoin = [NSMutableArray array];
            NSMutableArray *acceptableCoinTypes = [NSMutableArray arrayWithArray:((ShopingCarModel *)SelectProArray[0]).acceptableCoinTypes];
            if (SelectProArray.count > 0) {
                
                for (int i = 1; i<SelectProArray.count; i++) {
                    
                    ShopingCarModel *model = SelectProArray[i];
                    [totalCoin removeAllObjects];
                    [totalCoin addObjectsFromArray:acceptableCoinTypes];
                    [acceptableCoinTypes removeAllObjects];
                    
                    for (int x = 0; x<totalCoin.count; x++) {
                        
                        for (int y = 0; y<model.acceptableCoinTypes.count; y++) {
                            
                            if ([totalCoin[x] isEqualToString:model.acceptableCoinTypes[y]]) {
                                
                                if (![acceptableCoinTypes containsObject:model.acceptableCoinTypes[y]]) {
                                    
                                    [acceptableCoinTypes addObject:model.acceptableCoinTypes[y]];
                                }
                            }
                        }
                    }
                }
            }
            
            NSLog(@"acceptableCoinTypes = %@",acceptableCoinTypes);;
            
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
            SureOrdersViewController *sureOrder = [SB instantiateViewControllerWithIdentifier:@"SureOrdersViewController"];
            sureOrder.ProduceBag = SelectProArray;
            sureOrder.proPrice = self.totalPrice.text;
            sureOrder.acceptableCoinTypes = acceptableCoinTypes;
            [self.navigationController pushViewController:sureOrder animated:YES];
        }
    }
}
@end
