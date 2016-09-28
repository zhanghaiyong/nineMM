#import "UserSourceViewController.h"
#import "UserSourceCell.h"
#import "UserSourceParams.h"
#import "UserSourceModel.h"
#import "SourceListHead.h"
@interface UserSourceViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{

    //数据源
    NSMutableArray *userSourceArr;
    //选择的数据
    NSMutableArray *selectArr;
    SourceListHead *cellHead;
    BOOL isRefresh;
    UITextField *searchBar;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)UserSourceParams *params;
@end

@implementation UserSourceViewController


-(UserSourceParams *)params {
    
    if (_params == nil) {
        UserSourceParams *params = [[UserSourceParams alloc]init];
        params.rows = 20;
        params.productId = [self.productId intValue];
        _params = params;
    }
    return _params;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavigationRightTitle:@"清除搜索"];
    
    //搜索框
    searchBar = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-120, 30)];
    searchBar.layer.cornerRadius = 15;
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchBar.delegate = self;
    searchBar.placeholder = @"输入商品名字，编号";
    searchBar.font = lever3Font;
    searchBar.layer.borderColor = lineColor.CGColor;
    searchBar.layer.borderWidth = 0.8;
    
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-fangdajing"]];
    //将左边的图片向右移动一定距离
    searchIcon.width +=10;
    searchIcon.contentMode = UIViewContentModeCenter;
    searchBar.leftView = searchIcon;
    self.navigationItem.titleView = searchBar;
    
    userSourceArr = [NSMutableArray array];
    selectArr     = [NSMutableArray array];
    self.tableView.backgroundColor = backgroudColor;
    
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.params.page = 1;
        isRefresh = YES;
        [self freshUserSource];
        
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.params.page += 1;
        isRefresh = NO;
        [self freshUserSource];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)freshUserSource {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    [KSMNetworkRequest postRequest:KUserSource params:self.params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"getUserSource = %@  \n params = %@",dataDic,self.params.mj_keyValues);
        
        if (!isRefresh) {
            
            [[HUDConfig shareHUD]dismiss];
        }
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            if (isRefresh) {
                
                [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            }
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *rows = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                
                //等于1，说明是刷新
                if (self.params.page == 1) {
                    
                    userSourceArr = [UserSourceModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.tableView.mj_header endRefreshing];
                    
                }else {
                
                    NSArray *array = [UserSourceModel mj_objectArrayWithKeyValuesArray:rows];
                    [userSourceArr addObjectsFromArray:array];
                }
                
                if (rows.count < self.params.rows) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else {
                    
                    [self.tableView.mj_footer endRefreshing];
                }
                [self.tableView reloadData];
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark UITextFieldDElegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if (textField.text.length > 0) {
        
        self.params.keyword = textField.text;
        [self.tableView.mj_header beginRefreshing];
        
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark UITableView Delegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return userSourceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    cellHead = [[[NSBundle mainBundle]loadNibNamed:@"SourceListHead" owner:self options:nil]lastObject];
    cellHead.backgroundColor = backgroudColor;
    cellHead.frame = CGRectMake(0, 0, self.tableView.width, 30);
    cellHead.titleLabel.text = @"选择商品";
    cellHead.countLabel.text = [NSString stringWithFormat:@"已选商品（%ld）",selectArr.count];
    cellHead.countLabel.textColor = [UIColor redColor];
    return cellHead;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ideitifier = @"UserSourceCell";
    UserSourceCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserSourceCell" owner:nil options:nil] lastObject];
    }
    
    UserSourceModel *model = userSourceArr[indexPath.row];
    
    if ([selectArr containsObject:model]) {
        
        cell.isSelect.selected = YES;
    }
    cell.titleLabel.text = model.name;
    cell.numLabel.text = [NSString stringWithFormat:@"编码：%@",model.code];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UserSourceModel *model = userSourceArr[indexPath.row];
    UserSourceCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
        
        if ([selectArr containsObject:model]) {
            
            [selectArr removeObject:model];
            cell.isSelect.selected = NO;
            
        }else {
            if (selectArr.count == [self.itemsCount integerValue]) {
                [[HUDConfig shareHUD]Tips:[NSString stringWithFormat:@"最多可以选择%@个",self.itemsCount] delay:DELAY];
            }else {
            
                [selectArr addObject:model];
                cell.isSelect.selected = YES;
            }
        }
    
    cellHead.countLabel.text = [NSString stringWithFormat:@"已选商品（%ld）",selectArr.count];
    
}
- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sureAction:(id)sender {
    
    if (selectArr.count == 0) {
        
        [[HUDConfig shareHUD]Tips:@"你还没有选择资源" delay:DELAY];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(chosedUserSource:)]) {
        
        [self.delegate chosedUserSource:selectArr];
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)repeatAction:(id)sender {
    
    [selectArr removeAllObjects];
    [self.tableView reloadData];
}

- (void)doRight:(UIButton *)sender {

    self.params.keyword = @"";
    [self.tableView.mj_header beginRefreshing];
    
    [searchBar resignFirstResponder];
}


@end
