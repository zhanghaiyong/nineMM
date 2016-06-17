//
//  ClassifyDetailSearchView.h
//  Guide
//
//  Created by 张海勇 on 16/5/27.
//  Copyright © 2016年 ksm. All rights reserved.
//

typedef void(^RemoveView)(BOOL isMove);

#import <UIKit/UIKit.h>
@interface ClassifyDetailSearchView : UIView

@property (nonatomic,copy)RemoveView moveBlock;

- (void)callBack:(RemoveView)block;

@end
