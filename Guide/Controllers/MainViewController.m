//
//  MainViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/26.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "MainViewController.h"
#import "ButtonView.h"
#import "ZHYBannerView.h"
#import "RecommendView.h"
#import "Main1Cell.h"
#import "Main2Cell.h"
#import "Main3Cell.h"
#import "Main4Cell.h"
#import "SearchBar.h"
#import "TopBannersModel.h"
#import "ButtonsModel.h"
#import "GoodsTypeModel.h"
#import "MainProduceListParams.h"
#import "MainProduceModel.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)MainProduceListParams *produceListParams;
@property (nonatomic,strong)NSMutableArray *produces;
@end

@implementation MainViewController
-(NSMutableArray *)produces {

    if (_produces == nil) {
        
        NSMutableArray *produces = [NSMutableArray array];
        _produces = produces;
    }
    return _produces;
}

-(MainProduceListParams *)produceListParams {

    if (_produceListParams == nil) {
        
        MainProduceListParams *produceListParams = [[MainProduceListParams alloc]init];
        _produceListParams = produceListParams;
        _produceListParams.rows = @"10";
    }
    return _produceListParams;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.frame = CGRectMake(0, -64, SCREEN_WIDTH, self.tableView.height);
    
    SearchBar *search = [[[NSBundle mainBundle] loadNibNamed:@"SearchBar" owner:self options:nil] lastObject];
    search.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    [self.navigationController.view addSubview:search];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadProduceList];
    }];
    [self.tableView.mj_footer beginRefreshing];
    
}

- (void)loadProduceList {
    
    [[HUDConfig shareHUD]alwaysShow];
    self.produceListParams.page = [NSString stringWithFormat:@"%ld",[self.produceListParams.page integerValue]+1];
    
    [KSMNetworkRequest postRequest:KHomePageProcudeList params:self.produceListParams.mj_keyValues success:^(NSDictionary *dataDic) {
        
        NSLog(@"produceListParams = %@",self.produceListParams.mj_keyValues);
        NSLog(@"loadProduceList = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *rows = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                [self.produces addObjectsFromArray:[MainProduceModel mj_objectArrayWithKeyValuesArray:rows]];
                
                NSIndexSet * nd=[[NSIndexSet alloc]initWithIndex:3];//刷新第二个section
                 [self.tableView reloadSections:nd withRowAnimation:UITableViewRowAnimationTop];
                
                if (rows.count < 10) {
                    
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                }else {
                
                    [self.tableView.mj_footer endRefreshing];
                }
            }
        }else {
        
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
        [[HUDConfig shareHUD]Tips :error.localizedDescription delay:DELAY];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark UITableViewDelegate&&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return self.produces.count;;
            break;
            
        default:
            break;
    }
    return 0;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//    return 1;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
            return 400;
            break;
        case 1:
            return 140;
            break;
        case 2:
            return 80;
            break;
        case 3:
            return 180;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0: {
            
            Main1Cell *cell = [[[NSBundle mainBundle] loadNibNamed:@"Main1Cell" owner:self options:nil] lastObject];
            //滚动试图
            ZHYBannerView *bannerView = [cell.contentView viewWithTag:100];
            NSMutableArray *topImages = [NSMutableArray array];
            for (TopBannersModel *bannerModel in self.mainStaticModel.topBanners) {
                
                [topImages addObject:bannerModel.imageId];
            }
            bannerView.imageArray = topImages;
            //按钮
            for (int i = 0; i<self.mainStaticModel.buttons.count; i++) {
                ButtonView *buttonView = [cell viewWithTag:i+101];
                ButtonsModel *buttonModel = self.mainStaticModel.buttons[i];
                buttonView.labelTitle = buttonModel.imageId;
                buttonView.imageName = buttonModel.imageId;
            }
            
            //新资源
            for (int i = 0; i<self.mainStaticModel.goodsTypes.count; i++) {
                UILabel *label = [cell viewWithTag:i+111];
                GoodsTypeModel *goodType = self.mainStaticModel.goodsTypes[i];
                label.text = goodType.title;
            }
            return cell;
        }
            
            break;
        case 1:{
            
            Main2Cell *cell = [[[NSBundle mainBundle] loadNibNamed:@"Main2Cell" owner:self options:nil] lastObject];
            return cell;
        }
            
            break;
        case 2:{
            
            Main3Cell *cell = [[[NSBundle mainBundle] loadNibNamed:@"Main3Cell" owner:self options:nil] lastObject];
            return cell;
        }
            
            break;
        case 3:{
            
            Main4Cell *cell = [[[NSBundle mainBundle] loadNibNamed:@"Main4Cell" owner:self options:nil] lastObject];
            
            MainProduceModel *model = self.produces[indexPath.row];
            UIImageView *imagV = [cell.contentView viewWithTag:100];
            imagV.image = [UIImage imageNamed:model.imageId];
            
            UILabel *label1 = [cell.contentView viewWithTag:101];
            label1.text = model.fullName;
            
            UILabel *label3 = [cell.contentView viewWithTag:103];
            label3.text = model.price;
            
            UILabel *label4 = [cell.contentView viewWithTag:104];
            label4.text = model.marketPrice;
            
            return cell;
        }
            
            break;
            
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 3) {
        

    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {

    return YES;
}

-  (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offSet = scrollView.contentOffset.y;
    
    CGFloat alpha = (64 - offSet)/64;
    self.navigationController.navigationBar.alpha = alpha;
    
    NSLog(@"%f",alpha);
}


@end
