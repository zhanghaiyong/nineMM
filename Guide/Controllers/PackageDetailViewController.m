//
//  PackageDetailViewController.m
//  Guide
//
//  Created by 张海勇 on 16/8/3.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "PackageDetailViewController.h"
#import "ProduceDetailParams.h"
#import "PackageDetailModel.h"
#import "PackageDetailHeadCell.h"
#import "Produce1Model.h"
#import "ProduceDetailViewController.h"
#import "PackageDetailCell1.h"
#import "PackageDetailCell2.h"
#import "PackageDetailCell3.h"
#import "SureOrdersViewController.h"
#import "AppSubOrderParams.h"
@interface PackageDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    PackageDetailModel *packageDetailModel;
    NSMutableArray     *userSource;
    NSMutableArray     *storeOrAreaModel;
    NSMutableArray     *store_Area;
    
    
    NSMutableArray     *allSource;
    NSMutableArray     *allStore;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) AppSubOrderParams *params;
@end

@implementation PackageDetailViewController

-(AppSubOrderParams *)params {
    
    if (_params == nil) {
        
        AppSubOrderParams *params = [[AppSubOrderParams alloc]init];
        params.amount = [self.packageModel.price intValue];
        _params = params;
        
    }
    return _params;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.title = @"套餐明细";
    allSource = [NSMutableArray array];
    allStore  = [NSMutableArray array];
    store_Area  = [NSMutableArray array];
    
    for (int i = 0; i<self.packageModel.acceptableCoinTypes.count; i++) {
        
        UIImageView *coinImg = (UIImageView *)[self.view viewWithTag:i+100];
        coinImg.hidden = NO;
        coinImg.image  = [UIImage imageNamed:[Uitils toImageName:self.packageModel.acceptableCoinTypes[i]]];
    }
    
    self.priceLabel.text = self.packageModel.price;
    
    storeOrAreaModel = [NSMutableArray array];
    userSource = [NSMutableArray array];
    
    [self packageDetailData];
}

