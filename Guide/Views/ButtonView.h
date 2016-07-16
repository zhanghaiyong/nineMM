#import <UIKit/UIKit.h>

@protocol ButtonViewDeleage <NSObject>

- (void)buttonViewTap:(NSInteger)aFlag;

@end

@interface ButtonView : UIView

@property (nonatomic,strong)NSString *labelTitle;
@property (nonatomic,strong)NSString *imageName;
@property (nonatomic,strong)UIButton *badgeBtn;
@property (nonatomic,assign)BOOL     isNetImage;
@property (nonatomic,assign)id<ButtonViewDeleage>delegate;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image;

@end
