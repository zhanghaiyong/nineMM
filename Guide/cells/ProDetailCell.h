typedef void(^ProDetailCell2Block)(NSInteger flag);
typedef void(^toUserSourceVC)(void);
typedef void(^toStoresVC)(void);

#import <UIKit/UIKit.h>

@interface ProDetailCell : UITableViewCell
@property (nonatomic,copy)ProDetailCell2Block block;
@property (nonatomic,copy)toUserSourceVC toUserSurBlock;
@property (nonatomic,copy)toStoresVC toStores;

- (IBAction)typeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *lineView;

- (void)proDetailTypeChange:(ProDetailCell2Block)block;
- (void)toUserSource:(toUserSourceVC)block;
- (void)toStores:(toStoresVC)block;

@property (nonatomic,assign)NSInteger lineIndex;

@end
