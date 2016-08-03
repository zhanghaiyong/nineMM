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
#import "PackageDetailCell.h"
#import "Produce1Model.h"
#import "ProduceDetailViewController.h"
@interface PackageDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    PackageDetailModel *packageDetailModel;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PackageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.title = @"套餐明细";
    
    [self packageDetailData];
}

- (void)packageDetailData {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    ProduceDetailParams *params = [[ProduceDetailParams alloc]init];
    params.id = self.packageModel.id;
    
    FxLog(@"packageDetailData = %@",params.mj_keyValues);
    
    [KSMNetworkRequest postRequest:KPackageDetail params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        FxLog(@"packageDetailData = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"]integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (((NSDictionary *)[dataDic objectForKey:@"retObj"]).count !=0) {
                
                NSDictionary *retObj = [dataDic objectForKey:@"retObj"];
                packageDetailModel = [PackageDetailModel mj_objectWithKeyValues:retObj];
                [self.tableView reloadData];
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark UITableViewDelegate&&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }
    
    return packageDetailModel.products.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 80;
    }
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        return 30;
    }
    return 0;
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
        cell.namaLabel.text = packageDetailModel.name;
        cell.priceLabel.text = packageDetailModel.price;
        cell.stockLabel.text = [NSString stringWithFormat:@"库存：%@",packageDetailModel.stock];
        return cell;
        
    }else {
    
        static NSString *identifier = @"cell";
        PackageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PackageDetailCell" owner:self options:nil] lastObject];
        }
        Produce1Model *model = packageDetailModel.products[indexPath.row];
        
        cell.nameLabel.text = model.fullName;
        cell.priceLabel.text = [NSString stringWithFormat:@"%@",model.price];
        
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1) {
        
        Produce1Model *model = packageDetailModel.products[indexPath.row];
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
        produceDetail.produceId = model.id;
        [self.navigationController pushViewController:produceDetail animated:YES];
    }
}



@end
