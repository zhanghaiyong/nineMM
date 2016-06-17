//
//  ProduceCell.m
//  Guide
//
//  Created by 张海勇 on 16/5/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ProduceCell_1.h"

@interface ProduceCell_1 ()
{

    UILabel *title1;
    UILabel *title2;
    UILabel *title3;
}
@end

@implementation ProduceCell_1

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUp];
    }
    return self;
}

- (void)setUp {

    title1 = [[UILabel alloc]init];
    title1.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:title1];
    
    title2 = [[UILabel alloc]init];
    title2.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:title2];
    
    title3 = [[UILabel alloc]init];
    title3.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:title3];
    
    _label1 = [[UILabel alloc]init];
    _label1.font = [UIFont systemFontOfSize:13];
    _label1.numberOfLines = 0;
    _label1.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByCharWrapping;
    [self.contentView addSubview:_label1];
    
    _label2 = [[UILabel alloc]init];
    _label2.font = [UIFont systemFontOfSize:13];
    _label2.numberOfLines = 0;
    _label2.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByCharWrapping;
    [self.contentView addSubview:_label2];
    
    _label3 = [[UILabel alloc]init];
    _label3.font = [UIFont systemFontOfSize:13];
    _label3.numberOfLines = 0;
    _label3.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByCharWrapping;
    [self.contentView addSubview:_label3];
}

-(void)setModel:(Produce1Model *)model {

    _model = model;
    
    title1.frame = CGRectMake(10, 0, self.width, 20);
    title1.text = @"资源介绍";
    CGRect frame1 = [model.str1 boundingRectWithSize:CGSizeMake(self.width-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    _label1.frame = CGRectMake(10, title1.bottom, frame1.size.width, frame1.size.height);
    _label1.text = model.str1;
    
    title2.frame = CGRectMake(10, _label1.bottom, self.width, 20);
    title2.text = @"执行流程";
    CGRect frame2 = [model.str2 boundingRectWithSize:CGSizeMake(self.width-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    _label2.frame = CGRectMake(10, title2.bottom, frame2.size.width, frame2.size.height);
    _label2.text = model.str2;
    
    title3.frame = CGRectMake(10, _label2.bottom, self.width, 20);
    title3.text = @"注意事项";
    CGRect frame3 = [model.str3 boundingRectWithSize:CGSizeMake(self.width-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    _label3.frame = CGRectMake(10, title3.bottom, frame3.size.width, frame3.size.height);
    _label3.text = model.str3;
}



@end
