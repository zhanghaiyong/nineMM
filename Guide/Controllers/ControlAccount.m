#import "ControlAccount.h"
#import "NavigationBarView.h"
@interface ControlAccount ()

@end

@implementation ControlAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavigationBarView *navigationBarView = [[[NSBundle mainBundle] loadNibNamed:@"NavigationBarView" owner:self options:nil] lastObject];
    navigationBarView.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
    self.navigationItem.titleView = navigationBarView;
    
}

@end
