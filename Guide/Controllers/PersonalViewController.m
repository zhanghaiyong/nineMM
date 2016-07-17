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
    
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:0 inSection:1];
    UITableViewCell *cell2  = [self.tableView cellForRowAtIndexPath:indexPath2];
    
    NSArray *images         = @[@"全部订单",@"待审核",@"已取消",@"执行中",@"申诉订单"];
    NSArray *titles         = @[@"全部订单",@"待审核",@"已取消",@"执行中",@"申诉订单"];
    NSArray *iconNames      = @[@"金币",@"绿币",@"红币",@"蓝币",@"黑币"];
    NSArray *iconImage      = @[@"图层-142",@"图层-145",@"图层-143",@"图层-146",@"图层-144"];
    
    for (int i = 0; i<5; i++) {
        //订单
        ButtonView *orderBV = (ButtonView *)[cell1.contentView viewWithTag:i+100];
        orderBV.delegate = self;
        orderBV.labelTitle = titles[i];
        orderBV.imageName  = images[i];
        
        //金币
        ButtonView *coinBV = (ButtonView *)[cell2.contentView viewWithTag:i+200];
        coinBV.delegate = self;
        coinBV.labelTitle = iconNames[i];
        coinBV.imageName  = iconImage[i];
    }
}

//隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.frame = CGRectMake(0, -20, SCREEN_WIDTH, self.tableView.height);
    
    if (!persionModel) {
        [self loadPersionData];

    }
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadPersionData {

    [[HUDConfig shareHUD]alwaysShow];
    
    BaseParams *params = [[BaseParams alloc]init];
    [KSMNetworkRequest postRequest:KPersionCenter params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"PersionData = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                persionModel = [PersionModel mj_objectWithKeyValues:[dataDic objectForKey:@"retObj"]];
                
                //头像
                [Uitils cacheImagwWithSize:_avatar.size imageID:[persionModel.memberInfo objectForKey:@"avatarImgId"] imageV:_avatar placeholder:nil];
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
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
        }
        
    } failure:^(NSError *error) {
       
         [[HUDConfig shareHUD]ErrorHUD:error.localizedDescription delay:DELAY];
    }];
}


#pragma mark UITableViewDelegate&&DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

/**
 *  ButtonViewDeleage
 *
 *  @param aFlag buttonView的tag
 */
- (void)buttonViewTap:(NSInteger)aFlag {

    FxLog(@"ButtonViewTag = %ld",aFlag);
    
    if (aFlag == 100 || aFlag == 101 || aFlag == 102 || aFlag == 103) {
        
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        OrderTypeTableVC *orderType = [mainSB instantiateViewControllerWithIdentifier:@"OrderTypeTableVC"];
        orderType.orderType = aFlag;
        [self.navigationController pushViewController:orderType animated:YES];
    }else if (aFlag == 104) {
    
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        OrderComplainCtrl *OrderComplain = [mainSB instantiateViewControllerWithIdentifier:@"OrderComplainCtrl"];
        [self.navigationController pushViewController:OrderComplain animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"toCoinDetail"]) {
        
        MyCoinsController *destination = (MyCoinsController *)segue.destinationViewController;
        destination.persionModel = persionModel;
    }
}

@end
