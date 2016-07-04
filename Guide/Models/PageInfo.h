#import <Foundation/Foundation.h>

@interface PageInfo : NSObject

@property (nonatomic,strong)NSString *ClassName;
@property (nonatomic,strong)NSString *Title;
@property (nonatomic,strong)NSString *Image;
@property (nonatomic,strong)NSString *SelectImage;

+ (UITabBarController *)pageControllers;

@end
