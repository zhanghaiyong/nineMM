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
    NSMutableArray *dataArr1;
    NSMutableArray *dataArr2;
    NSMutableArray *dataArr3;
    NSString    *categoryId;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
    }
    return self;
}

- (void)setUp {
    
    dataArr1 = [NSMutableArray array];
    dataArr2 = [NSMutableArray array];
    dataArr3 = [NSMutableArray array];

    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, TableWidth*2, self.height/3*2)];
    tableV1.delegate = self;
    tableV1.dataSource = self;
    tableV1.bounces = NO;
    tableV1.showsVerticalScrollIndicator = NO;
    tableV1.showsHorizontalScrollIndicator = NO;
    [tableV1 setSeparatorInset:UIEdgeInsetsMake(0, -8, 0, 0)];
    tableV1.backgroundColor = [UIColor whiteColor];
    [self addSubview:tableV1];
    
    tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(tableV1.right, 0, TableWidth*3, self.height/3*2)];
    tableV2.delegate = self;
    tableV2.dataSource = self;
    tableV2.bounces = NO;
    tableV2.showsVerticalScrollIndicator = NO;
    tableV2.showsHorizontalScrollIndicator = NO;
    tableV2.backgroundColor = [UIColor whiteColor];
    [self addSubview:tableV2];
    
    tableV3 = [[UITableView alloc]initWithFrame:CGRectMake(tableV2.right, 0, TableWidth*3, self.height/3*2)];
    tableV3.delegate = self;
    tableV3.dataSource = self;
    tableV3.bounces = NO;
    tableV3.showsVerticalScrollIndicator = NO;
    tableV3.showsHorizontalScrollIndicator = NO;
    tableV3.backgroundColor = [UIColor whiteColor];
    [self addSubview:tableV3];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(TableWidth*2, 10, 1, self.height/3*2-10)];
    line1.backgroundColor = lineColor;
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(TableWidth*5, 10, 1, self.height/3*2-10)];
    line2.backgroundColor = lineColor;
    [self addSubview:line2];

}
//
//- (void)drawRect:(CGRect)rect {
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineWidth(context, 1);  //线宽
//    CGContextSetRGBStrokeColor(context, 255 / 255.0, 255 / 255.0, 255 / 255, 1.0);  //线的颜色
//    CGContextBeginPath(context);
//    
//    CGContextMoveToPoint(context, TableWidth*2, 10);  //起点坐标
//    CGContextAddLineToPoint(context, TableWidth*2, self.height/3*2);   //终点坐标
//    
//    CGContextMoveToPoint(context, TableWidth*5+1, 10);  //起点坐标
//    CGContextAddLineToPoint(context, TableWidth*5+1, self.height/3*2);   //终点坐标
//    
//    CGContextMoveToPoint(context, 0, self.height/3*2);  //起点坐标
//    CGContextAddLineToPoint(context, self.width, self.height/3*2);   //终点坐标
//    
//    CGContextStrokePath(context);
//    
//}

