

#import "ClassifyViewController.h"
#import "SearchBar.h"
#import "ClassifyDetailHead.h"
#import "Main4Cell.h"
#import "ClassifyTerm1.h"
#import "ClassifyTerm2.h"
#import "ClassifyTerm3ViewController.h"
#import "ProduceDetailViewController.h"
#import "MainProduceListParams.h"
@interface ClassifyViewController ()<UITableViewDataSource,UITableViewDelegate,ClassifyDetailHeadDelegate,ClassifyTerm2Delegate,Term3Delegate,UITextFieldDelegate,ClassifyTerm1Delegate>
{
    //分类列表
    UITableView *typeTableView;
    //列表内容
    NSArray *typeArray;
    ClassifyDetailHead *head;
    UITextField *searchBar;
    NSString  *searchKeyWork;
    UIButton *closeBtn;
    BOOL isRefresh;
    BOOL isSearch;
    

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
        produceParams.rows = 20;
        _produceParams = produceParams;
        
    }
    return _produceParams;
}


-(ClassifyTerm1 *)term1 {

    if (_term1 == nil) {
        
        ClassifyTerm1 *term1 = [[ClassifyTerm1 alloc]initWithFrame:CGRectMake(0, head.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-64-44)];
        term1.delegate = self;
        NSString *rootPath = [HYSandbox docPath];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",rootPath,CategoryTree];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        term1.produceSource = array;
        
        [term1 selectedCategoryId:^(NSString *qryCategoryId) {
            
            FxLog(@"qryCategoryId = %@",qryCategoryId);
            
//            UIButton *button = [head viewWithTag:1000];
//            [button setTitleColor:MainColor forState:UIControlStateNormal];
//            button.selected = YES;
            
            //选择了左边的条件，恢复右边的条件
            
            UIButton *button1 = [head viewWithTag:1001];
            button1.selected = NO;
            [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIButton *button2 = [head viewWithTag:1002];
            button2.selected = NO;
            [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            if (![qryCategoryId isEqual:@"YES"]) {
                
                self.produceParams.qryScheduleDateFrom = nil;
                self.produceParams.qryScheduleDateTo = nil;
                self.produceParams.qryAreaIds = nil;
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

- (void)awakeFromNib {

    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginSearch:) name:@"search" object:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initTableViews];
}

- (void)beginSearch:(NSNotification *)notifation {

    FxLog(@"sfse = %@",notifation);
    isSearch = YES;
    searchKeyWork = notifation.userInfo[@"keyword"];
    searchBar.text = searchKeyWork;
    self.produceParams.qryKeyword = notifation.userInfo[@"keyword"];
    [typeTableView.mj_header beginRefreshing];
}

- (void)initTableViews {
    
    closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitle:@"清除选择" forState:UIControlStateNormal];
    closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [closeBtn sizeToFit];
    closeBtn.titleLabel.font = lever2Font;
    [closeBtn setTitleColor:lever1Color forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeParams) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    //搜索框
    searchBar = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-120, 30)];
    searchBar.layer.cornerRadius = 15;
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchBar.delegate = self;
    searchBar.text = searchKeyWork;
    searchBar.placeholder = @"输入商品名字，编号";
    searchBar.font = lever2Font;
    searchBar.layer.borderColor = lineColor.CGColor;
    searchBar.layer.borderWidth = 0.8;
    
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-fangdajing"]];
    //将左边的图片向右移动一定距离
    searchIcon.width +=10;
    searchIcon.contentMode = UIViewContentModeCenter;
    searchBar.leftView = searchIcon;
    
    self.navigationItem.titleView = searchBar;
    
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
        isRefresh = YES;
        [self loadProduceList];
        
    }];
    
    //加载
    typeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.produceParams.page += 1;
        isRefresh = NO;
        [self loadProduceList];
    }];
    
    [self loadProduceList];
    
}

