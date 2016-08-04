#import <UIKit/UIKit.h>
#import "MainProduceModel.h"

typedef void(^ProDetailBlock)(NSArray *storeAreaModel,NSArray *sources,NSString *storeOrArea);

@interface ProduceDetailViewController : BaseViewController

@property (nonatomic,strong)NSString *produceId;
@property (nonatomic,assign)BOOL     fromPackage;
@property (nonatomic,copy)ProDetailBlock block;


- (void)fullPackageMsg:(ProDetailBlock)block;

@end
