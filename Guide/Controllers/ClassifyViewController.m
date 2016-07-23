

#import "ClassifyViewController.h"
#import "SearchBar.h"
#import "ClassifyDetailHead.h"
#import "Main4Cell.h"
#import "ClassifyTerm1.h"
#import "ClassifyTerm2.h"
#import "ClassifyTerm3ViewController.h"
#import "ProduceDetailViewController.h"
#import "MainProduceListParams.h"
@interface ClassifyViewController ()<UITableViewDataSource,UITableViewDelegate,ClassifyDetailHeadDelegate,ClassifyTerm2Delegate,Term3Delegate>
{
    //分类列表
    UITableView *typeTableView;
    //列表内容
    NSArray *typeArray;
    ClassifyDetailHead *head;
    

}

@property (nonatomic,strong)NSMutableArray *produces;
@property (nonatomic,strong)MainProduceListParams *produceParams;
@property (nonatomic,strong)ClassifyTerm1 *term1;
@property (nonatomic,strong)ClassifyTerm2 *term2;

@end

@implementation ClassifyViewController
-(NSMutableArray *)produces {
    
    if (_produces == nil) {
        
        NSMutableArray *produces = [NSMutableArray array];
        _produces = produces;
    }
    return _produces;
}

-(MainProduceListParams *)produceParams {
    
    if (_produceParams == nil) {
        
        MainProduceListParams *produceParams = [[MainProduceListParams alloc]init];
        _produceParams = produceParams;
        _produceParams.rows = 20;
        
    }
    return _produceParams;
}


-(ClassifyTerm1 *)term1 {

    if (_term1 == nil) {
        
        ClassifyTerm1 *term1 = [[ClassifyTerm1 alloc]initWithFrame:CGRectMake(0, head.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-64-44)];
        NSString *rootPath = [HYSandbox docPath];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",rootPath,CategoryTree];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        term1.produceSource = array;
        
        [term1 selectedCategoryId:^(NSString *qryCategoryId) {
            
            [term1 removeFromSuperview];
            UIButton *button = [head viewWithTag:1000];
            button.selected = NO;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            if (![qryCategoryId isEqual:@"YES"]) {
                
                self.produceParams.qryCategoryId = qryCategoryId;
                
                [typeTableView.mj_header beginRefreshing];
            }

        }];
        
        _term1 = term1;
    }
    return _term1;
}

-(ClassifyTerm2 *)term2 {
    
    if (_term2 == nil) {
        
        ClassifyTerm2 *term2 = [[[NSBundle mainBundle]loadNibNamed:@"ClassifyTerm2" owner:self options:nil] lastObject];
        term2.frame = CGRectMake(0, head.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-64-44);
        term2.delegate = self;
        _term2 = term2;
    }
    return _term2;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initTableViews];
    
}

- (void)initTableViews {
    
    [self setNavigationRightTitle:@"清除选择"];
    //搜索框
    UITextField *searchBar = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 30)];
    searchBar.layer.cornerRadius = 15;
    searchBar.placeholder = @"输入商品名字，编号";
    searchBar.font = lever2Font;
    searchBar.layer.borderColor = lineColor.CGColor;
    searchBar.layer.borderWidth = 0.8;
    self.navigationItem.titleView = searchBar;
    
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-fangdajing"]];
    //将左边的图片向右移动一定距离
    searchIcon.width +=10;
    searchIcon.contentMode = UIViewContentModeCenter;
    searchBar.leftView = searchIcon;
    
    //分类头部
    head = [[[NSBundle mainBundle] loadNibNamed:@"ClassifyDetailHead" owner:self options:nil] lastObject];
    head.frame = CGRectMake(0, 64, SCREEN_WIDTH, 44);
    head.delegate = self;
    [self.view addSubview:head];

    //商品列表
    typeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, head.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-64-44-49)];
    typeTableView.delegate = self;
    typeTableView.dataSource = self;
    typeTableView.separatorColor = backgroudColor;
    typeTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:typeTableView];
    
    //刷新
    typeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.produceParams.page = 1;
        
        [self loadProduceList];
        
    }];
    
    //加载
    typeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.produceParams.page += 1;
        
        [self loadProduceList];
    }];
    
    [typeTableView.mj_header beginRefreshing];
    
}

- (void)loadProduceList {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    FxLog(@"produceListParams = %@",self.produceParams.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KHomePageProcudeList params:self.produceParams.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"loadProduceList = %@",dataDic);
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *rows = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                
                //等于1，说明是刷新
                if (self.produceParams.page == 1) {
                    
                    self.produces = [MainProduceModel mj_objectArrayWithKeyValuesArray:rows];
                    [typeTableView.mj_header endRefreshing];
                    
                }else {
                    
                    NSArray *array = [MainProduceModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.produces addObjectsFromArray:array];
                    
                    if (array.count < self.produceParams.rows) {
                        
                        [typeTableView.mj_footer endRefreshingWithNoMoreData];
                    }else {
                        
                        [typeTableView.mj_footer endRefreshing];
                    }
                }
                [typeTableView reloadData];
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            [typeTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSError *error) {
        
        [[HUDConfig shareHUD]Tips :error.localizedDescription delay:DELAY];
        [typeTableView.mj_footer endRefreshing];
    }];
}


