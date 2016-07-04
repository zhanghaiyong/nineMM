#import <UIKit/UIKit.h>

@protocol ClassifyDetailHeadDelegate <NSObject>

- (void)searchTerm:(NSInteger)buttonTag;

@end

@interface ClassifyDetailHead : UIView

@property (nonatomic,assign)id<ClassifyDetailHeadDelegate>delegate;

@end
