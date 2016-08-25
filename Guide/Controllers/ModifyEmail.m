
#import "ModifyEmail.h"
#import "UpdateUserInfoParams.h"

@interface ModifyEmail ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTF;

@end

@implementation ModifyEmail

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (IBAction)updateAction:(id)sender {
    
    if (self.emailTF.text.length > 0) {
        
        [self postData];
    }
    
}

- (void)postData {

    [[HUDConfig shareHUD]alwaysShow];
    
    UpdateUserInfoParams *params = [[UpdateUserInfoParams alloc]init];
    params.email = self.emailTF.text;
    
    [KSMNetworkRequest postRequest:KLoginMemberInfo params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"KUpdateEmail = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            self.block(self.emailTF.text);
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
