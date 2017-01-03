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
#import "ProduceStoresModel.h"
#import "ShopingCarModel.h"
#import "MethodBagViewController.h"
#import "URLViewController.h"
@interface ProduceDetailViewController ()<UITableViewDelegate,UITableViewDataSource,Term3Delegate,UserSourceDelegate,ZHYBannerViewDelegte>{

    //资源 档期 样刊切换标示
    NSInteger typeFlag;
    ProduceDetailModel *produceDetail;
    NSString    *areaOrStore;
    NSArray     *userSource;
    NSMutableArray     *storeAreaModel;
    CGFloat webViewHeight;
    ProDetailCell2 *cell3;
    NSString  *price;
    BOOL      isRefreshWebViewH;
}
@property (weak, nonatomic) IBOutlet UIButton *addShoppCarButton;
@property (weak, nonatomic) IBOutlet UIButton *nowBuyButton;
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
        proPriceByStoreParams.productId = self.produceId;
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
    
//    [self produceDetailData];
    //隐藏
//    self.navigationController.navigationBar.hidden = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"资源详情";
    storeAreaModel = [NSMutableArray array];
    userSource = [NSArray array];
    
//    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[HYSandbox docPath],SHOPPING_CAR];
//    NSArray *shoppings = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    [shoppings enumerateObjectsUsingBlock:^(ShopingCarModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        FxLog(@" 本地购物车 ＝ %@",model.mj_keyValues);
//        
//        if ([model.productId isEqual:self.produceId]) {
//            
//            self.addShoppCarButton.alpha = 0.5;
//            self.addShoppCarButton.userInteractionEnabled = NO;
//        }
//    }];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self produceDetailData];
    isRefreshWebViewH = YES;
    if (_fromPackage) {
        
        [self.nowBuyButton setTitle:@"确认" forState:UIControlStateNormal];
    }
}


