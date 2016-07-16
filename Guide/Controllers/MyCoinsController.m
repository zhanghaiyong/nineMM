#import "MyCoinsController.h"
//#import "TitleView.h"
#import "CoinsDetailViewCtrl.h"
@interface MyCoinsController ()

@property (weak, nonatomic) IBOutlet UILabel *golden;
@property (weak, nonatomic) IBOutlet UILabel *black;
@property (weak, nonatomic) IBOutlet UILabel *red;
@property (weak, nonatomic) IBOutlet UILabel *blue;
@property (weak, nonatomic) IBOutlet UILabel *green;
@end

@implementation MyCoinsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的酒币";
    
    NSLog(@"我的酒币 = %@",self.persionModel);
    
//    //头部
//    TitleView *titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    titleView.normalColor = lever2Color;
//    titleView.backgroundColor = [UIColor whiteColor];
//    titleView.selectedColor = specialRed;
//    titleView.titleArray = @[@"全部",@"金币",@"绿币",@"黑币",@"红币",@"蓝币"];
//    
//    [titleView TitleViewCallBack:^(NSInteger btnTag) {
//        
//    }];
//    
//    self.tableView.tableHeaderView = titleView;
    //用户信息
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell1 = [self.tableView cellForRowAtIndexPath:index1];
    UIImageView *avatar = [cell1.contentView viewWithTag:100];
    [Uitils cacheImagwWithSize:avatar.size imageID:[self.persionModel.memberInfo objectForKey:@"avatarImgId"] imageV:avatar placeholder:nil];
    
    UILabel *userName = [cell1.contentView viewWithTag:101];
    userName.text = [self.persionModel.memberInfo objectForKey:@"departmentName"];
    UILabel *userType = [cell1.contentView viewWithTag:102];
    userType.text = [self.persionModel.memberInfo objectForKey:@"nick"];
    
    //金币
    for (NSDictionary *coinDic in self.persionModel.coins) {
        
        if ([coinDic.allKeys containsObject:@"black"]) {
            
            self.black.text = [NSString stringWithFormat:@"%@",[coinDic objectForKey:@"black"]];
            
        }else if ([coinDic.allKeys containsObject:@"red"]) {
            
            self.red.text = [NSString stringWithFormat:@"%@",[coinDic objectForKey:@"red"]];
            
        }else if ([coinDic.allKeys containsObject:@"blue"]) {
            
            self.blue.text = [NSString stringWithFormat:@"%@",[coinDic objectForKey:@"blue"]];
            
        }else if ([coinDic.allKeys containsObject:@"golden"]) {
            
            self.golden.text = [NSString stringWithFormat:@"%@",[coinDic objectForKey:@"golden"]];
            
        }else {
        
            self.green.text = [NSString stringWithFormat:@"%@",[coinDic objectForKey:@"green"]];
        }
        
        
    }
    
    
}


#pragma mark UITableView Delegate &&DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}
@end
