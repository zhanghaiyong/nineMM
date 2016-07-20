#import <Foundation/Foundation.h>

@interface MainProduceListParams : BaseParams
/**
 *  筛选条件-分类
 */
@property (nonatomic,strong) NSString           *qryCategoryId;
/**
 *  每一页的条数
 */
@property (nonatomic,assign) int           rows;
/**
 *  页号
 */
@property (nonatomic,assign) int           page;
/**
 *  筛选条件-区域列表 多个区域ID用逗号分隔,例如: 1,2,3
 */
@property (nonatomic,strong) NSString           *qryAreaIds;
/**
 *  档期起始时间 格式yyyy-MM-dd
 */
@property (nonatomic,strong) NSString           *qryScheduleDateFrom;
/**
 *  筛选条件-档期结束时间
 */
@property (nonatomic,strong) NSString           *qryScheduleDateTo;
/**
 *  筛选条件-最小价格范围
 */
@property (nonatomic,strong) NSString           *qryPriceRangeFrom;
/**
 *  筛选条件-最大价格范围
 */
@property (nonatomic,strong) NSString           *qryPriceRangeTo;

@end
