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
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MainViewController
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.alpha = 0;
    
    SearchBar *search = [[[NSBundle mainBundle] loadNibNamed:@"SearchBar" owner:self options:nil] lastObject];
    search.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    [self.navigationController.view addSubview:search];
    NSLog(@"xozfsdfsd %@",self.mainStaticModel);
    
    
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
            return 4;
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
            return 130;
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
            return cell;
        }
            
            break;
            
        default:
            break;
    }
    return nil;
}

-  (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offSet = scrollView.contentOffset.y;
    
    CGFloat alpha = (offSet - 64)/64;
    self.navigationController.navigationBar.alpha = alpha;
    
    NSLog(@"%f",alpha);
}


@end
