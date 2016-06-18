//
//  ProduceDetailViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ProduceDetailViewController.h"
#import "TitleView.h"
#import "ZHYBannerView.h"
#import "ProduceOfCollectHead.h"
#import "ProduceFlowLayout.h"

#import "ProduceCell_1.h"
#import "ProduceCell_2.h"
#import "ProduceCell_3.h"
#import "Produce1Model.h"
#import "MeumList.h"
#import "ProduceDetailView1.h"

@interface ProduceDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *collection;
}
@property (strong, nonatomic)UIScrollView *backScroll;
@property (nonatomic,strong)MeumList *meumList;

@end

@implementation ProduceDetailViewController

- (MeumList *)meumList {
    
    if (_meumList == nil) {
        MeumList *meumList = [[MeumList alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, 60, 90,4*40+10)];
//        categoryList.delegate = self;
        _meumList = meumList;
       
    }
    return _meumList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationRight:@"icon_order_iphone"];
    
    [self setUp];
    
}
#pragma mark 创建子视图
- (void)setUp {

    //头部
    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 44)];
    titleView.titleArray = @[@"资源",@"详情"];
    
    [titleView TitleViewCallBack:^(NSInteger btnTag) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            switch (btnTag) {
                case 10086:
                    
                    _backScroll.contentOffset = CGPointMake(0, 0);
                    
                    break;
                case 10087:
                    _backScroll.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
                    break;
                    
                default:
                    break;
            }
            
        }];
        
    }];
    
    self.navigationItem.titleView = titleView;
    
    //滚动时图
    _backScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-49-64)];
    _backScroll.contentSize = CGSizeMake(SCREEN_WIDTH*2, _backScroll.height);
    _backScroll.pagingEnabled = YES;
    _backScroll.scrollEnabled = NO;
    _backScroll.bounces = NO;
    _backScroll.backgroundColor = backgroudColor;
    [self.view addSubview:_backScroll];
    
    ProduceDetailView1 *produceDetailView1 = [[[NSBundle mainBundle]loadNibNamed:@"ProduceDetailView1" owner:self options:nil] lastObject];
    produceDetailView1.frame = CGRectMake(0, 0, _backScroll.width, _backScroll.height);
    [_backScroll addSubview:produceDetailView1];
    
    produceDetailView1.bannerView.imageArray = @[@"001",@"002",@"001"];
    
    ProduceOfCollectHead *proOfCollectHead = [[[NSBundle mainBundle] loadNibNamed:@"ProduceOfCollectHead" owner:self options:nil] lastObject];
    proOfCollectHead.frame = CGRectMake(SCREEN_WIDTH, 0, _backScroll.width, 40);
    [proOfCollectHead ProduceOfCollectHeadBack:^(NSInteger buttonTag) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            switch (buttonTag) {
                case 200:
                    collection.contentOffset = CGPointMake(0, 0);
                    break;
                case 201:
                    collection.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
                    break;
                case 202:
                    collection.contentOffset = CGPointMake(SCREEN_WIDTH*2, 0);
                    break;
                default:
                    break;
            }
            
        }];
        
    }];
    [_backScroll addSubview:proOfCollectHead];
    

    
    collection = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, proOfCollectHead.bottom, _backScroll.width, _backScroll.height-proOfCollectHead.height) collectionViewLayout:[[ProduceFlowLayout alloc]init]];
    collection.backgroundColor = [UIColor clearColor];
    collection.dataSource = self;
    collection.delegate = self;
    collection.pagingEnabled = YES;
    collection.scrollEnabled = NO;
    [collection registerClass:[ProduceCell_1 class] forCellWithReuseIdentifier:@"CELL1"];//注册item或cell
    [collection registerClass:[ProduceCell_2 class] forCellWithReuseIdentifier:@"CELL2"];//注册item或cell
    [collection registerNib:[UINib nibWithNibName:@"ProduceCell_3" bundle:nil] forCellWithReuseIdentifier:@"ProduceCell_3"];
    collection.alwaysBounceVertical = YES;
    [_backScroll addSubview:collection];
}


#pragma mark  UICollectionDataSource&&delegate
#pragma mark  CollectionViewDelegate
//返回section数量
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//必须实现，返回每个section中item的数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
    
}


//必须实现，返回每个item的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        ProduceCell_1 *cell = [collection dequeueReusableCellWithReuseIdentifier:@"CELL1" forIndexPath:indexPath];
        Produce1Model *model = [[Produce1Model alloc]init];
        model.str1 = @"购酒商城<限时秒杀>资源位，在快喝APP首页，每天分5个时间段，进行秒杀促销。10:00/14:00:/16:00/18:00/20:00，每个时段提供只提供1个资源位。";
        model.str2 = @"购酒商城<限时秒杀>资源位，在快喝APP首页，每天分5个时间段，进行秒杀促销。10:00/14:00:/16:00/18:00/20:00，每个时段提供只提供1个资源位。";
        model.str3 = @"购酒商城<限时秒杀>资源位，在快喝APP首页，每天分5个时间段，进行秒杀促销。10:00/14:00:/16:00/18:00/20:00，每个时段提供只提供1个资源位。";
        cell.model = model;
        return cell;
    }else if (indexPath.row == 1){
    
       ProduceCell_2 *cell = [collection dequeueReusableCellWithReuseIdentifier:@"CELL2" forIndexPath:indexPath];
        NSDictionary *modelDic = @{@"投放网站":@"1919天猫旗舰店",@"具体位置":@"首页轮播",@"图片尺寸":@"320*480",@"是否设计":@"自行设计",@"档期时间":@"20天"};
        cell.modelDic = modelDic;
        return cell;
    }else {
    
       ProduceCell_3 *cell = [collection dequeueReusableCellWithReuseIdentifier:@"ProduceCell_3" forIndexPath:indexPath];
        return cell;
    }
    
    return nil;
}

- (IBAction)touchs:(id)sender {
    
    if (self.backScroll.contentOffset.x == 0) {
            self.backScroll.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    }else {
    
        self.backScroll.contentOffset = CGPointMake(0, 0);
    }

    [self updateViewConstraints];
}

- (void)doRight:(UIButton *)sender
{
    if (_meumList == nil) {
        
       [self.navigationController.view addSubview:self.meumList];
        
    }else {
     
        [_meumList removeFromSuperview];
        _meumList = nil;
    }
}

@end
