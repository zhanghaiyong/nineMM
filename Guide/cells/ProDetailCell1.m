#import "ProDetailCell1.h"

@implementation ProDetailCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.Banner.frame  = CGRectMake(0, 0, SCREEN_WIDTH, 200);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
