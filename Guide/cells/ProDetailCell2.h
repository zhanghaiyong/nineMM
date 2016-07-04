#import <UIKit/UIKit.h>

@interface ProDetailCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (nonatomic,assign)NSInteger scrollTag;


@end
