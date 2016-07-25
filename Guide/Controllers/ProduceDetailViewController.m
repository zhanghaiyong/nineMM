#import "ProduceDetailViewController.h"
#import "MeumList.h"
#import "ProDetailCell1.h"
#import "ProDetailCell2.h"
#import "ProDetailCell.h"
#import "ProDetailCell3.h"
#import "UserSourceViewController.h"
#import "ClassifyTerm3ViewController.h"
#import "ProduceDetailParams.h"
#import "ProduceDetailModel.h"
#import "ProPriceByStoreParams.h"
#import "SureOrdersViewController.h"
@interface ProduceDetailViewController ()<UITableViewDelegate,UITableViewDataSource,Term3Delegate,UserSourceDelegate,UIWebViewDelegate>{

    //资源 档期 样刊切换标示
    NSInteger typeFlag;
    ProduceDetailModel *produceDetail;
    NSString    *areaOrStore;
    NSArray     *userSource;
    CGFloat webViewH;
    ProDetailCell2 *cell3;
    NSString  *price;
}
@property (nonatomic,strong)MeumList *meumList;
@property (nonatomic,strong)ProPriceByStoreParams *proPriceByStoreParams;
@property (nonatomic,strong)NSArray *meumTitles;
@property (nonatomic,strong)NSArray *meumLogos;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ProduceDetailViewController

-(ProPriceByStoreParams *)proPriceByStoreParams {

    if (_proPriceByStoreParams == nil) {
        
        ProPriceByStoreParams *proPriceByStoreParams = [[ProPriceByStoreParams alloc]init];
        proPriceByStoreParams.productId = self.produceModel.id;
        _proPriceByStoreParams = proPriceByStoreParams;
    }
    return _proPriceByStoreParams;
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
//    self.navigationController.navigationBar.hidden = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.title = @"资源详情";
    [self produceDetailData];
}


- (void)produceDetailData {

    [[HUDConfig shareHUD]alwaysShow];
    
    ProduceDetailParams *params = [[ProduceDetailParams alloc]init];
    params.id = self.produceModel.id;
    
    FxLog(@"produceDetailParams = %@",params.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KProduceDetail params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        FxLog(@"produceDetailData = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSDictionary *retObj = [dataDic objectForKey:@"retObj"];
                produceDetail = [ProduceDetailModel mj_objectWithKeyValues:retObj];
                
                NSLog(@"11111");
                self.tableView.delegate = self;
                self.tableView.dataSource = self;
                [self.tableView reloadData];
            }
            
        }else if ([[dataDic objectForKey:@"retCode"]integerValue] == -2){
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            LoginViewController *loginVC = [SB instantiateViewControllerWithIdentifier:@"LoginViewController"];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:navi animated:YES completion:^{
                
            [self.navigationController popViewControllerAnimated:YES];
                
            }];
        }
        
    } failure:^(NSError *error) {
        
        [[HUDConfig shareHUD]ErrorHUD :error.localizedDescription delay:DELAY];
    }];
}


