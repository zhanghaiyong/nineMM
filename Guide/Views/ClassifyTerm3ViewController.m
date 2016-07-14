//
//  ClassifyTerm3ViewController.m
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//
#define TableWidth  SCREEN_WIDTH/8
#define TableHeight 40*5+10

#import "ClassifyTerm3ViewController.h"
#import "Term1Cell.h"
@interface ClassifyTerm3ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *tableV1;
    UITableView *tableV2;
    UITableView *tableV3;
    UITableView *storeTable;
}
@end

@implementation ClassifyTerm3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"区域选择";
    [self initSubViews];
}

- (void)initSubViews {

    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, TableWidth*2, TableHeight)];
    tableV1.delegate = self;
    tableV1.dataSource = self;
    tableV1.bounces = NO;
    tableV1.separatorColor = lineColor;
    tableV1.showsVerticalScrollIndicator = NO;
    tableV1.showsHorizontalScrollIndicator = NO;
    [tableV1 setSeparatorInset:UIEdgeInsetsMake(0, -8, 0, 0)];
    [self.view addSubview:tableV1];
    
    tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(tableV1.right, tableV1.top, TableWidth*3, TableHeight)];
    tableV2.delegate = self;
    tableV2.dataSource = self;
    tableV2.bounces = NO;
    tableV2.showsVerticalScrollIndicator = NO;
    tableV2.showsHorizontalScrollIndicator = NO;
    tableV2.separatorColor = lineColor;
    [self.view addSubview:tableV2];
    
    tableV3 = [[UITableView alloc]initWithFrame:CGRectMake(tableV2.right, tableV1.top, TableWidth*3, TableHeight)];
    tableV3.delegate = self;
    tableV3.dataSource = self;
    tableV3.bounces = NO;
    tableV3.showsVerticalScrollIndicator = NO;
    tableV3.showsHorizontalScrollIndicator = NO;
    tableV3.separatorColor = lineColor;
    [self.view addSubview:tableV3];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.view.width, 1)];
    line.backgroundColor = lineColor;
    [self.view addSubview:line];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(TableWidth*2, 10, 1, tableV2.bottom-10)];
    line1.backgroundColor = lineColor;
    [self.view addSubview:line1];

    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(TableWidth*5, 10, 1, tableV2.bottom-10)];
    line2.backgroundColor = lineColor;
    [self.view addSubview:line2];

    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, tableV2.bottom, self.view.width, 0.8)];
    line3.backgroundColor = lineColor;
    [self.view addSubview:line3];
    
    UITextField *searchBar = [[UITextField alloc]initWithFrame:CGRectMake(20, tableV2.bottom+10, SCREEN_WIDTH-40, 30)];
    searchBar.font = lever2Font;
    searchBar.backgroundColor = backgroudColor;
    searchBar.placeholder = @"请输入门店关键字";
    searchBar.layer.cornerRadius = 17;
    searchBar.layer.masksToBounds = YES;
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
    //将左边的图片向右移动一定距离
    searchIcon.width +=10;
    searchIcon.contentMode = UIViewContentModeCenter;
    searchBar.leftView = searchIcon;
    [self.view addSubview:searchBar];
    
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, searchBar.bottom+10, self.view.width, 1)];
    line4.backgroundColor = lineColor;
    [self.view addSubview:line4];
    
    storeTable = [[UITableView alloc]initWithFrame:CGRectMake(0, line4.bottom, self.view.width,SCREEN_HEIGHT - TableHeight-56-60-64-20)];
    storeTable.delegate = self;
    storeTable.dataSource = self;
    storeTable.showsVerticalScrollIndicator = NO;
    storeTable.showsHorizontalScrollIndicator = NO;
    storeTable.separatorColor = [UIColor clearColor];
    [self.view addSubview:storeTable];
    
    
    UIButton *sender = [[UIButton alloc]initWithFrame:CGRectMake(10, storeTable.bottom+10, self.view.width-20, 44)];
    [sender setTitle:@"确定" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = MainColor;
    sender.layer.cornerRadius = 5;
    [self.view addSubview:sender];
    
}

#pragma mark UITableViewDelegate &&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (tableView != storeTable) {
        return 10;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == storeTable) {
        
        static NSString *identifier = @"storeTable";
        Term1Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"Term1Cell" owner:self options:nil] lastObject];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        static NSString *identifier = @"table";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.font = lever2Font;
        
        cell.textLabel.text = @"测试";
        
        if (tableView == tableV1) {
            cell.backgroundColor = backgroudColor;
        }else {
        
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView != storeTable) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //将点击的cell移动到中间位置
        CGFloat offset = cell.center.y - tableView.height/2;
        if (offset > tableView.contentSize.height - tableView.height) {
            
            offset = tableView.contentSize.height - tableView.height;
        }
        if (offset < 0) {
            offset = 0;
        }
        [tableView setContentOffset:CGPointMake(0, offset) animated:YES];
        cell.textLabel.textColor = MainColor;
    }else {
        Term1Cell *cell = (Term1Cell *)[tableView cellForRowAtIndexPath:indexPath];
        //将点击的cell移动到中间位置
        CGFloat offset = cell.center.y - tableView.height/2;
        if (offset > tableView.contentSize.height - tableView.height) {
            
            offset = tableView.contentSize.height - tableView.height;
        }
        if (offset < 0) {
            offset = 0;
        }
        [tableView setContentOffset:CGPointMake(0, offset) animated:YES];
        cell.logoBtn.selected = YES;
        cell.meumNameLabel.textColor = MainColor;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView != storeTable) {
       
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor blackColor];
        
    }else {

        Term1Cell *cell = (Term1Cell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.logoBtn.selected = NO;
        cell.textLabel.textColor = [UIColor blackColor];
    }

}


@end
