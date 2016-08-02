#import "PersonalViewController.h"
#import "ButtonView.h"
#import "OrderTypeTableVC.h"
#import "OrderComplainCtrl.h"
#import "PersionModel.h"
#import "MyCoinsController.h"
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,ButtonViewDeleage>
{
    PersionModel *persionModel;
}
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userType;
@property (weak, nonatomic) IBOutlet UILabel *collectCount;
@property (weak, nonatomic) IBOutlet UILabel *browseCount;
@end

@implementation PersonalViewController

- (void)awakeFromNib {

    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell1  = [self.tableView cellForRowAtIndexPath:indexPath1];
    
    NSArray *images         = @[@"全部订单",@"待审核",@"已取消",@"执行中",@"申诉订单"];
    NSArray *titles         = @[@"全部订单",@"待审核",@"已取消",@"执行中",@"申诉订单"];
    
    for (int i = 0; i<5; i++) {
        //订单
        ButtonView *orderBV = (ButtonView *)[cell1.contentView viewWithTag:i+100];
        orderBV.delegate = self;
        orderBV.size = CGSizeMake(SCREEN_WIDTH/5, 60);
        orderBV.imageSize = CGSizeMake(22, 22);
        orderBV.labelTitle = titles[i];
        orderBV.imageName  = images[i];
    }
}

//隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.frame = CGRectMake(0, -20, SCREEN_WIDTH, self.tableView.height);
    
        //刷新
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self loadPersionData];
        }];
    if (!persionModel) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearPersionModel:) name:@"clearPersionDara" object:nil];

}

- (void)clearPersionModel:(NSNotification *)sender {

    persionModel = nil;
}

- (void)loadPersionData {

    [[HUDConfig shareHUD]alwaysShow];
    
    BaseParams *params = [[BaseParams alloc]init];
    [KSMNetworkRequest postRequest:KPersionCenter params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"PersionData = %@",dataDic);
        
        [self.tableView.mj_header endRefreshing];
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                persionModel = [PersionModel mj_objectWithKeyValues:[dataDic objectForKey:@"retObj"]];
                
                
                NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:0 inSection:1];
                UITableViewCell *cell2  = [self.tableView cellForRowAtIndexPath:indexPath2];

                for (int i = 0; i<persionModel.coins.count; i++) {
                    
                    NSDictionary *dic  = persionModel.coins[i];
//                    ButtonView *coinBV = (ButtonView *)[cell2.contentView viewWithTag:i+200];
//                    coinBV.labelTitle = [Uitils toChinses:dic.allKeys[0]];
//                    coinBV.imageName =  [Uitils toImageName:dic.allKeys[0]];
                    ButtonView *coinBV = [[ButtonView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH/persionModel.coins.count, 44, SCREEN_WIDTH/persionModel.coins.count, cell2.height) title:[Uitils toChinses:dic.allKeys[0]] image:[Uitils toImageName:dic.allKeys[0]]];
                    coinBV.imageSize = CGSizeMake(25, 25);
                    [cell2.contentView addSubview:coinBV];
                }
                
                //头像
                [Uitils cacheImagwWithSize:_avatar.size imageID:[persionModel.memberInfo objectForKey:@"avatarImgId"] imageV:_avatar placeholder:@"组-23"];
                //用户名
                _userName.text = [persionModel.memberInfo objectForKey:@"departmentName"];
                _userType.text = [persionModel.memberInfo objectForKey:@"nick"];
                //收藏
                _collectCount.text = [NSString stringWithFormat:@"%@",[persionModel.data objectForKey:@"favoriteCount"]];
                //浏览
                _browseCount.text = [NSString stringWithFormat:@"%@",[persionModel.data objectForKey:@"noticeCount"]];
            }
            
        }else if ([[dataDic objectForKey:@"retCode"]integerValue] == -2){
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            LoginViewController *loginVC = [SB instantiateViewControllerWithIdentifier:@"LoginViewController"];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
            [self presentViewController:navi animated:YES completion:^{
                
                self.tabBarController.selectedIndex = 0;
                
            }];
        }
        
    } failure:^(NSError *error) {
       
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 2) {
        
        [[HUDConfig shareHUD]Tips:@"即将上线，敬请期待" delay:DELAY];
    }
}


#pragma mark UITableViewDelegate&&DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

- (IBAction)msgCenterAction:(id)sender {
    
     [[HUDConfig shareHUD]Tips:@"即将上线，敬请期待" delay:DELAY];
}

/**
 *  ButtonViewDeleage
 *
 *  @param aFlag buttonView的tag
 */
- (void)buttonViewTap:(NSInteger)aFlag {

    FxLog(@"ButtonViewTag = %ld",aFlag);
    
    if (aFlag == 100 || aFlag == 101 || aFlag == 102 || aFlag == 103 || aFlag == 104) {
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        OrderTypeTableVC *orderType = [mainSB instantiateViewControllerWithIdentifier:@"OrderTypeTableVC"];
        orderType.orderType = aFlag;
        [self.navigationController pushViewController:orderType animated:YES];
    }
//    else if () {
//    
//        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
//        OrderComplainCtrl *OrderComplain = [mainSB instantiateViewControllerWithIdentifier:@"OrderComplainCtrl"];
//        [self.navigationController pushViewController:OrderComplain animated:YES];
//    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"toCoinDetail"]) {
        
        MyCoinsController *destination = (MyCoinsController *)segue.destinationViewController;
        destination.persionModel = persionModel;
    }
}

@end
