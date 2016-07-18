//
//  sureOrdercell1.h
//  Guide
//
//  Created by 张海勇 on 16/7/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sureOrdercell1 : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (nonatomic,strong)NSArray *sourceData;
@end
