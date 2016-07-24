#import "SourceListViewController.h"
//#import "SourceListCell.h"
#import "SourceListHead.h"
#import "UserSourceCell.h"
#import "UserSourceModel.h"
@interface SourceListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SourceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"资源清单";
    self.tableView.backgroundColor = backgroudColor;
}

#pragma mark UITableView Delegate && DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.userSourceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SourceListHead *sourceListHead = [[[NSBundle mainBundle]loadNibNamed:@"SourceListHead" owner:self options:nil]lastObject];
    sourceListHead.titleLabel.text = @"已选资源";
    sourceListHead.countLabel.text = [NSString stringWithFormat:@"共%ld件",self.userSourceArr.count];
    sourceListHead.frame = CGRectMake(0, 0, self.tableView.width, 30);
    return sourceListHead;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ideitifier = @"cell";
    UserSourceCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserSourceCell" owner:nil options:nil] lastObject];
    }
    
    UserSourceModel *model = self.userSourceArr[indexPath.row];
    
//    if ([selectArr containsObject:model]) {
    
        cell.isSelect.hidden = YES;
//    }
    cell.titleLabel.text = model.name;
    cell.numLabel.text = model.code;
    
    return cell;
}

@end
