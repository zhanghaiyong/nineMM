

#import "ClassifyViewController.h"
#import "SearchBar.h"
#import "ClassifyDetailHead.h"
#import "Main4Cell.h"
#import "ClassifyTerm1.h"
#import "ClassifyTerm2.h"
#import "ClassifyTerm3ViewController.h"
#import "ProduceDetailViewController.h"

@interface ClassifyViewController ()<UITableViewDataSource,UITableViewDelegate,ClassifyDetailHeadDelegate,ClassifyTerm2Delegate>
{
    //分类列表
    UITableView *typeTableView;
    //列表内容
    NSArray *typeArray;
    ClassifyDetailHead *head;
    

}
@property (nonatomic,strong)ClassifyTerm1 *term1;
@property (nonatomic,strong)ClassifyTerm2 *term2;

@end

@implementation ClassifyViewController

-(ClassifyTerm1 *)term1 {

    if (_term1 == nil) {
        
        ClassifyTerm1 *term1 = [[ClassifyTerm1 alloc]initWithFrame:CGRectMake(0, head.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-64-44)];
        _term1 = term1;
    }
    return _term1;
}

-(ClassifyTerm2 *)term2 {
    
    if (_term2 == nil) {
        
        ClassifyTerm2 *term2 = [[[NSBundle mainBundle]loadNibNamed:@"ClassifyTerm2" owner:self options:nil] lastObject];
        term2.frame = CGRectMake(0, head.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-64-44);
        term2.delegate = self;
        _term2 = term2;
    }
    return _term2;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initTableViews];
    
}

- (void)initTableViews {
    
    //搜索框
    SearchBar *searchBar = [[[NSBundle mainBundle] loadNibNamed:@"SearchBar" owner:self options:nil] lastObject];
    searchBar.frame = CGRectMake(0, -20, SCREEN_WIDTH, 44);
    searchBar.searchTF.backgroundColor = backgroudColor;
    
    searchBar.searchTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-fangdajing"]];
    //将左边的图片向右移动一定距离
    searchIcon.width +=10;
    searchIcon.contentMode = UIViewContentModeCenter;
    searchBar.searchTF.leftView = searchIcon;
    
    [searchBar.msgFlagButton setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    [searchBar.msgFlagButton setImage:[UIImage imageNamed:@"消息有提示"] forState:UIControlStateSelected];
    
    self.navigationItem.titleView = searchBar;
    
    //分类头部
    head = [[[NSBundle mainBundle] loadNibNamed:@"ClassifyDetailHead" owner:self options:nil] lastObject];
    head.frame = CGRectMake(0, 64, SCREEN_WIDTH, 44);
    head.delegate = self;
    [self.view addSubview:head];

    //商品列表
    typeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, head.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-64-44-49)];
    typeTableView.delegate = self;
    typeTableView.dataSource = self;
    typeTableView.separatorColor = backgroudColor;
    typeTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:typeTableView];
    
}

#pragma mark ClassifyDetailHeadDelegate
- (void)searchTerm:(NSInteger)buttonTag {
    
    switch (buttonTag) {
        case 1000:
            
            if (_term2) {
                
                [_term2 removeFromSuperview];
                _term2 = nil;
                
                UIButton *button = [head viewWithTag:1001];
                button.selected = NO;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            if (_term1) {
                
                [_term1 removeFromSuperview];
                _term1 = nil;
                
                UIButton *button = [head viewWithTag:1000];
                button.selected = NO;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else {
                [[UIApplication sharedApplication].keyWindow addSubview:self.term1];
            }
            
            break;
        case 1001:
            
            if (_term1) {
                
                [_term1 removeFromSuperview];
                _term1 = nil;
                
                UIButton *button = [head viewWithTag:1000];
                button.selected = NO;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            if (_term2) {
                
                [_term2 removeFromSuperview];
                _term2 = nil;
                
                UIButton *button = [head viewWithTag:1001];
                button.selected = NO;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }else {
                
                [[UIApplication sharedApplication].keyWindow addSubview:self.term2];
            }
            
            break;
        case 1002:{
            
            if (_term1) {
                
                [_term1 removeFromSuperview];
                _term1 = nil;
                
                UIButton *button = [head viewWithTag:1000];
                button.selected = NO;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            if (_term2) {
                
                [_term2 removeFromSuperview];
                _term2 = nil;
                
                UIButton *button = [head viewWithTag:1001];
                button.selected = NO;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
            UIButton *button = [head viewWithTag:1002];
            button.selected = NO;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
            ClassifyTerm3ViewController *term3 = [mainSB instantiateViewControllerWithIdentifier:@"ClassifyTerm3ViewController"];
            [self.navigationController pushViewController:term3 animated:YES];
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark ClassifyTerm2Delegate
- (void)classsifyTrem2SureData:(NSString *)someString {

    [_term2 removeFromSuperview];
    _term2 = nil;
    
    UIButton *button = [head viewWithTag:1001];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

#pragma mark UITableViewDelegate&&dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 170;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identtifier = @"cell";
    Main4Cell *cell = [tableView dequeueReusableCellWithIdentifier:identtifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Main4Cell" owner:self options:nil] lastObject];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
    ProduceDetailViewController *produceDetail = [mainSB instantiateViewControllerWithIdentifier:@"ProduceDetailViewController"];
    [self.navigationController pushViewController:produceDetail animated:YES];
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    typeTableView.separatorInset = UIEdgeInsetsZero;
    typeTableView.layoutMargins = UIEdgeInsetsZero;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    typeTableView.separatorInset = UIEdgeInsetsZero;
    typeTableView.layoutMargins = UIEdgeInsetsZero;
}

@end
