
typedef void(^TitleViewBlock)(NSInteger btnTag);
#import <UIKit/UIKit.h>

@interface TitleView : UIView

@property (nonatomic,strong)NSArray *titleArray;

@property (nonatomic,copy)TitleViewBlock callBlock;
@property (nonatomic,strong)UIColor *normalColor;
@property (nonatomic,strong)UIColor *selectedColor;

- (void)TitleViewCallBack:(TitleViewBlock)block;

@end