- (void)produceDetailData {

    [[HUDConfig shareHUD]alwaysShow];
    
    ProduceDetailParams *params = [[ProduceDetailParams alloc]init];
    params.id = self.produceId;
    
    FxLog(@"produceDetailParams = %@",params.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KProduceDetail params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        FxLog(@"produceDetailData = %@",dataDic);

        [[HUDConfig shareHUD]dismiss];
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            if (((NSDictionary *)[dataDic objectForKey:@"retObj"]).count !=0) {
                
                NSDictionary *retObj = [dataDic objectForKey:@"retObj"];
                produceDetail = [ProduceDetailModel mj_objectWithKeyValues:retObj];
                
                self.tableView.delegate = self;
                self.tableView.dataSource = self;
                [self.tableView reloadData];
            }
            
        }else if ([[dataDic objectForKey:@"retCode"]integerValue] == -2){
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            LoginViewController *loginVC = [SB instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self presentViewController:loginVC animated:YES completion:^{
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else {
        
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
    } failure:^(NSError *error) {
        
        
        [[HUDConfig shareHUD]ErrorHUD:@"失败" delay:DELAY];
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
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 300;
        
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

        return webViewHeight;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        ProDetailCell1 *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell1" owner:self options:nil] lastObject];
        
        for (int i = 0; i<produceDetail.acceptableCoinTypes.count; i++) {
            
            UIImageView *coinImg = (UIImageView *)[cell.contentView viewWithTag:i+500];
            coinImg.hidden = NO;
            coinImg.image  = [UIImage imageNamed:[Uitils toImageName:produceDetail.acceptableCoinTypes[i]]];
        }
        cell.PriceLending.constant = 10+produceDetail.acceptableCoinTypes.count*30;
        
        if (produceDetail.images.count > 0) {
            //滚动试图
            NSMutableArray *topImages = [NSMutableArray array];
            for (NSString *imageName in produceDetail.images) {
                
                [topImages addObject:[NSString stringWithFormat:@"%@",imageName]];
            }
            cell.Banner.delegate = self;
            cell.Banner.imageArray = topImages;
        }
        cell.nameLabel.text = produceDetail.fullName;
        if ([produceDetail.isPackagePrice integerValue] == 1) {
            
            if (produceDetail.price.length == 0) {
                
                cell.priceLabel.text = [NSString stringWithFormat:@"%@~%@",produceDetail.minPrice,produceDetail.maxPrice];
                
            }else {
                
                cell.priceLabel.text = produceDetail.price;
            }
            
        }else {
            
            cell.priceLabel.text = [NSString stringWithFormat:@"%@~%@",produceDetail.minPrice,produceDetail.maxPrice];
        }
        
        for (int i = 0; i<produceDetail.tags.count; i++) {
            
            UILabel *tagLabel = (UILabel *)[cell.contentView viewWithTag:i+300];
            tagLabel.text = [NSString stringWithFormat:@" %@ ",produceDetail.tags[i]];
        }
        cell.termLabel.text = [NSString stringWithFormat:@"库存：%@",produceDetail.stock];
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
                isRefreshWebViewH = YES;
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationTop];
 
            }];
            
            cell.lineIndex = typeFlag;
            return cell;
        }
    }else {
        
        cell3 = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell2" owner:self options:nil] lastObject];
        NSArray *tabs = produceDetail.tabs;
        NSDictionary *dic = tabs[typeFlag];
        NSString *urlStr = [NSString stringWithFormat:@"%@/product/mobile/%@/%@.page",BaseURLString,self.produceId,[dic objectForKey:@"tab"]];
        FxLog(@"zfzsdgd =%@",urlStr);
        NSURL *url = [NSURL URLWithString:urlStr];
        cell3.isRefreshWebView = isRefreshWebViewH;
        cell3.htmlUrl = url;
        [cell3 countWebViewHeight:^(float webViewH) {
            
            isRefreshWebViewH = NO;
            webViewHeight = webViewH;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
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
                toUSerSource.productId = self.produceId;
                toUSerSource.itemsCount = produceDetail.itemsCount;
                [self.navigationController pushViewController:toUSerSource animated:YES];
            }
                break;
            case 1: {
                
                UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
                ClassifyTerm3ViewController *term3 = [mainSB instantiateViewControllerWithIdentifier:@"ClassifyTerm3ViewController"];
                term3.produceId = self.produceId;
                term3.delegate = self;
                [self.navigationController pushViewController:term3 animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}


#pragma mark BanndrDelegate
- (void)tapBannerImage:(NSInteger)imageTag {

    FxLog(@"fsdgd %ld",imageTag);
    
    NSString *imageID = produceDetail.images[imageTag-1000];
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    URLViewController *URLVC = [mainSB instantiateViewControllerWithIdentifier:@"URLViewController"];
    URLVC.title = @"文章页";
    URLVC.urlString = [NSString stringWithFormat:@"%@/%@.page",KArticleHtml,imageID];
    [self.navigationController pushViewController:URLVC animated:YES];
}

- (IBAction)collectAction:(id)sender {
    
}

//购物车
- (IBAction)packageAction:(id)sender {
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    MethodBagViewController *sureOrder = [SB instantiateViewControllerWithIdentifier:@"MethodBagViewController"];
    [self.navigationController pushViewController:sureOrder animated:YES];
}

//加入购物车
- (IBAction)addPackageAction:(id)sender {
    
    //必须按的情况下，判断是否选择了资源
    if ([produceDetail.itemSelecting integerValue] == 1) {
        if (userSource.count == 0) {
            [[HUDConfig shareHUD]Tips:@"先选择商品资源才能加入购物车" delay:DELAY];
            return;
        }
    }
    
    if ([produceDetail.shopSelecting integerValue] == 1) {
        if (areaOrStore.length == 0) {
            [[HUDConfig shareHUD]Tips:@"先选择门店及区域才能加入购物车" delay:DELAY];
            return;
        }
    }
    
    if (produceDetail.fullName.length == 0 || self.produceId.length == 0 || produceDetail.acceptableCoinTypes.count == 0) {
        return;
    }
    
    
    if ([produceDetail.isPackagePrice integerValue] == 1) {
        
        if (produceDetail.price.length == 0) {
            return;
        }
    }else {
        
        if (price.length == 0) {
            
            return;
        }
    }
    
        [[HUDConfig shareHUD]alwaysShow];
        ShopingCarModel *shopCarModel = [[ShopingCarModel alloc]init];
        shopCarModel.fullName = produceDetail.fullName;
        shopCarModel.productId = self.produceId;
        shopCarModel.storeSelectingType = self.proPriceByStoreParams.storeSelectingType;
        shopCarModel.storesId = self.proPriceByStoreParams.storeIds;
        shopCarModel.areasId = self.proPriceByStoreParams.areaIds;
        shopCarModel.items = userSource;
        shopCarModel.acceptableCoinTypes = produceDetail.acceptableCoinTypes;
        
        if ([produceDetail.isPackagePrice integerValue] == 1) {
            shopCarModel.amount = produceDetail.price;
        }else {
            shopCarModel.amount = price;
        }
        
        FxLog(@"shopCarModel = %@",shopCarModel.mj_keyValues);
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",[HYSandbox docPath],SHOPPING_CAR];
        NSArray *shoppings = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        NSMutableArray *array = [NSMutableArray array];
        
        if (shoppings) {
            [array addObjectsFromArray:shoppings];
            [array addObject:shopCarModel];
//            self.addShoppCarButton.alpha = 0.5;
//            self.addShoppCarButton.userInteractionEnabled = NO;
            [[HUDConfig shareHUD]SuccessHUD:@"成功加入" delay:DELAY];
            
        }else {
            
            [array addObject:shopCarModel];
//            self.addShoppCarButton.alpha = 0.5;
//            self.addShoppCarButton.userInteractionEnabled = NO;
            [[HUDConfig shareHUD]SuccessHUD:@"成功加入" delay:DELAY];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addCart" object:self userInfo:nil];
        [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    
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
    
    UIButton *button = (UIButton *)sender;
    if ([button.currentTitle isEqualToString:@"确认"]) {
        
        FxLog(@"afssdf = %ld",userSource.count);
        self.block(storeAreaModel,userSource,self.proPriceByStoreParams.storeSelectingType);
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    SureOrdersViewController *sureOrder = [SB instantiateViewControllerWithIdentifier:@"SureOrdersViewController"];
    //资源
    sureOrder.userSourceArr = userSource;
    //商品id
    sureOrder.produceId = self.produceId;
    //商品名称
    sureOrder.fullName = produceDetail.fullName;
    //酒币类型
    sureOrder.acceptableCoinTypes = produceDetail.acceptableCoinTypes;
    //门店或区域类型和门店或区域id
    sureOrder.proPriceByStoreParams = self.proPriceByStoreParams;
    
    //商品价格
    if ([produceDetail.isPackagePrice integerValue] == 1) {
        sureOrder.proPrice = produceDetail.price;
    }else {
        sureOrder.proPrice = price;
    }
    [self.navigationController pushViewController:sureOrder animated:YES];

}

- (void)fullPackageMsg:(ProDetailBlock)block {
    
    _block = block;
}

#pragma mark UserSourceViewController Delegate
- (void)chosedUserSource:(NSArray *)array {

    userSource = array;
    NSLog(@"zdgdz = %@",userSource);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    ProDetailCell3 *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"已选%ld个酒品",array.count];
}

#pragma mark Term3Delegate
- (void)areaIdOrStoresId:(NSArray *)model type:(NSString *)type {

    FxLog(@"dzfsdg =  %@%@",model,type);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    ProDetailCell3 *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    
     [storeAreaModel addObjectsFromArray:model];
    
    if ([type isEqualToString:@"storeId"]) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (ProduceStoresModel *m in model) {
            [array addObject:m.id];
        }
        areaOrStore = [array componentsJoinedByString:@","];
        self.proPriceByStoreParams.storeIds = areaOrStore;
        self.proPriceByStoreParams.storeSelectingType = @"store";
        
        cell.titleLabel.text = [NSString stringWithFormat:@"已选%ld家门店",model.count];
        
    }else {
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in model) {
            [array addObject:[dic objectForKey:@"i"]];
        }
        areaOrStore = [array componentsJoinedByString:@","];
        
        self.proPriceByStoreParams.storeSelectingType = @"area";
        self.proPriceByStoreParams.areaIds = areaOrStore;
        
        cell.titleLabel.text = [NSString stringWithFormat:@"已选%ld个区域或门店",model.count];
    }
    
    [[HUDConfig shareHUD]alwaysShow];
    
    FxLog(@"buyNowAction = %@",self.proPriceByStoreParams.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KGetProductPriceByStoreSelection params:self.proPriceByStoreParams.mj_keyValues success:^(NSDictionary *dataDic) {

        FxLog(@"buyNowAction = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]dismiss];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            ProDetailCell1 *cell = (ProDetailCell1 *)[self.tableView cellForRowAtIndexPath:indexPath];
            cell.priceLabel.text = [NSString stringWithFormat:@"%@",[[dataDic objectForKey:@"retObj"] objectForKey:@"price"]];
            price = [NSString stringWithFormat:@"%@",[[dataDic objectForKey:@"retObj"] objectForKey:@"price"]];
            
        }else {
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
