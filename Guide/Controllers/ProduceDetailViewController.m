//
//  ProduceDetailViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ProduceDetailViewController.h"
#import "MeumList.h"
#import "ProDetailCell1.h"
#import "ProDetailCell2.h"
#import "ProDetailCell.h"
#import "UserSourceViewController.h"
@interface ProduceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{

    //资源 档期 样刊切换标示
    NSInteger typeFlag;
}
@property (nonatomic,strong)MeumList *meumList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProduceDetailViewController

- (MeumList *)meumList {
    
    if (_meumList == nil) {
        MeumList *meumList = [[MeumList alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, 60, 90,4*40+10)];
//        categoryList.delegate = self;
        _meumList = meumList;
       
    }
    return _meumList;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    [self setNavigationRight:@"icon_order_iphone"];
}

#pragma mark  UITableViewDataSource&&delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        return 320;
    }else if(indexPath.row == 1){
        
        return 84;
        
    }else {
    
        switch (typeFlag) {
            case 0:
                return 200;
            case 1:
                return 300;
            case 2:
                return 400;
                break;
                
            default:
                break;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        
        ProDetailCell1 *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell1" owner:self options:nil] lastObject];
        return cell;
        
    }else if (indexPath.row == 1){
        
        static NSString *identifier = @"ProDetailCell";
        ProDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell" owner:self options:nil] lastObject];
            
        }
        
        [cell proDetailTypeChange:^(NSInteger flag) {
            typeFlag = flag;
            NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:2 inSection:0];
            [self.tableView beginUpdates];
            [self.tableView reloadRowsAtIndexPaths:@[lastIndex] withRowAnimation:UITableViewRowAnimationMiddle];
            [self.tableView endUpdates];
        }];
        
        [cell toUserSource:^{    
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"MainView" bundle:nil];
            UserSourceViewController *toUSerSource = [SB instantiateViewControllerWithIdentifier:@"UserSourceViewController"];
            [self.navigationController pushViewController:toUSerSource animated:YES];
            
        }];
        
        cell.lineIndex = typeFlag;
        
        return cell;
        
    }else {

        ProDetailCell2 *cell = [[[NSBundle mainBundle] loadNibNamed:@"ProDetailCell2" owner:self options:nil] lastObject];
        cell.scrollTag = typeFlag;
        return cell;
    }
}

- (void)doRight:(UIButton *)sender
{
    if (_meumList == nil) {
        
       [self.navigationController.view addSubview:self.meumList];
        
    }else {
     
        [_meumList removeFromSuperview];
        _meumList = nil;
    }
}

@end
