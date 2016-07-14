//
//  OrderComplainCtrl.m
//  Guide
//
//  Created by 张海勇 on 16/7/4.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "OrderComplainCtrl.h"
#import "ZZPhotoController.h"

@interface OrderComplainCtrl ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,strong) NSMutableArray *selectedImageArr;
@end

@implementation OrderComplainCtrl
{

    //用户点击的imageView
    NSInteger selectedImageTag;

}

- (UIImagePickerController *)imagePicker {

    if (_imagePicker == nil) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        _imagePicker = imagePicker;
    }
    return _imagePicker;
}

- (NSMutableArray *)selectedImageArr {

    if (_selectedImageArr == nil) {
        
        NSMutableArray *selectedImageArr = [NSMutableArray arrayWithCapacity:5];
        _selectedImageArr = selectedImageArr;
    }
    return _selectedImageArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"发起申诉";
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    [self.imageView1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    [self.imageView2 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    [self.imageView3 addGestureRecognizer:tap3];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    [self.imageView4 addGestureRecognizer:tap4];
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    [self.imageView5 addGestureRecognizer:tap5];
}

#pragma mark UITableViewDelegate&&UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 10;
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

#pragma mark 点击图片进行图片选择
- (void)selectImage:(UITapGestureRecognizer *)gesture {
    
    UIImageView *tapImage = (UIImageView *)gesture.view;
    NSLog(@"%@",tapImage);
    selectedImageTag = tapImage.tag;
    
    if (!tapImage.highlighted) {
        
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self takePhoto];
            
        }]];
        
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self localPhoto];
            
        }]];
        
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
        
        [self presentViewController:alertCtrl animated:YES completion:nil];
        
    } else {
    
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [self reloadImageViews];
            
            
        }]];
                
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
        
        [self presentViewController:alertCtrl animated:YES completion:nil];
        
    }
}

#pragma mark 删除图片后，重新布局
- (void)reloadImageViews {

    [self.selectedImageArr removeObjectAtIndex:selectedImageTag-1000];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    UITableViewCell *cell  = [self.tableView cellForRowAtIndexPath:indexPath];
    
    for ( int i = 0; i<5; i++) {
    
        UIImageView *imageView = [cell.contentView viewWithTag:1000+i];
        imageView.image = [UIImage imageNamed:@"addImage"];
        imageView.hidden = YES;
        imageView.highlighted  = NO;
    }
    
    for (int i = 0; i<self.selectedImageArr.count; i++) {
        
        UIImageView *imageView = [cell.contentView viewWithTag:1000+i];
        imageView.hidden       = NO;
        imageView.image        = (UIImage *)self.selectedImageArr[i];
        imageView.highlighted  = YES;
    }
    
    UIImageView *imageView = [cell.contentView viewWithTag:1000+self.selectedImageArr.count];
    imageView.hidden       = NO;
    
    
}

#pragma mark 启动相机
- (void)takePhoto {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
        
    }else {
        
        [ProgressHUD show:@"无拍照功能"];
    }
}

#pragma mark 从本地相册选择
- (void)localPhoto {

    ZZPhotoController *photoCtrl = [[ZZPhotoController alloc]init];
    photoCtrl.selectPhotoOfMax   = 5-self.selectedImageArr.count;
    [photoCtrl showIn:self result:^(id responseObject) {

        NSArray *imageArr      = (NSArray *)responseObject;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        UITableViewCell *cell  = [self.tableView cellForRowAtIndexPath:indexPath];
        
        for (int i = 0; i<imageArr.count; i++) {
        
            UIImageView *imageView = [cell.contentView viewWithTag:1000+i+self.selectedImageArr.count];
            imageView.hidden       = NO;
            imageView.image        = (UIImage *)imageArr[i];
            imageView.highlighted  = YES;
        }
        
        if (imageArr.count < 5) {

          UIImageView *imageView = [cell.contentView viewWithTag:1000+imageArr.count];
          imageView.hidden       = NO;
        }
        
        [self.selectedImageArr addObjectsFromArray:imageArr];
        
    }];
}

#pragma mark UIImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        UIImageView *imageView = [cell.contentView viewWithTag:selectedImageTag];
        imageView.image = image;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