- (void)packageDetailData {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    ProduceDetailParams *params = [[ProduceDetailParams alloc]init];
    params.id = self.packageModel.id;
    
    FxLog(@"packageDetailData = %@",params.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KPackageDetail params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        FxLog(@"packageDetailData = %@",dataDic);
        
        [[HUDConfig shareHUD]dismiss];
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
//            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (((NSDictionary *)[dataDic objectForKey:@"retObj"]).count !=0) {
                
                NSDictionary *retObj = [dataDic objectForKey:@"retObj"];
                packageDetailModel = [PackageDetailModel mj_objectWithKeyValues:retObj];
                
                for (int i = 0; i < packageDetailModel.products.count; i++) {
                    
                    [allSource addObject:@"0"];
                    [allStore  addObject:@"0"];
                    [store_Area addObject:@"0"];
                }
                
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
            
        }else {
        
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark UITableViewDelegate&&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return packageDetailModel.products.count+1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
        
    }else {
    
//        if (packageDetailModel) {
//            Produce1Model *model = packageDetailModel.products[section-1];
//            
//            NSInteger row = 1;
//            if ([model.itemSelecting integerValue] != -1) {
//                row ++;
//            }
//            
//            if ([model.shopSelecting integerValue] != 0) {
//                row ++;
//            }
//            return row;
//        }
        return 3;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 80;
    }else {
    
        if (packageDetailModel) {
            Produce1Model *model = packageDetailModel.products[indexPath.section-1];
            
            switch (indexPath.row) {
                case 0:{
                
                    return 40;
                }
                    break;
                case 1:{
                
                    if ([model.shopSelecting integerValue] == 0) {
                        return 0;
                    }else {
                        
                        return 40;
                    }
                }
                    break;
                case 2:{
                
                    if ([model.itemSelecting integerValue] == -1) {
                        return 0;
                    }else {
                        
                        return 40;
                    }
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        return 40;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        return 30;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 1) {
     
        UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        headLabel.textColor = HEX_RGB(0x666666);
        headLabel.text = @"  套餐详情";
        headLabel.font = lever2Font;
        headLabel.backgroundColor = backgroudColor;
        return headLabel;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        static NSString *identifier = @"headCell";
        PackageDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PackageDetailHeadCell" owner:self options:nil] lastObject];
        }
        
        if (packageDetailModel) {
            cell.namaLabel.text = packageDetailModel.name;
            cell.priceLabel.text = packageDetailModel.price;
            cell.stockLabel.text = [NSString stringWithFormat:@"库存：%@",packageDetailModel.stock];
        }
        return cell;
        
    }else {
    
        Produce1Model *model = packageDetailModel.products[indexPath.section-1];
        
        switch (indexPath.row) {
            case 0:{
                PackageDetailCell1 *cell1 = [[[NSBundle mainBundle] loadNibNamed:@"PackageDetailCell1" owner:self options:nil] lastObject];
                cell1.namaLabel.text = model.fullName;
                cell1.priceLabel.text = model.price;
                return cell1;
            }
                break;
            case 1:{
                PackageDetailCell2 *cell2 = [[[NSBundle mainBundle] loadNibNamed:@"PackageDetailCell2" owner:self options:nil] lastObject];
                
                if (storeOrAreaModel.count > 0) {
                    cell2.areaLabel.text = [NSString stringWithFormat:@"%ld个门店/区域",storeOrAreaModel.count];
                }
                
                return cell2;
            }
                break;
            case 2:{
                PackageDetailCell3 *cell3 = [[[NSBundle mainBundle] loadNibNamed:@"PackageDetailCell3" owner:self options:nil] lastObject];
                
                if (userSource.count > 0) {
                    NSLog(@"afssdf = %ld",userSource.count);
                    cell3.sourceLabel.text = [NSString stringWithFormat:@"%ld个酒品",userSource.count];
                }
                return cell3;
            }
                
                break;
                
            default:
                break;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section != 0) {
        
        Produce1Model *model = packageDetailModel.products[indexPath.section-1];
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
        
        [produceDetail fullPackageMsg:^(NSArray *storeAreaModel, NSArray *sources, NSString *storeOrArea) {
            
            if (sources.count > 0) {
                
                if (![allSource[indexPath.section-1] isKindOfClass:[NSArray class]]) {
                    
                    [allSource replaceObjectAtIndex:indexPath.section-1 withObject:sources];
                    
                }else {
                    
                    [allSource replaceObjectAtIndex:indexPath.section-1 withObject:@"0"];
                }
            }

            
            if (storeAreaModel.count > 0) {
                
                if (![allStore[indexPath.section-1] isKindOfClass:[NSArray class]]) {
                    
                    [allStore replaceObjectAtIndex:indexPath.section-1 withObject:storeAreaModel];
                    
                }else {
                    
                    [allStore replaceObjectAtIndex:indexPath.section-1 withObject:@"0"];
                }
            }

            
            if (storeOrArea.length > 0) {
                
                if (![store_Area[indexPath.section -1] isEqualToString:@"0"]) {
                    
                    [store_Area replaceObjectAtIndex:indexPath.section-1 withObject:storeOrArea];
                }else {
                    
                    [store_Area replaceObjectAtIndex:indexPath.section-1 withObject:@"0"];
                }
            }
            
            [userSource removeAllObjects];
            [userSource addObjectsFromArray:sources];
            [storeOrAreaModel removeAllObjects];
            [storeOrAreaModel addObjectsFromArray:storeAreaModel];
            
            NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:indexPath.section];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
            
        }];
        
        produceDetail.produceId = model.id;
        produceDetail.fromPackage = YES;
        [self.navigationController pushViewController:produceDetail animated:YES];
    }
}

- (IBAction)nowBuyPackageAction:(id)sender {
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    SureOrdersViewController *sureOrder = [SB instantiateViewControllerWithIdentifier:@"SureOrdersViewController"];
    sureOrder.allSource = allSource;
    sureOrder.allStoreArea = allStore;
    
    NSLog(@"allSource = %@",allSource);
    NSLog(@"allStore = %@",allStore);

    sureOrder.packageId = packageDetailModel.id;
    sureOrder.storeOrArea = store_Area;
    sureOrder.acceptableCoinTypes = self.packageModel.acceptableCoinTypes;
    sureOrder.packageproduce = packageDetailModel.products;
    sureOrder.proPrice = packageDetailModel.price;
    sureOrder.produceId = self.packageModel.id;
    
    [self.navigationController pushViewController:sureOrder animated:YES];
    
}
@end
