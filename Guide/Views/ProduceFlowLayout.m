//
//  ProduceFlowLayout.m
//  Guide
//
//  Created by 张海勇 on 16/5/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "ProduceFlowLayout.h"

@implementation ProduceFlowLayout

-(id)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;//滚动方向
        self.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-49-30);//每个item的大小，可使用代理对每个item不同设置
        self.minimumLineSpacing = 0;        //每行的间距
        self.minimumInteritemSpacing = 0;    //每行内部item cell间距
        //        self.footerReferenceSize=CGSizeMake(0, 30);
//        self.headerReferenceSize=CGSizeMake(SCREEN_WIDTH-TABLE_W, 120);//页眉和页脚大小
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//item cell内部四周的边界（top，left，bottom，right）
        
        
    }
    return self;
}

@end
