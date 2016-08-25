//
//  OrderDetailCell1.m
//  Guide
//
//  Created by 张海勇 on 16/8/6.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "OrderDetailCell1.h"

@implementation OrderDetailCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sourceTableView.delegate = self;
    self.sourceTableView.dataSource = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sourceAction:(id)sender {
    
    self.block(@"source");
}

- (IBAction)storeAction:(id)sender {
    
    self.block(@"store");
}

- (void)tapToShowSource:(browseSourceBlock)block {

    _block = block;
}

- (void)setSourceData:(NSArray *)sourceData {

    _sourceData = sourceData;
    
    [self.sourceTableView reloadData];
}

#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _sourceData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    NSDictionary *dic = self.sourceData[indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"name"];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = lever1Color;
    
    return cell;
}

@end
