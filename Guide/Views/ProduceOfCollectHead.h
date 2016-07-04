typedef void(^ProduceOfCollectHeadBlock)(NSInteger buttonTag);
#import <UIKit/UIKit.h>

@interface ProduceOfCollectHead : UIView

@property (nonatomic,copy)ProduceOfCollectHeadBlock callBlock;

- (void)ProduceOfCollectHeadBack:(ProduceOfCollectHeadBlock)block;

@end