- (void)loadProduceList {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    FxLog(@"produceListParams = %@",self.produceParams.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KHomePageProcudeList params:self.produceParams.mj_keyValues success:^(NSDictionary *dataDic) {
        
        
        closeBtn.userInteractionEnabled = YES;
        closeBtn.alpha = 1;
        
        if (!isSearch) {
         
            if (!isRefresh) {
                
                [[HUDConfig shareHUD]dismiss];
            }
        }
        FxLog(@"loadProduceList = %@",dataDic);
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            if (isRefresh) {
                
                [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            }
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *rows = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                
                if (isSearch) {
                 
                    if (rows.count == 0) {
                        
                        [[HUDConfig shareHUD]SuccessHUD:@"搜索无结果" delay:DELAY];
                    }
                }
                //等于1，说明是刷新
                if (self.produceParams.page == 1) {
                    
                    self.produces = [MainProduceModel mj_objectArrayWithKeyValuesArray:rows];
                    [typeTableView.mj_header endRefreshing];
                    
                }else {
                    
                    NSArray *array = [MainProduceModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.produces addObjectsFromArray:array];
                }
                
                if (rows.count < self.produceParams.rows) {
                    
                    [typeTableView.mj_footer endRefreshingWithNoMoreData];
                }else {
                    
                    [typeTableView.mj_footer endRefreshing];
                }
                [typeTableView reloadData];
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            [typeTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        isSearch = NO;
        
    } failure:^(NSError *error) {
        
        isSearch = NO;
        [typeTableView.mj_footer endRefreshing];
    }];
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {

    isSearch = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [searchBar resignFirstResponder];
    
    if (![self.produceParams.qryKeyword isEqual:textField.text]) {
        self.produceParams.qryKeyword = textField.text;
        [typeTableView.mj_header beginRefreshing];
    }
    
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField {

    return YES;
}

#pragma mark ClassifyTrem1Delegate
-(void)closeClassifyTerm1 {

    [_term1 removeFromSuperview];
    _term1 = nil;
}

#pragma mark ClassifyTerm2Delegate
- (void)classsifyTrem2Start:(NSString *)start end:(NSString *)end {

    [_term2 removeFromSuperview];
    _term2 = nil;
    
//    UIButton *mainBtn = [head viewWithTag:1001];
//    [mainBtn setTitleColor:MainColor forState:UIControlStateNormal];
//    mainBtn.selected = YES;
    
    UIButton *button = [head viewWithTag:1002];
    button.selected = NO;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.produceParams.qryScheduleDateFrom = start;
    self.produceParams.qryScheduleDateTo = end;
    self.produceParams.qryAreaIds = nil;
    [typeTableView.mj_header beginRefreshing];
}

- (void)closeTerm2View {

    [_term2 removeFromSuperview];
    _term2 = nil;
//    UIButton *button = [head viewWithTag:1001];
//    button.selected = NO;
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark Term3Delegate
- (void)areaIdOrStoresId:(NSArray *)model type:(NSString *)type {

//    UIButton *mainBtn = [head viewWithTag:1002];
//    [mainBtn setTitleColor:MainColor forState:UIControlStateNormal];
//    mainBtn.selected = YES;
    FxLog(@"SFASf = %@",model);
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in model) {
        
        [array addObject:[dic objectForKey:@"i"]];
    }
    
    self.produceParams.qryAreaIds = [array componentsJoinedByString:@","];
    [typeTableView.mj_header beginRefreshing];
}

#pragma mark ClassifyDetailHeadDelegate
- (void)searchTerm:(NSInteger)buttonTag {
    
    switch (buttonTag) {
        case 1000:
            
            if (_term2) {
                
                [_term2 removeFromSuperview];
                _term2 = nil;
            }
            
            if (_term1) {
                
                [_term1 removeFromSuperview];
                _term1 = nil;
                
                if (!self.produceParams.qryCategoryId) {
                    
                    UIButton *button1 = [head viewWithTag:buttonTag];
                    button1.selected = NO;
                    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }

            }else {
                
                [[UIApplication sharedApplication].keyWindow addSubview:self.term1];
            }
            
            break;
        case 1001:
            
            if (_term1) {
                
                [_term1 removeFromSuperview];
                _term1 = nil;
                
            }
            if (_term2) {
                
                [_term2 removeFromSuperview];
                _term2 = nil;
                if (self.produceParams.qryScheduleDateFrom.length == 0) {
                    UIButton *button1 = [head viewWithTag:buttonTag];
                    button1.selected = NO;
                    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }

            }else {
                
                [[UIApplication sharedApplication].keyWindow addSubview:self.term2];
            }
            
            break;
        case 1002:{
            
            if (_term1) {
                
                [_term1 removeFromSuperview];
                _term1 = nil;
            }
            
            if (_term2) {
                
                [_term2 removeFromSuperview];
                _term2 = nil;
            }
            
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

//#pragma mark ClassifyTerm2Delegate
//- (void)classsifyTrem2SureData:(NSString *)someString {
//
//    [_term2 removeFromSuperview];
//    _term2 = nil;
//    
////    UIButton *button = [head viewWithTag:1001];
////    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//}

#pragma mark UITableViewDelegate&&dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.produces.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainProduceModel *model = self.produces[indexPath.section];
    
    CGFloat cellH = 105.0;
    
    if (model.terms.length > 0) {
        
        cellH += 30.0;
    }
    
    if (model.tags.count > 0) {
        cellH += 25.0;
    }
    
    return cellH;
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
    
    cell.backgroundColor = [Uitils colorWithHex:0xf4f4f4];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.produces.count > 0) {
        
        MainProduceModel *model = self.produces[indexPath.section];
        cell.NameLabel.text     = model.name;
        if ([model.isPackagePrice integerValue] == 1) {
            
            if (model.price.length == 0) {
                
                cell.CoinsLabel.text    = [NSString stringWithFormat:@"%@~%@",model.minPrice,model.maxPrice];
                
            }else {
                
                cell.CoinsLabel.text    = model.price;
            }

        }else {
            
            cell.CoinsLabel.text    = [NSString stringWithFormat:@"%@~%@",model.minPrice,model.maxPrice];
        }
        cell.timeLabel.text     = model.scheduleDesc;
        cell.StockLabel.text    = [NSString stringWithFormat:@"库存 %@",model.stock];
        
        if (model.terms.length > 0) {
            
            cell.termsHeight.constant = 30;
            cell.termsLabel.text    = model.terms;
            
        }else {
        
            cell.termsHeight.constant = 0;
        }
        
//        //是否收藏
//        if ([model.favorite integerValue] != 0) {
//            
//            cell.collectBtn.selected = YES;
//            
//        }else {
//            
//            cell.collectBtn.selected = NO;
//        }
        
        for (int i = 0; i<model.acceptableCoinTypes.count; i++) {
            
            UIImageView *coinImg = (UIImageView *)[cell.contentView viewWithTag:i+100];
            coinImg.hidden       = NO;
            coinImg.image        = [UIImage imageNamed:[Uitils toImageName:model.acceptableCoinTypes[i]]];
        }
        
        for (int i = 0; i<model.tags.count; i++) {
            
            if (((NSString *)model.tags[i]).length > 0) {
                UIButton *tagsButton = (UIButton *)[cell.contentView viewWithTag:i+200];
                tagsButton.hidden    = NO;
                [tagsButton setTitle:[NSString stringWithFormat:@" %@ ",model.tags[i]] forState:UIControlStateNormal];
            }
        }

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self.tabBarController.tabBar.hidden = YES;
    
    MainProduceModel *model = self.produces[indexPath.section];
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
    produceDetail.produceId = model.id;
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

- (void)closeParams {
    
    if (_produceParams) {
        _produceParams = nil;
    }
    
    if (_term2) {
        
        [_term2 removeFromSuperview];
        _term2 = nil;
    }
    
    if (_term1) {
        
        [_term1 removeFromSuperview];
        _term1 = nil;
    }
    
    closeBtn.userInteractionEnabled = NO;
    closeBtn.alpha = 0.5;
    
    for (int i = 0; i<3; i++) {
       
        UIButton *button1 = [head viewWithTag:1000+i];
        button1.selected = NO;
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    searchBar.text = @"";
    [typeTableView.mj_header beginRefreshing];
}

@end