#pragma mark ClassifyTerm2Delegate
- (void)classsifyTrem2Start:(NSString *)start end:(NSString *)end {

    [_term2 removeFromSuperview];
    _term2 = nil;
    UIButton *button = [head viewWithTag:1001];
    button.selected = NO;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.produceParams.qryScheduleDateFrom = start;
    self.produceParams.qryScheduleDateTo = end;
    [typeTableView.mj_header beginRefreshing];
}

- (void)closeTerm2View {

    [_term2 removeFromSuperview];
    _term2 = nil;
    UIButton *button = [head viewWithTag:1001];
    button.selected = NO;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark Term3Delegate
- (void)areaIdOrStoresId:(NSString *)ids type:(NSString *)type {

    UIButton *button = [head viewWithTag:1002];
    button.selected = NO;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSLog(@"SFASf = %@",ids);
    self.produceParams.qryAreaIds = ids;
    [typeTableView.mj_header beginRefreshing];
}

#pragma mark ClassifyDetailHeadDelegate
- (void)searchTerm:(NSInteger)buttonTag {
    
    switch (buttonTag) {
        case 1000:
            
            if (_term2) {
                
                [_term2 removeFromSuperview];
                _term2 = nil;
                
                UIButton *button = [head viewWithTag:1001];
                button.selected = NO;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            if (_term1) {
                
                [_term1 removeFromSuperview];
                _term1 = nil;
                
                UIButton *button = [head viewWithTag:1000];
                button.selected = NO;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else {
                [[UIApplication sharedApplication].keyWindow addSubview:self.term1];
            }
            
            break;
        case 1001:
            
            if (_term1) {
                
                [_term1 removeFromSuperview];
                _term1 = nil;
                
                UIButton *button = [head viewWithTag:1000];
                button.selected = NO;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            if (_term2) {
                
                [_term2 removeFromSuperview];
                _term2 = nil;
                
                UIButton *button = [head viewWithTag:1001];
                button.selected = NO;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }else {
                
                [[UIApplication sharedApplication].keyWindow addSubview:self.term2];
            }
            
            break;
        case 1002:{
            
            if (_term1) {
                
                [_term1 removeFromSuperview];
                _term1 = nil;
                
                UIButton *button = [head viewWithTag:1000];
                button.selected = NO;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            if (_term2) {
                
                [_term2 removeFromSuperview];
                _term2 = nil;
                
                UIButton *button = [head viewWithTag:1001];
                button.selected = NO;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            UIButton *button = [head viewWithTag:1002];
            button.selected = NO;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
            ClassifyTerm3ViewController *term3 = [mainSB instantiateViewControllerWithIdentifier:@"ClassifyTerm3ViewController"];
            term3.delegate = self;
            [self.navigationController pushViewController:term3 animated:YES];
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark ClassifyTerm2Delegate
- (void)classsifyTrem2SureData:(NSString *)someString {

    [_term2 removeFromSuperview];
    _term2 = nil;
    
    UIButton *button = [head viewWithTag:1001];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark UITableViewDelegate&&dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.produces.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 170;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identtifier = @"cell";
    Main4Cell *cell = [tableView dequeueReusableCellWithIdentifier:identtifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Main4Cell" owner:self options:nil] lastObject];
    }
    
    if (self.produces.count > 0) {
        
        MainProduceModel *model = self.produces[indexPath.row];
        cell.NameLabel.text     = model.name;
        cell.CoinsLabel.text    = model.marketPrice;
        cell.timeLabel.text     = model.scheduleDesc;
        cell.termsLabel.text    = [NSString stringWithFormat:@"资源限制说明：%@",model.terms];
        cell.StockLabel.text    = [NSString stringWithFormat:@"库存 %@",model.stock];
        
        //是否收藏
        if ([model.favorite integerValue] != 0) {
            
            cell.collectBtn.selected = YES;
            
        }else {
            
            cell.collectBtn.selected = NO;
        }
        
        for (int i = 0; i<model.acceptableCoinTypes.count; i++) {
            
            UIImageView *coinImg = (UIImageView *)[cell.contentView viewWithTag:i+100];
            coinImg.hidden       = NO;
            coinImg.image        = [UIImage imageNamed:[Uitils toImageName:model.acceptableCoinTypes[i]]];
        }
        
        for (int i = 0; i<model.tags.count; i++) {
            
            UIButton *tagsButton = (UIButton *)[cell.contentView viewWithTag:i+200];
            tagsButton.hidden    = NO;
            [tagsButton setTitle:model.tags[i] forState:UIControlStateNormal];
        }
        
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MainProduceModel *model = self.produces[indexPath.row];
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
    produceDetail.produceModel = model;
    [self.navigationController pushViewController:produceDetail animated:YES];
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    typeTableView.separatorInset = UIEdgeInsetsZero;
    typeTableView.layoutMargins = UIEdgeInsetsZero;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    typeTableView.separatorInset = UIEdgeInsetsZero;
    typeTableView.layoutMargins = UIEdgeInsetsZero;
}

- (void)doRight:(UIButton *)sender
{
    if (_produceParams) {
        _produceParams = nil;
    }
    
    [typeTableView.mj_header beginRefreshing];
}

@end
