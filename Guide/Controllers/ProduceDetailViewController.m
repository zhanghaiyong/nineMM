#import "ProduceDetailViewController.h"
#import "MeumList.h"
#import "ProDetailCell1.h"
#import "ProDetailCell2.h"
#import "ProDetailCell.h"
#import "UserSourceViewController.h"
#import "ClassifyTerm3ViewController.h"
#import "ProduceDetailParams.h"
@interface ProduceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{

    //资源 档期 样刊切换标示
    NSInteger typeFlag;
}
@property (nonatomic,strong)MeumList *meumList;
@property (nonatomic,strong)ProduceDetailParams *produceDetailParams;
@property (nonatomic,strong)NSArray *meumTitles;
@property (nonatomic,strong)NSArray *meumLogos;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ProduceDetailViewController

-(ProduceDetailParams *)produceDetailParams {

    if (_produceDetailParams == nil) {
        
        ProduceDetailParams *produceDetailParams = [[ProduceDetailParams alloc]init];
        produceDetailParams.id = self.produceID;
        _produceDetailParams = produceDetailParams;
    }
    return _produceDetailParams;
}

- (MeumList *)meumList {
    
    if (_meumList == nil) {
        MeumList *meumList = [[MeumList alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, 60, 100,5*MEUM_CELL_H+10)];
        _meumList = meumList;
       
    }
    return _meumList;
}

- (NSArray *)meumTitles {

    if (_meumTitles == nil) {
        NSArray *meumTitles = [NSArray arrayWithObjects:@"消息",@"首页",@"搜索",@"我的收藏",@"浏览记录", nil];
        _meumTitles = meumTitles;
    }
    return _meumTitles;
}

- (NSArray *)meumLogos {
    
    if (_meumLogos == nil) {
        NSArray *meumLogos = [NSArray arrayWithObjects:@"消息",@"下载(5)-1",@"搜素o",@"收藏",@"下载(8)", nil];
        _meumLogos = meumLogos;
    }
    return _meumLogos;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //隐藏
    self.navigationController.navigationBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"资源详情";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn sizeToFit];
    [btn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"组-22"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(showMeumList) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    [self produceDetailData];
    
}

- (void)produceDetailData {

    [[HUDConfig shareHUD]alwaysShow];
    
    FxLog(@"produceDetailParams = %@",self.produceDetailParams.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KProduceDetail params:self.produceDetailParams.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"produceDetailData = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *rows = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
//                [self.produces addObjectsFromArray:[MainProduceModel mj_objectArrayWithKeyValuesArray:rows]];
                
//                NSIndexSet *nd=[[NSIndexSet alloc]initWithIndex:3];//刷新第3个section
//                [self.tableView reloadSections:nd withRowAnimation:UITableViewRowAnimationTop];
                
//                if (rows.count < 10) {
//                    
//                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
//                    
//                }else {
//                    
//                    [self.tableView.mj_footer endRefreshing];
//                }
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSError *error) {
        
        [[HUDConfig shareHUD]Tips :error.localizedDescription delay:DELAY];
//        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark  UITableViewDataSource&&delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        return 310;
    }else if(indexPath.row == 1){
        
        return 84+45;
        
    }else {
    
        switch (typeFlag) {
            case 0:
                return 200;
            case 1:
                return 300;
            case 2:
                return 400;
                break;
                
            default:
                break;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        
        ProDetailCell1 *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell1" owner:self options:nil] lastObject];
        return cell;
        
    }else if (indexPath.row == 1){
        
        static NSString *identifier = @"ProDetailCell";
        ProDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell" owner:self options:nil] lastObject];
            
        }
        
        //资源描述 档期规格 样刊案例
        [cell proDetailTypeChange:^(NSInteger flag) {
            typeFlag = flag;
            NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:2 inSection:0];
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[lastIndex] withRowAnimation:UITableViewRowAnimationMiddle];
            [self.tableView endUpdates];
        }];
        
        //选择商品使用该资源
        [cell toUserSource:^{    
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
            UserSourceViewController *toUSerSource = [SB instantiateViewControllerWithIdentifier:@"UserSourceViewController"];
            [self.navigationController pushViewController:toUSerSource animated:YES];
            
        }];
        
        
        //选择区域及门店
        [cell toStores:^{
            
            UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
            ClassifyTerm3ViewController *term3 = [mainSB instantiateViewControllerWithIdentifier:@"ClassifyTerm3ViewController"];
            [self.navigationController pushViewController:term3 animated:YES];
            
        }];
        
        cell.lineIndex = typeFlag;
        
        return cell;
        
    }else {

        ProDetailCell2 *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell2" owner:self options:nil] lastObject];
        cell.scrollTag = typeFlag;
        return cell;
    }
}

- (void)showMeumList
{
    if (_meumList == nil) {
        
        self.meumList.titleArr = self.meumTitles;
        self.meumList.imageArr = self.meumLogos;
       [self.navigationController.view addSubview:self.meumList];
        
    }else {
     
        [_meumList removeFromSuperview];
        _meumList = nil;
    }
}

@end
