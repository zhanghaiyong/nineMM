#import <Foundation/Foundation.h>

@interface MainProduceListParams : BaseParams
//筛选条件
@property (nonatomic,strong) NSString *qryCategoryId;
//每一页的条数
@property (nonatomic,strong) NSString *rows;
//页号
@property (nonatomic,strong) NSString *page;

@end
