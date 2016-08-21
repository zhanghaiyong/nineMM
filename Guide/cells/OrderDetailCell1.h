//
//  OrderDetailCell1.h
//  Guide
//
//  Created by 张海勇 on 16/8/6.
//  Copyright © 2016年 ksm. All rights reserved.
//

typedef void(^browseSourceBlock)(NSString *aFlag);

#import <UIKit/UIKit.h>

@interface OrderDetailCell1 : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;

@property (weak, nonatomic) IBOutlet UILabel *sourceCount;
@property (weak, nonatomic) IBOutlet UILabel *storeCount;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sourceViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storeViewH;


@property (nonatomic,strong)NSArray *sourceData;
@property (weak, nonatomic) IBOutlet UITableView *sourceTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sourceTableViewH;

@property (nonatomic,copy)browseSourceBlock block;

- (void)tapToShowSource:(browseSourceBlock) block;


@end
