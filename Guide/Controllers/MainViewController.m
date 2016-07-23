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
#import "Main1Cell.h"
#import "Main2Cell.h"
#import "Main3Cell.h"
#import "Main4Cell.h"
#import "SearchBar.h"
#import "TopBannersModel.h"
#import "ShortcutsModel.h"
#import "NewsModel.h"
#import "GroupButtonsModel.h"
#import "SecondBannerModel.h"
#import "MainProduceListParams.h"
#import "MainProduceModel.h"
#import "ProduceDetailViewController.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    SearchBar *searchBar;
}

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
        _produceListParams.rows = 20;
    }
    return _produceListParams;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    //隐藏
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    searchBar = [[[NSBundle mainBundle] loadNibNamed:@"SearchBar" owner:self options:nil] lastObject];
    searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    searchBar.searchTF.backgroundColor = [UIColor whiteColor];
    searchBar.backgroundColor = [UIColor clearColor];
    
    [searchBar connectTwoBlock:^{
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        MsgCenterViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"MsgCenterViewController"];
        [self.navigationController pushViewController:produceDetail animated:YES];
        
    }];
    
    searchBar.searchTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-fangdajing"]];
    //将左边的图片向右移动一定距离
    searchIcon.width +=10;
    searchIcon.contentMode = UIViewContentModeCenter;
    searchBar.searchTF.leftView = searchIcon;
    [self.view addSubview:searchBar];
    
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        
//        [self loadProduceList];
//    }];
//    [self.tableView.mj_footer beginRefreshing];
    
    //刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.produceListParams.page = 1;
        
        [self loadProduceList];
        
    }];
    
    //加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.produceListParams.page += 1;
        
        [self loadProduceList];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadProduceList {
    
    [[HUDConfig shareHUD]alwaysShow];
    
     FxLog(@"produceListParams = %@",self.produceListParams.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KHomePageProcudeList params:self.produceListParams.mj_keyValues success:^(NSDictionary *dataDic) {

        FxLog(@"loadProduceList = %@",dataDic);
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *rows = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                
                //等于1，说明是刷新
                if (self.produceListParams.page == 1) {
                    
                    self.produces = [MainProduceModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.tableView.mj_header endRefreshing];
                    
                }else {
                
                    NSArray *array = [MainProduceModel mj_objectArrayWithKeyValuesArray:rows];
                    [self.produces addObjectsFromArray:array];
                    
                    if (array.count < self.produceListParams.rows) {
                        
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }else {
                        
                        [self.tableView.mj_footer endRefreshing];
                    }
                }
                NSIndexSet *nd=[[NSIndexSet alloc]initWithIndex:3];//刷新第3个section
                [self.tableView reloadSections:nd withRowAnimation:UITableViewRowAnimationTop];
            }
            
        }else {
        
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
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
            return self.produces.count;
            break;
            
        default:
            break;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section != 2) {
        return 10;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
            return 375;
            break;
        case 1:
            return 150;
            break;
        case 2:
            return 120;
            break;
        case 3:
            return 170;
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
            
            if (self.mainStaticModel.topBanners.count > 0) {
                
                //滚动试图
                ZHYBannerView *bannerView = [cell.contentView viewWithTag:100];
                bannerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
                NSMutableArray *topImages = [NSMutableArray array];
                for (TopBannersModel *bannerModel in self.mainStaticModel.topBanners) {
                    
                    [topImages addObject:bannerModel.imageId];
                }
                bannerView.imageArray = topImages;
            }
            
            //按钮
            for (int i = 0; i<self.mainStaticModel.shortcuts.count; i++) {
                ButtonView *buttonView = [cell.contentView viewWithTag:i+101];
                ShortcutsModel *buttonModel = self.mainStaticModel.shortcuts[i];
                buttonView.isNetImage = YES;
                buttonView.labelTitle = buttonModel.title;
                buttonView.imageName = buttonModel.imageId;
            }
            
            //新资源
            if (self.mainStaticModel.news.count > 0) {
               
                NewsModel *newsModel = self.mainStaticModel.news[0];
                UILabel *title = [cell.contentView viewWithTag:112];
                title.text = newsModel.title;
                
                UILabel *subTitle = [cell.contentView viewWithTag:113];
                subTitle.text = newsModel.subtitle;
            }

            return cell;
        }
            
            break;
        case 1:{
            
            Main2Cell *cell = [[[NSBundle mainBundle] loadNibNamed:@"Main2Cell" owner:self options:nil] lastObject];
            for (int i = 0; i<self.mainStaticModel.groupButtons.count; i++) {
                UIImageView *imageV = [cell.contentView viewWithTag:i+200];
                GroupButtonsModel *groupButton = self.mainStaticModel.groupButtons[i];
                [Uitils cacheImagwWithSize:imageV.size imageID:groupButton.imageId imageV:imageV placeholder:@""];
            }
            
            
            return cell;
        }
            
            break;
        case 2:{
            
            Main3Cell *cell = [[[NSBundle mainBundle] loadNibNamed:@"Main3Cell" owner:self options:nil] lastObject];
            
            
            for (int i = 0; i<self.mainStaticModel.secondBanner.count; i++) {
                UIImageView *imageV = [cell.contentView viewWithTag:i+100];
                SecondBannerModel *groupButton = self.mainStaticModel.secondBanner[i];
                [Uitils cacheImagwWithSize:imageV.size imageID:groupButton.imageId imageV:imageV placeholder:@""];
            }
            
            return cell;
        }
            
            break;
        case 3:{
            
            Main4Cell *cell = [[[NSBundle mainBundle] loadNibNamed:@"Main4Cell" owner:self options:nil] lastObject];
            
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
            
            break;
            
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 3) {
        
        MainProduceModel *model = self.produces[indexPath.row];
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
        produceDetail.produceModel = model;
        [self.navigationController pushViewController:produceDetail animated:YES];
    }
}

-  (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offSet = scrollView.contentOffset.y;
    
    CGFloat alpha = (offSet - 64)/64;
    searchBar.backgroundColor = RGBA(231, 231, 231, alpha);
    searchBar.bottomLine.alpha = alpha;
    
    FxLog(@"%f",alpha);
}


@end
