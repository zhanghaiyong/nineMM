#import <Foundation/Foundation.h>
#import "TopBannersModel.h"
#import "ShortcutsModel.h"
#import "NewsModel.h"
#import "GroupButtonsModel.h"
#import "SecondBannerModel.h"

@interface MainStaticModel : NSObject<MJKeyValue>

@property (nonatomic,strong)NSArray *topBanners;
@property (nonatomic,strong)NSArray *shortcuts;
@property (nonatomic,strong)NSArray *groupButtons;
@property (nonatomic,strong)NSArray *news;
@property (nonatomic,strong)NSArray *secondBanner;
@end
