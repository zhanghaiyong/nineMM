//
//  ScenicLayout.m
//  Guide
//
//  Created by ksm on 16/4/11.
//  Copyright © 2016年 ksm. All rights reserved.
//
#define TABLE_W 80

#import "ScenicLayout.h"

@implementation ScenicLayout



-(id)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
        self.itemSize = CGSizeMake(SCREEN_WIDTH-TABLE_W-10, 95);//每个item的大小，可使用代理对每个item不同设置
        self.minimumLineSpacing = 10;        //每行的间距
        self.minimumInteritemSpacing = 10;    //每行内部item cell间距
//        self.footerReferenceSize=CGSizeMake(0, 30);
        self.headerReferenceSize=CGSizeMake(SCREEN_WIDTH-TABLE_W, 140);//页眉和页脚大小
        self.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);//item cell内部四周的边界（top，left，bottom，right）
        
        
    }
    return self;
}

@end