#pragma mark UITableViewDelegate &&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == tableV1) {
            
        return dataArr1.count+1;
        
    }else if (tableView == tableV2) {
            
        return dataArr2.count+1;
        
    }else {
            
        return dataArr3.count+1;
    }
    return 0;
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
    
    cell.logoBtn.hidden = YES;
    if (tableView == tableV1) {
        
        if (indexPath.row == 0) {
            cell.meumNameLabel.text = @"全部";
        }else {
            NSDictionary *dic = dataArr1[indexPath.row-1];
            cell.meumNameLabel.text = [dic objectForKey:@"text"];
        }
        
    }else if (tableView == tableV2) {
        
        if (indexPath.row == 0) {
            cell.meumNameLabel.text = @"全部";
        }else {
            NSDictionary *dic = dataArr2[indexPath.row-1];
            cell.meumNameLabel.text = [dic objectForKey:@"text"];
        }
        
    }else {
        
        if (indexPath.row == 0) {
            cell.meumNameLabel.text = @"全部";
        }else {
            NSDictionary *dic = dataArr3[indexPath.row-1];
            cell.meumNameLabel.text = [dic objectForKey:@"text"];
        }
        
    }
    
    
    if (tableView == tableV1) {
       UIView *cellBackView = [[UIView alloc] initWithFrame:cell.frame];
       cellBackView.backgroundColor = RGB(216, 216, 216);
       cell.selectedBackgroundView = cellBackView;

    }else {
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        Term1Cell *cell = (Term1Cell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.meumNameLabel.textColor = MainColor;
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
        
        if (indexPath.row > 0) {
            
            NSDictionary *dic = dataArr1[indexPath.row-1];
            categoryId = [dic objectForKey:@"id"];
            
            [dataArr2 removeAllObjects];
            [dataArr3 removeAllObjects];
            if ([dic.allKeys containsObject:@"children"]) {
                
                [dataArr2 addObjectsFromArray:[dataArr1[indexPath.row-1] objectForKey:@"children"]];
                
                if ([((NSDictionary *)dataArr2[0]).allKeys containsObject:@"children"]) {
                    
                    [dataArr3 addObjectsFromArray:[dataArr2[0] objectForKey:@"children"]];
                }
            }
            [tableV2 reloadData];
            [tableV3 reloadData];
            
        }else {
            
            categoryId = @"";
            
            for (int i=0; i<dataArr1.count; i++) {
                
                NSIndexPath *moreIndex = [NSIndexPath indexPathForRow:i+1 inSection:0];
                Term1Cell *moreCell = [tableView cellForRowAtIndexPath:moreIndex];
                moreCell.meumNameLabel.textColor = MainColor;
                UIView *cellBackView = [[UIView alloc] initWithFrame:cell.frame];
                cellBackView.backgroundColor = RGB(216, 216, 216);
                moreCell.selectedBackgroundView = cellBackView;
            }
            
            self.userInteractionEnabled = NO;
            [self performSelector:@selector(delayBlock) withObject:self afterDelay:1];
        }
        
    }else if (tableView == tableV2) {
    
        if (indexPath.row > 0) {
            
            NSDictionary *dic = dataArr2[indexPath.row-1];
            categoryId = [dic objectForKey:@"id"];
         
            [dataArr3 removeAllObjects];
            if ([dic.allKeys containsObject:@"children"]) {
                [dataArr3 addObjectsFromArray:[dataArr2[indexPath.row-1] objectForKey:@"children"]];
                
            }
            [tableV3 reloadData];
            
        } else {
        
            for (int i=0; i<dataArr2.count; i++) {
                
                NSIndexPath *moreIndex = [NSIndexPath indexPathForRow:i+1 inSection:0];
                Term1Cell *moreCell = [tableView cellForRowAtIndexPath:moreIndex];
                moreCell.meumNameLabel.textColor = MainColor;
            }
            
            self.userInteractionEnabled = NO;
            [self performSelector:@selector(delayBlock) withObject:self afterDelay:1];
        }
    }else {
    
        if (indexPath.row > 0) {
            
            NSDictionary *dic = dataArr3[indexPath.row-1];
            categoryId = [dic objectForKey:@"id"];
            [self performSelector:@selector(delayBlock) withObject:self afterDelay:1];
            
        }else {
        
            for (int i=0; i<dataArr3.count; i++) {
                
                NSIndexPath *moreIndex = [NSIndexPath indexPathForRow:i+1 inSection:0];
                Term1Cell *moreCell = [tableView cellForRowAtIndexPath:moreIndex];
                moreCell.meumNameLabel.textColor = MainColor;
            }
            
            self.userInteractionEnabled = NO;
            [self performSelector:@selector(delayBlock) withObject:self afterDelay:0.5];
        }
    }
}

- (void)delayBlock {

    self.block(categoryId);
    
    if ([self.delegate respondsToSelector:@selector(closeClassifyTerm1)]) {
        
        [self.delegate closeClassifyTerm1];
    }
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Term1Cell *cell = (Term1Cell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.meumNameLabel.textColor = [UIColor blackColor];
}

- (void)selectedCategoryId:(ClassifyTerm1Block)block {

    _block = block;
}

-(void)setProduceSource:(NSArray *)produceSource {

    _produceSource = produceSource;
    [dataArr1 addObjectsFromArray:produceSource];

    [tableV1 reloadData];
    [tableV2 reloadData];
    [tableV3 reloadData];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.block(@"YES");
}


@end
