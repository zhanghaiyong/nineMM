//
//  ClassifyTerm3ViewController.m
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//
//#define TableWidth  40
//#define TableHeight 40*5+10

#import "ClassifyTerm3ViewController.h"
#import "Term1Cell.h"
#import "ProduceAreaIDParams.h"
#import "ProduceStoresParams.h"
#import "ProduceStoresModel.h"
@interface ClassifyTerm3ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    
    UITableView *tableV1;
    UITableView *tableV2;
    UITableView *tableV3;
    NSMutableArray *dataArr1;
    NSMutableArray *dataArr2;
    NSMutableArray *dataArr3;
    UITableView    *storeTable;
    CGFloat        TableHeight;
    NSMutableArray *produceAreas;
    NSMutableArray *storesArr;
    NSMutableArray *TableAreaId1;
    NSMutableArray *TableAreaId2;
    NSMutableArray *TableAreaId3;
    NSMutableArray *storeIds;
    UITextField *searchBar;
    
}

@property (nonatomic,strong)ProduceStoresParams *storesParams;

@end

@implementation ClassifyTerm3ViewController

-(ProduceStoresParams *)storesParams {

    if (_storesParams == nil) {
        
        ProduceStoresParams *storesParams = [[ProduceStoresParams alloc]init];
        storesParams.productId = self.produceModel.id;
        storesParams.page = 0;
        storesParams.rows = 20;
        _storesParams = storesParams;
    }
    return _storesParams;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"区域选择";
    [self initSubViews];
    
    
    dataArr1     = [NSMutableArray array];
    dataArr2     = [NSMutableArray array];
    dataArr3     = [NSMutableArray array];
    produceAreas = [NSMutableArray array];
    storesArr    = [NSMutableArray array];
    TableAreaId1 = [NSMutableArray array];
    TableAreaId2 = [NSMutableArray array];
    TableAreaId3 = [NSMutableArray array];
    storeIds     = [NSMutableArray array];
    
    
    if (self.produceModel) {
        
        [self produceArreaData];
        
    }else {
    
        NSString *rootPath = [HYSandbox docPath];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",rootPath,ARESTREE];
        NSArray *areaTree  = [NSArray arrayWithContentsOfFile:filePath];
        [dataArr1 addObjectsFromArray:areaTree];
        
//        if ([((NSDictionary *)dataArr1[0]).allKeys containsObject:@"c"]) {
//            [dataArr2 addObjectsFromArray:[dataArr1[0] objectForKey:@"c"]];
//        }
//        
//        if ([((NSDictionary *)dataArr2[0]).allKeys containsObject:@"c"]) {
//            [dataArr3 addObjectsFromArray:[dataArr2[0] objectForKey:@"c"]];
//        }
    }
}

- (void)produceArreaData {

    [[HUDConfig shareHUD]alwaysShow];
    
    ProduceAreaIDParams *params = [[ProduceAreaIDParams alloc]init];
    params.productId = self.produceModel.id;
    
    [KSMNetworkRequest postRequest:KGetProductAreaIds params:params.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"produceArreaData = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {

                [produceAreas addObjectsFromArray:[[dataDic objectForKey:@"retObj"] objectForKey:@"ids"]];
                
                
                NSString *rootPath = [HYSandbox docPath];
                NSString *filePath = [NSString stringWithFormat:@"%@/%@",rootPath,ARESTREE];
                NSArray *areaTree  = [NSArray arrayWithContentsOfFile:filePath];
//                NSLog(@"areaTreeareaTree = %@",areaTree);
                //筛选一级
                NSMutableArray *Filter1 = [NSMutableArray array];
                FxLog(@"areaTree1 = %ld",Filter1.count);
                [produceAreas enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
                    [areaTree enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ([[[NSString stringWithFormat:@"%@",[dic objectForKey:@"i"]] substringToIndex:2] isEqualToString:[[NSString stringWithFormat:@"%@",str] substringToIndex:2]]) {
                            
                            if (![Filter1 containsObject:dic]) {
                                [Filter1 addObject:dic];
                            }
                            
                            
                            FxLog(@"areaTree1 = %ld",Filter1.count);
                        }
                    }];
                }];
                

                //筛选二级
                NSMutableArray *Filter2 = [Filter1 mutableCopy];
                [Filter1 enumerateObjectsUsingBlock:^(NSDictionary *firstDic, NSUInteger idOne, BOOL * _Nonnull stop) {
                    if ([firstDic.allKeys containsObject:@"c"]) {

                        NSMutableArray *array = [NSMutableArray array];
                        NSMutableArray *middle  = [NSMutableArray arrayWithArray:[firstDic objectForKey:@"c"]];
                        [produceAreas enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            
                            [middle enumerateObjectsUsingBlock:^(NSDictionary *twoDic, NSUInteger idTwo, BOOL * _Nonnull stop) {
                            
                            if ([[[NSString stringWithFormat:@"%@",[twoDic objectForKey:@"i"]] substringToIndex:4] isEqualToString:[[NSString stringWithFormat:@"%@",obj] substringToIndex:4]]) {
                            
                                if (![array containsObject:twoDic]) {
                                    [array addObject:twoDic];
                                }
                                *stop = YES;
                            }
                            }];
                            
                            }];
                        
                        NSLog(@"dddddd= =%ld",array.count);
                            [Filter2[idOne] setObject:array forKey:@"c"];
                        }
                    }];
                    
                
