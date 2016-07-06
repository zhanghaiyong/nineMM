//
//  ClassifyTerm1.m
//  Guide
//
//  Created by 张海勇 on 16/7/3.
//  Copyright © 2016年 ksm. All rights reserved.
//

#define TableWidth  SCREEN_WIDTH/8

#import "ClassifyTerm1.h"
#import "Term1Cell.h"

@implementation ClassifyTerm1
{

    UITableView *tableV1;
    UITableView *tableV2;
    UITableView *tableV3;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setUp {

    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, TableWidth*2, self.height-80)];
    tableV1.delegate = self;
    tableV1.dataSource = self;
    tableV1.bounces = NO;
    tableV1.showsVerticalScrollIndicator = NO;
    tableV1.showsHorizontalScrollIndicator = NO;
    [tableV1 setSeparatorInset:UIEdgeInsetsMake(0, -8, 0, 0)];
    tableV1.backgroundColor = [UIColor whiteColor];
    [self addSubview:tableV1];
    
    tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(tableV1.right+1, 0, TableWidth*3, self.height-80)];
    tableV2.delegate = self;
    tableV2.dataSource = self;
    tableV2.bounces = NO;
    tableV2.showsVerticalScrollIndicator = NO;
    tableV2.showsHorizontalScrollIndicator = NO;
    tableV2.backgroundColor = [UIColor whiteColor];
    [self addSubview:tableV2];
    
    tableV3 = [[UITableView alloc]initWithFrame:CGRectMake(tableV2.right+2, 0, TableWidth*3, self.height-80)];
    tableV3.delegate = self;
    tableV3.dataSource = self;
    tableV3.bounces = NO;
    tableV3.showsVerticalScrollIndicator = NO;
    tableV3.showsHorizontalScrollIndicator = NO;
    tableV3.backgroundColor = [UIColor whiteColor];
    [self addSubview:tableV3];
    
    UIButton *sender = [[UIButton alloc]initWithFrame:CGRectMake(10, tableV1.bottom+20, self.width-20, 44)];
    [sender setTitle:@"搜索" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = MainColor;
    sender.layer.cornerRadius = 5;
    [self addSubview:sender];
    
//    
//    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(TableWidth*2, 10, 1, self.height-90)];
//    line1.backgroundColor = lineColor;
//    [self addSubview:line1];
//    
//    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(TableWidth*5, 10, 1, self.height-90)];
//    line2.backgroundColor = lineColor;
//    [self addSubview:line2];
//    
//    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-80, self.width, 1)];
//    line3.backgroundColor = lineColor;
//    [self addSubview:line3];
}

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);  //线宽
    CGContextSetRGBStrokeColor(context, 216 / 255.0, 216 / 255.0, 217 / 216, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, TableWidth*2, 10);  //起点坐标
    CGContextAddLineToPoint(context, TableWidth*2, self.height-80);   //终点坐标
    
    CGContextMoveToPoint(context, TableWidth*5+1, 10);  //起点坐标
    CGContextAddLineToPoint(context, TableWidth*5+1, self.height-80);   //终点坐标
    
    CGContextMoveToPoint(context, 0, self.height-80);  //起点坐标
    CGContextAddLineToPoint(context, self.width, self.height-80);   //终点坐标
    
    CGContextStrokePath(context);
    
}

#pragma mark UITableViewDelegate &&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    Term1Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Term1Cell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (tableView == tableV1) {
        cell.backgroundColor = backgroudColor;
    }
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
        [tableView setContentOffset:CGPointMake(0, offset) animated:YES];
    
    
    if (tableView == tableV1) {
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    
}


//- (void)viewDidLayoutSubviews {
//    
//    tableV1.separatorInset = UIEdgeInsetsZero;
//    tableV1.layoutMargins = UIEdgeInsetsZero;
//    
//    tableV2.separatorInset = UIEdgeInsetsZero;
//    tableV2.layoutMargins = UIEdgeInsetsZero;
//    
//    tableV3.separatorInset = UIEdgeInsetsZero;
//    tableV3.layoutMargins = UIEdgeInsetsZero;
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    tableV1.separatorInset = UIEdgeInsetsZero;
//    tableV1.layoutMargins = UIEdgeInsetsZero;
//    
//    tableV2.separatorInset = UIEdgeInsetsZero;
//    tableV2.layoutMargins = UIEdgeInsetsZero;
//    
//    tableV3.separatorInset = UIEdgeInsetsZero;
//    tableV3.layoutMargins = UIEdgeInsetsZero;
//}



@end
