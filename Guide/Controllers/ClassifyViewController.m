//
//  ClassifyViewController.m
//  Guide
//
//  Created by 张海勇 on 16/5/26.
//  Copyright © 2016年 ksm. All rights reserved.
//

#define TABLE_W 80
#define TABLECELL_H 30
#import "ClassifyViewController.h"
#import "ScenicLayout.h"
#import "ScenicCell.h"
#import "ScenicHead.h"
#import "ClassifyDetailViewController.h"
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

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initTableViews];
    
}

- (void)initTableViews {

    typeArray = [NSArray arrayWithObjects:@"网站媒体",@"手机媒体",@"门店",@"杂志",@"LED",@"策划",@"制作",@"服务",@"户外",@"电视",@"广播",@"报纸", nil];
    
    typeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, TABLE_W, SCREEN_HEIGHT-49)];
    typeTableView.delegate = self;
    typeTableView.dataSource = self;
    typeTableView.separatorColor = backgroudColor;
    typeTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:typeTableView];
    
    collection = [[UICollectionView alloc]initWithFrame:CGRectMake(TABLE_W, 0, SCREEN_WIDTH-TABLE_W, SCREEN_HEIGHT-49) collectionViewLayout:[[ScenicLayout alloc]init]];
    collection.backgroundColor = backgroudColor;
    collection.dataSource = self;
    collection.delegate = self;
    [collection registerClass:[ScenicCell class] forCellWithReuseIdentifier:@"MY_CELL"];//注册item或cell
    [collection registerClass:[ScenicHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MY_header"];
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
    
    cell.textLabel.text = typeArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
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
    ScenicHead *scenicHead= nil;
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        scenicHead = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MY_header" forIndexPath:indexPath];
    }

    return scenicHead;
}

//必须实现，返回每个item的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ScenicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
//    cell.label.text = @"text";
    cell.itemImageView.backgroundColor =[UIColor redColor];

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ClassifyDetailViewController *classifyDetail = [[ClassifyDetailViewController alloc]init];
    [self.navigationController pushViewController:classifyDetail animated:YES];
}


@end