#pragma mark  UITableViewDataSource&&delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 1;
            break;
        case 1: {
            
            return 3;
        }
            
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 310;
        
    }else if (indexPath.section == 1) {
        
        switch (indexPath.row) {
            case 0:
            
                 if ([produceDetail.itemSelecting integerValue] == -1) {
                    
                     return 0;
                 }else {
                 
                     return 44;
                 }
                break;
            case 1:
                
                if ([produceDetail.shopSelecting integerValue] == 0) {
                    
                    return 0;
                }else {
                
                    return 44;
                }
            case 2:
                
                    return 44;
                
                break;
                
            default:
                break;
        }
        
    }else {
    
//        switch (typeFlag) {
//            case 0:
//                return 200;
//            case 1:
//                return 300;
//            case 2:
//                return 400;
//                break;
//                
//            default:
//                break;
//        }
        return webViewH;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        ProDetailCell1 *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell1" owner:self options:nil] lastObject];
        
        if (produceDetail.images.count > 0) {
            //滚动试图
            NSMutableArray *topImages = [NSMutableArray array];
            for (NSString *imageName in produceDetail.images) {
                
                [topImages addObject:[NSString stringWithFormat:@"%@",imageName]];
            }
            cell.Banner.imageArray = topImages;
        }
        cell.nameLabel.text = produceDetail.name;
        if ([produceDetail.isPackagePrice integerValue] == 1) {
            cell.priceLabel.text    = produceDetail.marketPrice;
            
        }else {
            cell.priceLabel.text    = [NSString stringWithFormat:@"%@~%@",produceDetail.minPrice,produceDetail.maxPrice];
        }
        
        for (int i = 0; i<produceDetail.tags.count; i++) {
            
            UILabel *tagLabel = (UILabel *)[cell.contentView viewWithTag:i+300];
            tagLabel.text = [NSString stringWithFormat:@" %@ ",produceDetail.tags[i]];
        }
        cell.otherInfo.text = produceDetail.otherInfo;
        cell.termLabel.text = [NSString stringWithFormat:@"库存 %@",produceDetail.itemsCount];
        cell.explainLabel.text = produceDetail.terms;
        
        return cell;
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            
            ProDetailCell3 *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell3" owner:self options:nil] lastObject];
            cell.titleLabel.text = @"选择商品使用资源";
            return cell;
            
        }else if (indexPath.row == 1) {
            ProDetailCell3 *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell3" owner:self options:nil] lastObject];
            cell.titleLabel.text = @"选择区域及门店";
            return cell;
        }else {
        
            ProDetailCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell" owner:self options:nil] lastObject];
            
            //资源描述 档期规格 样刊案例
            NSArray *tabs = produceDetail.tabs;
            if (tabs.count > 0) {
                
                for (int i = 0; i<3; i++) {
                    NSDictionary *dic = tabs[i];
                    UIButton *sender = (UIButton *)[cell.contentView viewWithTag:100+i];
                    [sender setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
                }
            }
            
            [cell proDetailTypeChange:^(NSInteger flag) {
                typeFlag = flag;
                NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:0 inSection:2];
                [self.tableView beginUpdates];
                [self.tableView reloadRowsAtIndexPaths:@[lastIndex] withRowAnimation:UITableViewRowAnimationMiddle];
                [self.tableView endUpdates];
            }];
            
            cell.lineIndex = typeFlag;
            return cell;
        }
    }else {

        cell3 = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell2" owner:self options:nil] lastObject];
        cell3.scrollTag = typeFlag;
        cell3.webView.delegate = self;
        
        NSArray *tabs = produceDetail.tabs;
        NSDictionary *dic = tabs[typeFlag];
        NSString *urlStr = [NSString stringWithFormat:@"%@%@/%@.page",HTMLURL,self.produceModel.id,[dic objectForKey:@"tab"]];
        NSLog(@"zfzsdgd =%@",urlStr);
        NSURL *url = [NSURL URLWithString:urlStr];
        [cell3.webView loadRequest:[NSURLRequest requestWithURL:url]];
        
        return cell3;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        
        switch (indexPath.row) {
            case 0: {
                UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
                UserSourceViewController *toUSerSource = [SB instantiateViewControllerWithIdentifier:@"UserSourceViewController"];
                toUSerSource.delegate = self;
                toUSerSource.itemsCount = produceDetail.itemsCount;
                [self.navigationController pushViewController:toUSerSource animated:YES];
            }
                break;
            case 1: {
                
                UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
                ClassifyTerm3ViewController *term3 = [mainSB instantiateViewControllerWithIdentifier:@"ClassifyTerm3ViewController"];
                term3.produceModel = self.produceModel;
                term3.delegate = self;
                [self.navigationController pushViewController:term3 animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)showMeumList {
    if (_meumList == nil) {
        
        self.meumList.titleArr = self.meumTitles;
        self.meumList.imageArr = self.meumLogos;
       [self.navigationController.view addSubview:self.meumList];
        
    }else {
     
        [_meumList removeFromSuperview];
        _meumList = nil;
    }
}
- (IBAction)collectAction:(id)sender {
}
- (IBAction)packageAction:(id)sender {
}
- (IBAction)addPackageAction:(id)sender {
}

- (IBAction)buyNowAction:(id)sender {
    
    //必须按的情况下，判断是否选择了资源
    if ([produceDetail.itemSelecting integerValue] == 1) {
        if (userSource.count == 0) {
            [[HUDConfig shareHUD]Tips:@"请选择商品资源" delay:DELAY];
            return;
        }
    }
    
    if ([produceDetail.shopSelecting integerValue] == 1) {
        if (areaOrStore.length == 0) {
            [[HUDConfig shareHUD]Tips:@"请选择门店及区域" delay:DELAY];
            return;
        }
    }
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    SureOrdersViewController *sureOrder = [SB instantiateViewControllerWithIdentifier:@"SureOrdersViewController"];
    sureOrder.userSourceArr = userSource;
    sureOrder.produceModel = self.produceModel;
    sureOrder.proPriceByStoreParams = self.proPriceByStoreParams;
    sureOrder.proPrice = price;
    [self.navigationController pushViewController:sureOrder animated:YES];

}

#pragma mark UserSourceViewController Delegate
- (void)chosedUserSource:(NSArray *)array {

    userSource = [NSArray arrayWithArray:array];
}

#pragma mark Term3Delegate
- (void)areaIdOrStoresId:(NSString *)ids type:(NSString *)type {

    NSLog(@"dzfsdg =  %@%@",ids,type);
    
    areaOrStore = ids;
    if ([type isEqualToString:@"storeId"]) {
        self.proPriceByStoreParams.storeIds = ids;
        self.proPriceByStoreParams.storeSelectingType = @"store";
    }else {
        self.proPriceByStoreParams.storeSelectingType = @"area";
        self.proPriceByStoreParams.areaIds = ids;
    }
    
    [[HUDConfig shareHUD]alwaysShow];
    
    FxLog(@"buyNowAction = %@",self.proPriceByStoreParams.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KGetProductPriceByStoreSelection params:self.proPriceByStoreParams.mj_keyValues success:^(NSDictionary *dataDic) {

        FxLog(@"buyNowAction = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            ProDetailCell1 *cell = (ProDetailCell1 *)[self.tableView cellForRowAtIndexPath:indexPath];
            cell.priceLabel.text = [NSString stringWithFormat:@"%@",[[dataDic objectForKey:@"retObj"] objectForKey:@"price"]];
            price = [NSString stringWithFormat:@"%@",[[dataDic objectForKey:@"retObj"] objectForKey:@"price"]];
            
        }else {
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
        [[HUDConfig shareHUD]ErrorHUD :error.localizedDescription delay:DELAY];
    }];
    

    
    
}

#pragma mark UIWe=bViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *height_str = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
    webViewH = [height_str floatValue];
    NSLog(@"height_str = %lf",webViewH);
    
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[cell3] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    
}


@end