//                FxLog(@"areaTree1 = %ld",((NSArray *)([Filter2[0] objectForKey:@"c"])).count);
                
                //筛选三级
                NSMutableArray *Filter3 = [Filter2 mutableCopy];
                [Filter2 enumerateObjectsUsingBlock:^(NSDictionary *first, NSUInteger idOne, BOOL * _Nonnull stop)
                 {
                    
                    if ([first.allKeys containsObject:@"c"]) {
                        
                         NSMutableArray *middle1 = [NSMutableArray arrayWithArray:[first objectForKey:@"c"]];
                     
                        [middle1 enumerateObjectsUsingBlock:^(NSDictionary *second, NSUInteger idTwo, BOOL * _Nonnull stop)
                         {
                             
                            if ([second.allKeys containsObject:@"c"]) {
                            NSMutableArray *array = [NSMutableArray array];
                            NSMutableArray *middle2 = [NSMutableArray arrayWithArray:[second objectForKey:@"c"]];
                            [produceAreas enumerateObjectsUsingBlock:^(NSString *ids, NSUInteger idx, BOOL * _Nonnull stop) {
                                 
                            [middle2 enumerateObjectsUsingBlock:^(NSDictionary *finall, NSUInteger idThree, BOOL * _Nonnull stop)
                             {
                                if ([[NSString stringWithFormat:@"%@",[finall objectForKey:@"i"]] isEqualToString:[NSString stringWithFormat:@"%@",ids]])
                                {
                                    if (![array containsObject:finall]) {
                                        [array addObject:finall];
                                    }
                                     *stop = YES;
                                }
                                
                            }];
                                }];
                                [[Filter3[idOne] objectForKey:@"c"][idTwo] setObject:array forKey:@"c"];
                           
                            }
                             
                             
                            
                        }];
                     
                    }
                }];

                NSLog(@"dataArr1 = %@",Filter3);
                
                [dataArr1 addObjectsFromArray:Filter3];
                
