//
//  CategoryList.m
//  UniClubber
//
//  Created by 张海勇 on 16/1/19.
//  Copyright © 2016年 张海勇. All rights reserved.
//

#import "CategoryList.h"

@implementation CategoryList
{
    UITableView *tableV;
    UIButton *arrow;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self setBackgroundColor:backgroudColor];
        [self initTableV];
    }
    return self;
}

- (void)initTableV {
    
    arrow = [[UIButton alloc]initWithFrame:CGRectMake(5, 0, 20, 20)];
    [arrow setBackgroundImage:[UIImage imageNamed:@"icon_down_get_iphone"] forState:UIControlStateNormal];
//    [arrow sizeToFit];
    [self addSubview:arrow];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, arrow.bottom-8, self.width, 40*4)];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.layer.borderColor = lever3Color.CGColor;
    tableV.layer.borderWidth = 1;
    tableV.layer.cornerRadius = 4;
//    tableV.separatorColor = catOffColor;
    tableV.scrollEnabled = NO;
    [self addSubview:tableV];
}

- (void)setArrowX:(CGFloat)arrowX {

    _arrowX = arrowX;
    arrow.frame = CGRectMake(arrowX, 0, 20, 20);
    
}

#pragma mark UITableVIewDelegate------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    cell.textLabel.font = MediumFont;
//    cell.textLabel.textColor = deepGray;
    cell.textLabel.text = @"测试";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(closeTableV)]) {
        
        [self.delegate closeTableV];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //设置cell的显示动画为3D缩放
    
    //xy方向缩放的初始值为0.1
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //    cell.layer.anchorPoint = CGPointMake(0, 0);
    //设置动画时间为0.25秒,xy方向缩放的最终值为1
    [UIView animateWithDuration:0.25 animations:^{
        
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    
}

@end
