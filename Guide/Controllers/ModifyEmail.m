
#import "ModifyEmail.h"
#import "UpdateUserInfoParams.h"

@interface ModifyEmail ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTF;

@end

@implementation ModifyEmail

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.emailTF.placeholder = [self.title substringFromIndex:2];
    
}

- (IBAction)updateAction:(id)sender {
        
    [self postData];
}

- (void)postData {

    
    if (self.emailTF.text.length == 0) {
        
        [[HUDConfig shareHUD]Tips:@"内容不能为空" delay:DELAY];
        return;
    }
    
    [[HUDConfig shareHUD]alwaysShow];
    
    UpdateUserInfoParams *params = [[UpdateUserInfoParams alloc]init];
    
    if ([self.title isEqualToString:ModifyName]) {
        params.name = self.emailTF.text;
    }else if ([self.title isEqualToString:ModifyPhone]) {
        
        if (![self.emailTF.text isMobilphone]) {
            
            [[HUDConfig shareHUD]Tips:@"请输入正确的手机号" delay:DELAY];
            return;
        }
        params.phone = self.emailTF.text;
        
    }else {
    
        if (![self.emailTF.text isEmail]) {
            
            [[HUDConfig shareHUD]Tips:@"请输入正确的邮箱" delay:DELAY];
            return;
        }
        params.email = self.emailTF.text;
    }
    
    [KSMNetworkRequest postRequest:KModifyInfo params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"KUpdateEmail = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            self.block(self.emailTF.text,self.title);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"clearPersionData" object:self userInfo:nil];
            [self performSelector:@selector(backAction) withObject:self afterDelay:1];
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    
    if (textField.text.length > 0) {
        
        [self postData];
    }
    
    return YES;
}

- (void)backAction {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)returnModifiedEmail:(modifiedEmailBlock)block {

    _block = block;
}

@end
