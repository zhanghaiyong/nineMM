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
#import "CategoryList.h"

@interface ProduceDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *collection;
}
@property (strong, nonatomic)UIScrollView *backScroll;
@property (nonatomic,strong)CategoryList *categoryList;

@end

@implementation ProduceDetailViewController

- (CategoryList *)categoryList {
    
    if (_categoryList == nil) {
        CategoryList *categoryList = [[CategoryList alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 0, 90,5*40+10)];
//        categoryList.delegate = self;
        _categoryList = categoryList;
        [self.view addSubview:categoryList];
    }
    return _categoryList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
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
    _backScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    _backScroll.contentSize = CGSizeMake(SCREEN_WIDTH*2, _backScroll.height);
    _backScroll.pagingEnabled = YES;
    _backScroll.scrollEnabled = NO;
    _backScroll.bounces = NO;
    _backScroll.backgroundColor = backgroudColor;
    [self.view addSubview:_backScroll];
    
    //scroller第一部分
    ZHYBannerView *banner = [[ZHYBannerView alloc]initWithFrame:CGRectMake(0, 0, _backScroll.width, 200)];
    banner.imageArray = @[@"icon_me_selected_iphone",@"icon_me_selected_iphone",@"icon_me_selected_iphone"];
    [_backScroll addSubview:banner];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, banner.bottom, _backScroll.width, 50)];
    textView.editable = NO;
    textView.backgroundColor = [UIColor clearColor];
    textView.textColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:15];
    textView.text = @"1919天猫旗舰店PC端首页推广大图点击进入单品详情直接购买或二级专题页面";
    [_backScroll addSubview:textView];
    
    //促销
    UILabel *cx = [[UILabel alloc]initWithFrame:CGRectMake(10, textView.bottom, _backScroll.width, 30)];
    cx.text = @"【限时促销】6折优惠，限时抢购";
    cx.textColor = [UIColor redColor];
    cx.font = [UIFont systemFontOfSize:15];
    [_backScroll addSubview:cx];
    
    //价格
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(10, cx.bottom,200, 30)];
    price.text = @"￥35000.00";
    price.textColor = [UIColor redColor];
    price.font = [UIFont boldSystemFontOfSize:17];
    [_backScroll addSubview:price];
    
    //限时优惠 图片
    UIImageView *yhIgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, price.bottom, 100, 30)];
    yhIgView.image = [UIImage imageNamed:@"icon_male_iphone"];
    [_backScroll addSubview:yhIgView];
    
    //省多少钱
    UILabel *GMLS = [[UILabel alloc]initWithFrame:CGRectMake(yhIgView.right+5, price.bottom, _backScroll.width-100, 30)];
    GMLS.text = @"购买立省15000酒币";
    GMLS.textColor = [UIColor redColor];
    GMLS.font = [UIFont systemFontOfSize:15];
    [_backScroll addSubview:GMLS];
    
    //分割线
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, GMLS.bottom, _backScroll.width, 1)];
    line1.backgroundColor = [UIColor blackColor];
    [_backScroll addSubview:line1];
    
    //选择商品资源
    UIButton *proSource = [[UIButton alloc]initWithFrame:CGRectMake(10, line1.bottom, SCREEN_WIDTH-10, 30)];
    [proSource setTitle:@"请选择指定商品使用该资源" forState:UIControlStateNormal];
    [proSource setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    proSource.titleLabel.font = [UIFont systemFontOfSize:15];
    proSource.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_backScroll addSubview:proSource];
    
    //箭头
    UILabel *arrow = [[UILabel alloc]initWithFrame:CGRectMake(_backScroll.width-40, line1.bottom, 30, 30)];
    arrow.text = @"➤";
    arrow.textColor = [UIColor blackColor];
    arrow.font = [UIFont boldSystemFontOfSize:15];
    [_backScroll addSubview:arrow];
    
    //分割线
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, proSource.bottom, _backScroll.width, 1)];
    line2.backgroundColor = [UIColor blackColor];
    [_backScroll addSubview:line2];
    
    ProduceOfCollectHead *proOfCollectHead = [[[NSBundle mainBundle] loadNibNamed:@"ProduceOfCollectHead" owner:self options:nil] lastObject];
    proOfCollectHead.frame = CGRectMake(SCREEN_WIDTH, 0, _backScroll.width, 30);
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
    

    
    collection = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, proOfCollectHead.bottom, _backScroll.width, _backScroll.height-30) collectionViewLayout:[[ProduceFlowLayout alloc]init]];
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
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
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
 
    self.categoryList.arrowX = SCREEN_WIDTH-30;
}

@end
