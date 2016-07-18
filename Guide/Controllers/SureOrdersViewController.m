#import "SureOrdersViewController.h"
#import "sureOrdercell1.h"
#import "sureOrderCell2.h"
#import "sureOrderCell3.h"
#import "sureOrderFoorView.h"
#import "SourceListViewController.h"
#import "sureOrderFoorView.h"
@interface SureOrdersViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *coin;
    sureOrderCell3 *cell3;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SureOrdersViewController

//- (void)viewWillAppear:(BOOL)animated {
//
//    [super viewWillAppear:animated];
//    
//    self.hidesBottomBarWhenPushed = YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//
//    [super viewWillDisappear:animated];
//    
//    self.hidesBottomBarWhenPushed = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认下单";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

#pragma mark UITableViewDelegate&&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        return 60;
    }
    return 10;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    if (section == 2) {
        
        sureOrderFoorView *footer = [[[NSBundle mainBundle]loadNibNamed:@"sureOrderFoorView" owner:self options:nil]lastObject];
        footer.frame = CGRectMake(0, 0, self.tableView.width, 60);
        return footer;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
            return 110;
            
            break;
        case 1:
            return 80;
            break;
        case 2:
            
            return 260;
            
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:{
            sureOrdercell1 *cell1 = [[[NSBundle mainBundle] loadNibNamed:@"sureOrdercell1" owner:self options:nil] lastObject];
            cell1.sourceData = self.userSourceArr;
            return cell1;
        }
            break;
        case 1:{
            sureOrderCell2 *cell2 = [[[NSBundle mainBundle] loadNibNamed:@"sureOrderCell2" owner:self options:nil] lastObject];
            
            NSArray *coins = self.produceModel.acceptableCoinTypes;
            for (NSString *name in coins) {
                
                if ([name isEqualToString:@"golden"]) {
                    
                    cell2.button1.userInteractionEnabled = YES;
                    cell2.button1.alpha = 1;
                    cell2.image1.alpha = 1;
                }
                
                if ([name isEqualToString:@"blue"]) {
                    
                    cell2.button2.userInteractionEnabled = YES;
                    cell2.button2.alpha = 1;
                    cell2.image2.alpha = 1;
                }
                
                if ([name isEqualToString:@"red"]) {
                    
                    cell2.button3.userInteractionEnabled = YES;
                    cell2.button3.alpha = 1;
                    cell2.image3.alpha = 1;
                }
                
                if ([name isEqualToString:@"black"]) {
                    
                    cell2.button4.userInteractionEnabled = YES;
                    cell2.button4.alpha = 1;
                    cell2.image4.alpha = 1;
                }
            }
            
            [cell2 choseCoinPay:^(NSString *coinStatus) {
                
                coin = coinStatus;
                if ([coinStatus isEqualToString:@"goldenCoin"]) {
                    
                    cell3.payCoinType.text = @"支付币种：金币";
                    return;
                }
                if ([coinStatus isEqualToString:@"blueCoin"]) {
                    
                    cell3.payCoinType.text = @"支付币种：蓝币";
                    return;
                }
                if ([coinStatus isEqualToString:@"redCoin"]) {
                    
                    cell3.payCoinType.text = @"支付币种：红币";
                    return;
                }
                if ([coinStatus isEqualToString:@"blackCoin"]) {
                    
                    cell3.payCoinType.text = @"支付币种：黑币";
                    return;
                }
                
                
                
            }];
            return cell2;
        }
            
            break;
        case 2:{
            
            cell3 = [[[NSBundle mainBundle] loadNibNamed:@"sureOrderCell3" owner:self options:nil] lastObject];
            cell3.priceLabel.text = [NSString stringWithFormat:@"资源金额：%@",self.proPrice];
            return cell3;
        }
            
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
            
            if (indexPath.row == 0) {
                
                UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
                SourceListViewController *sourceList = [SB instantiateViewControllerWithIdentifier:@"SourceListViewController"];
                sourceList.userSourceArr = self.userSourceArr;
                [self.navigationController pushViewController:sourceList animated:YES];
            }
            
            break;
            
        default:
            break;
    }
}

@end
