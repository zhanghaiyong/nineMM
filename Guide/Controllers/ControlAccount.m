#import "ControlAccount.h"
#import "MemberInfoModel.h"
#import <AFNetworking.h>
#import "UpdateAvatarParams.h"
#import "UpdateUserInfoParams.h"
#import "ModifyEmail.h"
@interface ControlAccount ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{

    MemberInfoModel *memberInfo;
    NSData *avatarData;
}
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *userCode;
@property (weak, nonatomic) IBOutlet UILabel *userType;
@property (weak, nonatomic) IBOutlet UILabel *userLevel;
@end

@implementation ControlAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的帐户";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToSetAvatar)];
    [self.avatar addGestureRecognizer:tap];
    
    [self getLoginMemberInfo];
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
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"clearPersionDara" object:self userInfo:nil];
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


- (void)getLoginMemberInfo {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    BaseParams *params = [[BaseParams alloc]init];
    
    [KSMNetworkRequest postRequest:KLoginMemberInfo params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"getLoginMemberInfo = %@",dataDic);
        
        [self.tableView.mj_header endRefreshing];
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                memberInfo = [MemberInfoModel mj_objectWithKeyValues:[dataDic objectForKey:@"retObj"]];
                
                
                [Uitils cacheImagwWithSize:_avatar.size imageID:memberInfo.avatarId imageV:_avatar placeholder:nil];
                self.name.text = memberInfo.name;
                self.ID.text = memberInfo.username;
                self.phone.text = memberInfo.phone;
                self.email.text = memberInfo.email;
                self.userCode.text = memberInfo.id;
                self.userType.text = memberInfo.typeName;
                self.userLevel.text = memberInfo.levelName;
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)logoutAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否注销此账号?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [Uitils UserDefaultRemoveObjectForKey:TOKEN];
        [Uitils UserDefaultRemoveObjectForKey:PASSWORD];
        self.tabBarController.selectedIndex = 0;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clearPersionDara" object:self userInfo:nil];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark UITableViewDelegate&&UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (section == 1) {
        return 0.1;
    }
    return 11;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.section == 0) {
    
        NSString *title;
        switch (indexPath.row) {
            case 0:
                title = ModifyName;
                break;
            case 1:
                title = ModifyPhone;
                break;
            case 2:
                title = ModifyEmai;
                break;
                
            default:
                break;
        }
    
        UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
        ModifyEmail *modifyEmail = [SB instantiateViewControllerWithIdentifier:@"ModifyEmail"];
        
        modifyEmail.title = title;
        
        
        [modifyEmail returnModifiedEmail:^(NSString *modifiedString, NSString *type) {
            
            if ([type isEqualToString:ModifyName]) {
                
                self.name.text = modifiedString;
                
            }else if ([type isEqualToString:ModifyPhone]) {
                
                self.phone.text = modifiedString;
            }else {
                
                self.email.text = modifiedString;
            }
        }];
        [self.navigationController pushViewController:modifyEmail animated:YES];
        
    }
}

@end