//                if (dataArr1.count > 0) {
//                   
//                    if ([((NSDictionary *)dataArr1[0]).allKeys containsObject:@"c"]) {
//                        [dataArr2 addObjectsFromArray:[dataArr1[0] objectForKey:@"c"]];
//                    }
//                }
//                
//                if (dataArr2.count > 0) {
//                    if ([((NSDictionary *)dataArr2[0]).allKeys containsObject:@"c"]) {
//                        [dataArr3 addObjectsFromArray:[dataArr2[0] objectForKey:@"c"]];
//                    }
//                }
                
                [tableV1 reloadData];
                [tableV2 reloadData];
                [tableV3 reloadData];
                
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)initSubViews {
    
    //分类
    if (self.produceModel) {
        
       
        TableHeight = 40*5+10;
        
    }else {
    
        TableHeight = self.view.height-120;
    }

    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width/3, TableHeight)];
    tableV1.delegate = self;
    tableV1.dataSource = self;
    tableV1.bounces = NO;
    tableV1.separatorColor = lineColor;
    tableV1.showsVerticalScrollIndicator = NO;
    tableV1.showsHorizontalScrollIndicator = NO;
    [tableV1 setSeparatorInset:UIEdgeInsetsMake(0, -8, 0, 0)];
    [self.view addSubview:tableV1];
    
    tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(tableV1.right, tableV1.top, self.view.width/3, TableHeight)];
    tableV2.delegate = self;
    tableV2.dataSource = self;
    tableV2.bounces = NO;
    tableV2.showsVerticalScrollIndicator = NO;
    tableV2.showsHorizontalScrollIndicator = NO;
    tableV2.separatorColor = lineColor;
    [self.view addSubview:tableV2];
    
    tableV3 = [[UITableView alloc]initWithFrame:CGRectMake(tableV2.right, tableV1.top, self.view.width/3, TableHeight)];
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
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(self.view.width/3, 10, 1, tableV2.bottom-10)];
    line1.backgroundColor = lineColor;
    [self.view addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(self.view.width/3*2, 10, 1, tableV2.bottom-10)];
    line2.backgroundColor = lineColor;
    [self.view addSubview:line2];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, tableV2.bottom, self.view.width, 0.8)];
    line3.backgroundColor = lineColor;
    [self.view addSubview:line3];
    
    if (self.produceModel) {
    
        searchBar = [[UITextField alloc]initWithFrame:CGRectMake(20, tableV2.bottom+10, SCREEN_WIDTH-40, 30)];
        searchBar.font = lever2Font;
        searchBar.backgroundColor = backgroudColor;
        searchBar.placeholder = @"请输入门店关键字";
        searchBar.layer.cornerRadius = 17;
        searchBar.layer.masksToBounds = YES;
        searchBar.delegate = self;
        searchBar.returnKeyType = UIReturnKeySearch;
        searchBar.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *searchIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-fangdajing"]];
        //将左边的图片向右移动一定距离
        searchIcon.width +=10;
        searchIcon.contentMode = UIViewContentModeCenter;
        searchBar.leftView = searchIcon;
        [self.view addSubview:searchBar];
        
        UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, searchBar.bottom+10, self.view.width, 1)];
        line4.backgroundColor = lineColor;
        [self.view addSubview:line4];
        
        storeTable = [[UITableView alloc]initWithFrame:CGRectMake(0, line4.bottom, self.view.width,SCREEN_HEIGHT - TableHeight-56-60-64)];
        storeTable.delegate = self;
        storeTable.dataSource = self;
        storeTable.showsVerticalScrollIndicator = NO;
        storeTable.showsHorizontalScrollIndicator = NO;
        storeTable.separatorColor = [UIColor clearColor];
        [self.view addSubview:storeTable];
        
        //刷新
        storeTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.storesParams.page = 1;
            
            [self loadStores];
            
        }];
        
        //加载
        storeTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            self.storesParams.page += 1;
            
            [self loadStores];
        }];
        
        [storeTable.mj_header beginRefreshing];
    }
    
    UIButton *sender = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT-55-60, self.view.width-20, 44)];
    [sender setTitle:@"确定" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = MainColor;
    [sender addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    sender.layer.cornerRadius = 5;
    [self.view addSubview:sender];
    
}

- (void)loadStores {
    
    [[HUDConfig shareHUD]alwaysShow];
    
    [KSMNetworkRequest postRequest:KSearchProductStores params:self.storesParams.mj_keyValues success:^(NSDictionary *dataDic) {
        
        FxLog(@"loadStores = %@",dataDic);
        
        if ([[dataDic objectForKey:@"retCode"] integerValue] == 0) {
            
            [[HUDConfig shareHUD]SuccessHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
            
            if (![[dataDic objectForKey:@"retObj"] isEqual:[NSNull null]]) {
                
                NSArray *sourceData = [[dataDic objectForKey:@"retObj"] objectForKey:@"rows"];
                
                //等于1，说明是刷新
                if (self.storesParams.page == 1) {
                    [storesArr removeAllObjects];
                    
                    storesArr = [ProduceStoresModel mj_objectArrayWithKeyValuesArray:sourceData];
                    [storeTable.mj_header endRefreshing];
                    
                }else {
                    
                    NSArray *array = [ProduceStoresModel mj_objectArrayWithKeyValuesArray:sourceData];
                    [storesArr addObjectsFromArray:array];
                    
                    if (array.count < self.storesParams.rows) {
                        
                        [storeTable.mj_footer endRefreshingWithNoMoreData];
                        
                    }else {
                        
                        [storeTable.mj_footer endRefreshing];
                    }
                }
                
                [storeTable reloadData];
            }
            
        }else {
            
            [[HUDConfig shareHUD]ErrorHUD:[dataDic objectForKey:@"retMsg"] delay:DELAY];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark UITableViewDelegate &&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == tableV1) {
        
        return dataArr1.count;
        
    }else if (tableView == tableV2) {
        
        return dataArr2.count;
        
    }else if (tableView == tableV3) {
        
        return dataArr3.count;
        
    }else {
    
        return storesArr.count+1;
    }
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
        
        if (indexPath.row == 0) {
            
            cell.meumNameLabel.text = @"全部";
            cell.dataLabel.text = [NSString stringWithFormat:@"%ld家门店",storesArr.count];
            
            cell.meumNameLabel.textColor = lineColor;
            cell.dataLabel.textColor     = lineColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }else {
        
        ProduceStoresModel *model = storesArr[indexPath.row-1];
        if ([storeIds containsObject:model.id]) {
            
            cell.logoBtn.selected        = YES;
            cell.meumNameLabel.textColor = MainColor;
            cell.dataLabel.textColor     = MainColor;
        }
        cell.meumNameLabel.text = model.name;
        cell.dataLabel.text = model.createDate;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
        
    } else {
        static NSString *identifier = @"table";
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = lever2Font;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        
        if (tableView == tableV1) {
            NSDictionary *dic = dataArr1[indexPath.row];
            cell.textLabel.text = [dic objectForKey:@"n"];
            
        }else if (tableView == tableV2) {
            
            NSDictionary *dic = dataArr2[indexPath.row];
            cell.textLabel.text = [dic objectForKey:@"n"];
            
        }else {
            
            NSDictionary *dic = dataArr3[indexPath.row];
            cell.textLabel.text = [dic objectForKey:@"n"];
            
        }
        
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
        
        if (tableView == tableV1) {
            
            NSDictionary *dic1 = dataArr1[indexPath.row];
            
            [dataArr2 removeAllObjects];
            [dataArr3 removeAllObjects];
            [TableAreaId2 removeAllObjects];
            [TableAreaId3 removeAllObjects];
            
            if ([TableAreaId1 containsObject:[dic1 objectForKey:@"i"]]) {
                
                [TableAreaId1 removeObject:[dic1 objectForKey:@"i"]];
                cell.textLabel.textColor = [UIColor blackColor];
                
                if (TableAreaId1.count == 1) {
                    
                    for (NSDictionary *dic in dataArr1) {
                        
                        if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"i"]] isEqualToString:[NSString stringWithFormat:@"%@",TableAreaId1[0]]]) {
                            
                            if ([dic.allKeys containsObject:@"c"]) {
                                
                                [dataArr2 addObjectsFromArray:[dic objectForKey:@"c"]];
                            }
                            
                        }
                    }
                }
                
            }else {
            
                [TableAreaId1 addObject:[dic1 objectForKey:@"i"]];
                cell.textLabel.textColor = MainColor;
                
                if (TableAreaId1.count == 1) {
                    
                    if ([((NSDictionary *)dataArr1[indexPath.row]).allKeys containsObject:@"c"]) {
                        
                        [dataArr2 addObjectsFromArray:[dataArr1[indexPath.row] objectForKey:@"c"]];
                    }
                }
            }
            
            [tableV2 reloadData];
            [tableV3 reloadData];
            
        }else if (tableView == tableV2) {
            
            NSDictionary *dic1 = dataArr2[indexPath.row];
            
            [dataArr3 removeAllObjects];
            [TableAreaId3 removeAllObjects];
            
            if ([TableAreaId2 containsObject:[dic1 objectForKey:@"i"]]) {
                
                [TableAreaId2 removeObject:[dic1 objectForKey:@"i"]];
                cell.textLabel.textColor = [UIColor blackColor];
                
                if (TableAreaId2.count == 1) {
                    
                    for (NSDictionary *dic in dataArr2) {
                        
                        if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"i"]] isEqualToString:[NSString stringWithFormat:@"%@",TableAreaId2[0]]]) {
                            
                            
                            if ([dic.allKeys containsObject:@"c"]) {
                                
                                [dataArr3 addObjectsFromArray:[dic objectForKey:@"c"]];
                            }
                        }
                    }
                }
                
            }else {
                
                [TableAreaId2 addObject:[dic1 objectForKey:@"i"]];
                cell.textLabel.textColor = MainColor;
                
                if (TableAreaId2.count == 1) {
                    
                    if ([((NSDictionary *)dataArr2[indexPath.row]).allKeys containsObject:@"c"]) {
                        
                        [dataArr3 addObjectsFromArray:[dataArr2[indexPath.row] objectForKey:@"c"]];
                        
                    }
                }
            }
            [tableV3 reloadData];
            
        }else {
        
            NSDictionary *dic1 = dataArr3[indexPath.row];
            
            if ([TableAreaId3 containsObject:[dic1 objectForKey:@"i"]]) {
                
                cell.textLabel.textColor = [UIColor blackColor];
                [TableAreaId3 removeObject:[dic1 objectForKey:@"i"]];
                
            }else {
                
                [TableAreaId3 addObject:[dic1 objectForKey:@"i"]];
                cell.textLabel.textColor = MainColor;
            }
        }
        
        
