#import <UIKit/UIKit.h>

@interface MeumList : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray *imageArr;
@end
