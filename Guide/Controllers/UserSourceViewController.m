#import "UserSourceViewController.h"
#import "UserSourceCell.h"
#import "UserSourceParams.h"
#import "UserSourceModel.h"
#import "SourceListHead.h"
@interface UserSourceViewController ()<UITableViewDelegate,UITableViewDataSource>{

    //数据源
    NSMutableArray *userSourceArr;
    //选择的数据
    NSMutableArray *selectArr;
    
    SourceListHead *cellHead;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)UserSourceParams *params;
@end

@implementation UserSourceViewController


-(UserSourceParams *)params {
    
    if (_params == nil) {
        UserSourceParams *params = [[UserSourceParams alloc]init];
        params.rows = 20;
        params.page = 0;
        _params = params;
    }
    return _params;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userSourceArr = [NSMutableArray array];
    selectArr     = [NSMutableArray array];
    
    self.tableView.backgroundColor = backgroudColor;
//    self.tableView.estimatedRowHeight = 60;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.params.page = 1;
        
        [self freshUserSource];
        
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.params.page += 1;
        
        [self freshUserSource];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)freshUserSource {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    [KSMNetworkRequest postRequest:KUserSource params:self.params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"getUserSource = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *sourceData = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                
                //等于1，说明是刷新
                if (self.params.page == 1) {
                    
                    userSourceArr = [UserSourceModel mj_objectArrayWithKeyValuesArray:sourceData];
                    [self.tableView.mj_header endRefreshing];
                    
                }else {
                
                    NSArray *array = [UserSourceModel mj_objectArrayWithKeyValuesArray:sourceData];
                    [userSourceArr addObjectsFromArray:array];
                    
                    if (array.count < self.params.rows) {
                        
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }else {
                    
                        [self.tableView.mj_footer endRefreshing];
                    }
                }
                
                [self.tableView reloadData];
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        

        
    } failure:^(NSError *error) {
        
        [[HUDConfig shareHUD]ErrorHUD:error.localizedDescription delay:DELAY];
    }];
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
    cell.numLabel.text = model.code;
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
    
//    [[HUDConfig shareHUD]alwaysShow];
    
    if (selectArr.count == 0) {
        
        [[HUDConfig shareHUD]Tips:@"你还没有选择资源" delay:DELAY];
        return;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(chosedUserSource:)]) {
        
        [self.delegate chosedUserSource:selectArr];
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
//    NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:selectArr];
//    //NSMutableArray *teA = [NSKeyedUnarchiver unarchiveObjectWithData:teD]; 
//    
//    NSString *rootPath = [HYSandbox docPath];
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@",rootPath,USERSOURCE];
//    NSLog(@"%@",filePath);
//    if ([cacheData writeToFile:filePath atomically:YES]) {
//        
//        FxLog(@"用户资源数据写入成功");
//        [[HUDConfig shareHUD]Tips:@"成功" delay:DELAY];
//        
//        [self performSelector:@selector(backAction:) withObject:self afterDelay:DELAY];
//        
//    }else {
//        
//        FxLog(@"用户资源数据写入失败");
//        [[HUDConfig shareHUD]Tips:@"失败" delay:DELAY];
//    }
}

- (IBAction)repeatAction:(id)sender {
    
    [selectArr removeAllObjects];
    [self.tableView reloadData];
}
@end
