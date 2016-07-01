//
//  ClassifyViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/26.
//  Copyright © 2016年 ksm. All rights reserved.
//

#define TABLE_W 80
#define TABLECELL_H 44
#import "ClassifyViewController.h"
#import "ScenicLayout.h"
#import "ClassityCollectionViewCell.h"
#import "ClassityCollecteHead.h"
#import "ClassifyDetailViewController.h"
#import "SearchBar.h"
#import "BirthdayView.h"
@interface ClassifyViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    //分类列表
    UITableView *typeTableView;
    //列表内容
    NSArray *typeArray;
    
    UICollectionView *collection;
}
@end

@implementation ClassifyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initTableViews];
    
//    BirthdayView *birthdayView = [[[NSBundle mainBundle] loadNibNamed:@"BirthdayView" owner:self options:nil] lastObject];
//    birthdayView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    [self.view addSubview:birthdayView];
    
}

- (void)initTableViews {
    
    SearchBar *search = [[[NSBundle mainBundle] loadNibNamed:@"SearchBar" owner:self options:nil] lastObject];
    search.frame = CGRectMake(0, -20, SCREEN_WIDTH, 44);
    search.searchTF.backgroundColor = lineColor;
    search.searchTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
    //将左边的图片向右移动一定距离
    searchIcon.width +=10;
    searchIcon.contentMode = UIViewContentModeCenter;
    search.searchTF.leftView = searchIcon;
    self.navigationItem.titleView = search;

    typeArray = [NSArray arrayWithObjects:@"网站媒体",@"手机媒体",@"门店",@"杂志",@"LED",@"策划",@"制作",@"服务",@"户外",@"电视",@"广播",@"报纸",@"网站媒体",@"手机媒体",@"门店",@"杂志",@"LED",@"策划", nil];
    
    typeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, TABLE_W, SCREEN_HEIGHT-49-64)];
    typeTableView.delegate = self;
    typeTableView.dataSource = self;
    typeTableView.separatorColor = backgroudColor;
    typeTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:typeTableView];
    
    collection = [[UICollectionView alloc]initWithFrame:CGRectMake(TABLE_W, 0, SCREEN_WIDTH-TABLE_W, SCREEN_HEIGHT-49-64) collectionViewLayout:[[ScenicLayout alloc]init]];
    collection.backgroundColor = backgroudColor;
    collection.dataSource = self;
    collection.delegate = self;
    //注册item或cell
    [collection registerNib:[UINib nibWithNibName:@"ClassityCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MY_CELL"];
    
    [collection registerNib:[UINib nibWithNibName:@"ClassityCollecteHead" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MY_header"];
    collection.alwaysBounceVertical = YES;
    [self.view addSubview:collection];
}

#pragma mark UITableViewDelegate&&dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return typeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return TABLECELL_H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identtifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identtifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identtifier];
    }
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = backgroudColor;
    cell.textLabel.text = typeArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //将点击的cell移动到中间位置
    CGFloat offset = cell.center.y - tableView.height/2;
    
    if (offset > tableView.contentSize.height - tableView.height) {
        
        offset = tableView.contentSize.height - tableView.height;
    }
    
    if (offset < 0) {
        offset = 0;
    }
    
    FxLog(@"offset = %f",offset);
    FxLog(@"%f",tableView.contentSize.height - tableView.height);
    
    [tableView setContentOffset:CGPointMake(0, offset) animated:YES];
    
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

#pragma mark  UICollectionDataSource&&delegate
#pragma mark  CollectionViewDelegate
//返回section数量
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//必须实现，返回每个section中item的数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
    
}

//返回页眉和页脚
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ClassityCollecteHead *scenicHead= nil;
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        scenicHead = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MY_header" forIndexPath:indexPath];
    }

    return scenicHead;
}

//必须实现，返回每个item的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ClassifyDetailViewController *classifyDetail = [[ClassifyDetailViewController alloc]init];
    [self.navigationController pushViewController:classifyDetail animated:YES];
}


@end
