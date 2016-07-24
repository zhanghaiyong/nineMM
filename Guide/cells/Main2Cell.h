#import <UIKit/UIKit.h>

@protocol Main2CellDelegate <NSObject>

- (void)main2CellTapImage:(NSInteger)imageTag;

@end

@interface Main2Cell : UITableViewCell

@property (nonatomic,assign)id<Main2CellDelegate>delegate;

@end
