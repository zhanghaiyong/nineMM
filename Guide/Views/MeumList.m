//
//  customView.m
//  GraphicsView
//
//  Created by 张海勇 on 16/6/18.
//  Copyright © 2016年 张海勇. All rights reserved.
//

#import "MeumList.h"

@implementation MeumList
{
    UITableView *tableV;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.layer.cornerRadius = 4;
        self.clipsToBounds = YES;
        [self initTableV];
        
    }
    return self;
}

- (void)initTableV {

    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, 40*4)];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.backgroundColor = [UIColor clearColor];
//    tableV.layer.borderColor = lever3Color.CGColor;
//    tableV.layer.borderWidth = 1;
//    tableV.layer.cornerRadius = 4;
    //    tableV.separatorColor = catOffColor;
    tableV.scrollEnabled = NO;
    [self addSubview:tableV];
}

#pragma mark UITableVIewDelegate------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
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
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = @"测试";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if ([self.delegate respondsToSelector:@selector(closeTableV)]) {
//        
//        [self.delegate closeTableV];
//    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat {
    //设置cell的显示动画为3D缩放
    //xy方向缩放的初始值为0.1
    cell.layer.transform = CATransform3DMakeScale(0.1, 1, 1);
    //    cell.layer.anchorPoint = CGPointMake(0, 0);
    //设置动画时间为0.25秒,xy方向缩放的最终值为1
    [UIView animateWithDuration:0.25 animations:^{
        
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}


- (void)drawRect:(CGRect)rect //画出边框
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef arrowPath = CGPathCreateMutable();
    CGPathMoveToPoint(arrowPath, NULL, 0, 10);
    CGPathAddLineToPoint(arrowPath, NULL, rect.size.width-25, 10);
    CGPathAddLineToPoint(arrowPath, NULL, rect.size.width-15, 0);
    CGPathAddLineToPoint(arrowPath, NULL, rect.size.width-5, 10);
    CGPathAddLineToPoint(arrowPath, NULL, rect.size.width, 10);
    CGPathAddLineToPoint(arrowPath, NULL, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(arrowPath, NULL, 0, rect.size.height);
    CGPathCloseSubpath(arrowPath); //封口
    CGContextAddPath(ctx, arrowPath);
    
    [[UIColor colorWithWhite:0 alpha:0.5] setFill];
    CGContextDrawPath(ctx,kCGPathFill);
    CGContextClip(ctx);
    CGPathRelease(arrowPath);
}

@end
