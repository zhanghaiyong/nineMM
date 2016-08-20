//
//  sureOrdercell1.m
//  Guide
//
//  Created by 张海勇 on 16/7/19.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "sureOrdercell1.h"

@implementation sureOrdercell1

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark UITableViewDelegate&&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.sourceData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.sourceData[indexPath.row];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

-(void)setSourceData:(NSArray *)sourceData {

    _sourceData = sourceData;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    self.countLabel.text = [NSString stringWithFormat:@"共计：%ld",sourceData.count];
    [self.tableView reloadData];
    
}

@end
