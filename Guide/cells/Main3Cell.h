#import <UIKit/UIKit.h>

@protocol Main3CellDelegate <NSObject>

- (void)main3CellTapImage:(NSInteger)imageTag;

@end

@interface Main3Cell : UITableViewCell

@property (nonatomic,assign)id<Main3CellDelegate>delegate;

@end