//        NSMutableArray *finalAreaId = [NSMutableArray array];
//        [finalAreaId addObjectsFromArray:TableAreaId1];
//        [finalAreaId addObjectsFromArray:TableAreaId2];
//        [finalAreaId addObjectsFromArray:TableAreaId3];
        
        NSString *areaIds;
        if (TableAreaId3.count > 0) {
        
            areaIds = [TableAreaId3 componentsJoinedByString:@","];
            
        }else if (TableAreaId2.count > 0) {
        
            areaIds = [TableAreaId2 componentsJoinedByString:@","];
        }else {
        
            areaIds = [TableAreaId1 componentsJoinedByString:@","];
        }
        
        self.storesParams.areaIds = areaIds;
        
        NSLog(@"%@",areaIds);
        
        [storeTable.mj_header beginRefreshing];

        
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
        
        if (indexPath.row > 0) {
            ProduceStoresModel *model = storesArr[indexPath.row-1];
            if ([storeIds containsObject:model.id]) {
                
                [storeIds removeObject:model.id];
                cell.logoBtn.selected        = NO;
                cell.meumNameLabel.textColor = [UIColor blackColor];
                cell.dataLabel.textColor     = [UIColor blackColor];
                
            }else {
            
                [storeIds addObject:model.id];
                
                cell.logoBtn.selected        = YES;
                cell.meumNameLabel.textColor = MainColor;
                cell.dataLabel.textColor     = MainColor;
            }
        }
    }
}

- (void)sureAction {

    if ([self.delegate respondsToSelector:@selector(areaIdOrStoresId:type:)]) {
        
        NSString *ids;
        NSString *type;
        if (storeIds.count > 0) {
            
            ids = [storeIds componentsJoinedByString:@","];
            type = @"storeId";
            
        }else {
        
            ids = self.storesParams.areaIds;
            type = @"areaId";
        }
        [self.delegate areaIdOrStoresId:ids type:type];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

        
        [searchBar resignFirstResponder];
    
        self.storesParams.keyword = textField.text;
        
        [storeTable.mj_header beginRefreshing];
    
    return YES;
}

@end
