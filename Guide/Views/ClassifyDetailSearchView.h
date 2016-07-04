typedef void(^RemoveView)(BOOL isMove);

#import <UIKit/UIKit.h>
@interface ClassifyDetailSearchView : UIView

@property (nonatomic,copy)RemoveView moveBlock;

- (void)callBack:(RemoveView)block;

@end
