#import <Foundation/Foundation.h>

@interface MainProduceModel : NSObject

@property (nonatomic,strong) NSArray  *acceptableCoinTypes;
/**
 *  是否收藏  0为不收藏 ，非0为收藏
 */
@property (nonatomic,strong) NSString *favorite;
@property (nonatomic,strong) NSString *flagImgId;
@property (nonatomic,strong) NSString *gold;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *isPackagePrice;
@property (nonatomic,strong) NSString *maxPrice;
@property (nonatomic,strong) NSString *minPrice;
@property (nonatomic,strong) NSString *merchantName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *otherInfo;
@property (nonatomic,strong) NSString *marketPrice;
@property (nonatomic,strong) NSString *scheduleDesc;
@property (nonatomic,strong) NSString *stock;
@property (nonatomic,strong) NSArray  *tags;
//关系
@property (nonatomic,strong) NSString *terms;

@end
