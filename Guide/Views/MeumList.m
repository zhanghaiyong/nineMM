


#import "MeumList.h"
#import "Term1Cell.h"
@implementation MeumList {
    
    UITableView *tableV;
    
}

- (id)initWithFrame:(CGRect)frame {
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

    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, MEUM_CELL_H*5)];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.backgroundColor = [UIColor clearColor];
    tableV.separatorColor = [UIColor clearColor];
    tableV.scrollEnabled = NO;
    [self addSubview:tableV];
}

-(void)setTitleArr:(NSArray *)titleArr {

    _titleArr = titleArr;

}

- (void)setImageArr:(NSArray *)imageArr {

    _imageArr = imageArr;
    [tableV reloadData];
    
}

#pragma mark UITableVIewDelegate------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return MEUM_CELL_H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    Term1Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"Term1Cell" owner:self options:nil]lastObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.meumNameLabel.text = self.titleArr[indexPath.row];
    [cell.logoBtn setImage:[UIImage imageNamed:self.imageArr[indexPath.row]] forState:UIControlStateNormal];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

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
