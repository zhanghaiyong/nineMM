#import "PersonalViewController.h"
#import "ButtonView.h"
#import "OrderTypeTableVC.h"
#import "OrderComplainCtrl.h"
#import "PersionModel.h"
#import "MyCoinsController.h"
#import "TakePhotoViewController.h"
#import <AFNetworking.h>
#import "UpdateAvatarParams.h"
#import "UpdateUserInfoParams.h"
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,ButtonViewDeleage,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    PersionModel *persionModel;
    NSData *avatarData;
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

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToSetAvatar)];
    [self.avatar addGestureRecognizer:tap];
}

- (void)tapToSetAvatar {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self takePhoto];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self LocalPhoto];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark customAction-----------------------
#pragma mark 开始拍照
-(void)takePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{}];
    }else {
        KSMLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

#pragma mark 打开本地相册
-(void)LocalPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{}];
}


#pragma  mark  UIImagePickerDelegate-----------------
#pragma mark 当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        UIImage *newImage = [Uitils imageWithImage:image scaledToSize:self.avatar.size];
        avatarData = UIImageJPEGRepresentation(newImage, 1);
        
        [self performSelector:@selector(delayShowAlert) withObject:self afterDelay:1];
        
        self.avatar.image = image;
        
        [picker dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (void)delayShowAlert {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否上传？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self postAvatar];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)postAvatar {

    [[HUDConfig shareHUD]alwaysShow];
    
    UpdateAvatarParams *avatarParams = [[UpdateAvatarParams alloc]init];
    avatarParams.category = @"avatar";
    avatarParams.fileTitle = @"userAvatar";
    avatarParams.fileIntro = @"userAvatar";
    
    NSLog(@"updateParams = %@",avatarParams.mj_keyValues);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    
    [manager POST:KUpdateAvatar parameters:avatarParams.mj_keyValues constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //name是文件参数   filename是存储到服务器的名字
        [formData appendPartWithFileData:avatarData name:@"file" fileName:@"userAvatar.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传陈宫 = %@",responseObject);
        
        if ([[responseObject objectForKey:@"retCode"] integerValue] == 0) {
            
            UpdateUserInfoParams *infoParams = [[UpdateUserInfoParams alloc]init];
            infoParams.avatarId = [[responseObject objectForKey:@"retObj"] objectForKey:@"imgId"];
            
            [KSMNetworkRequest postRequest:KUpdateUserInfo params:infoParams.mj_keyValues success:^(NSDictionary *dataDic) {
                
                NSLog(@"更新头像ID ＝ %@",dataDic);
                
                if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
                    
                    [[HUDConfig shareHUD]SuccessHUD:@"上传成功" delay:DELAY];
                }
                
                
            } failure:^(NSError *error) {
                
                [[HUDConfig shareHUD]ErrorHUD:@"上传失败" delay:DELAY];
                
            }];
        }else {
        
             [[HUDConfig shareHUD]ErrorHUD:@"上传失败" delay:DELAY];
            [[HUDConfig shareHUD]dismiss];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        [[HUDConfig shareHUD]dismiss];
         [[HUDConfig shareHUD]ErrorHUD:@"上传失败" delay:DELAY];
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    KSMLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


- (void)clearPersionModel:(NSNotification *)sender {

    persionModel = nil;
    //头像
    _avatar.image = [UIImage imageNamed:@"组-23"];
    //用户名
    _userName.text = @"";
    _userType.text = @"";
    //收藏
    _collectCount.text = @"0";
    //浏览
    _browseCount.text = @"0";
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
                    ButtonView *coinBV = [[ButtonView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH/persionModel.coins.count, 44, SCREEN_WIDTH/persionModel.coins.count, cell2.height) title:[Uitils toChinses:dic.allKeys[0]] image:[Uitils toImageName:dic.allKeys[0]]];
                    coinBV.imageSize = CGSizeMake(25, 25);
                    [cell2.contentView addSubview:coinBV];
                }
                
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
                
                self.tabBarController.selectedIndex = 0;
                
            }];
        }
        
    } failure:^(NSError *error) {
       
        [self.tableView.mj_header endRefreshing];
    }];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (indexPath.section == 2) {
//        
//        [[HUDConfig shareHUD]Tips:@"即将上线，敬请期待" delay:DELAY];
//    }
//}


#pragma mark UITableViewDelegate&&DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

- (IBAction)logoutAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否注销此账号?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [Uitils UserDefaultRemoveObjectForKey:TOKEN];
        [Uitils UserDefaultRemoveObjectForKey:PASSWORD];
        self.tabBarController.selectedIndex = 0;
        
         persionModel = nil;
        //头像
        _avatar.image = [UIImage imageNamed:@"组-23"];
        //用户名
        _userName.text = @"";
        _userType.text = @"";
        //收藏
        _collectCount.text = @"0";
        //浏览
        _browseCount.text = @"0";
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
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
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"toCoinDetail"]) {
        
        MyCoinsController *destination = (MyCoinsController *)segue.destinationViewController;
        destination.persionModel = persionModel;
    }
}

@end
