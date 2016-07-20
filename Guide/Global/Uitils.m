#import "Uitils.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

@implementation Uitils
//检测可用网络
+ (void)reach {
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case 0:
                [ProgressHUD showError:@"网络异常,请检查网络"];
                break;
            case 1:
                [ProgressHUD showSuccess:@"3G/4G网络已连接"];
                
                break;
            case 2:
                [ProgressHUD showSuccess:@"wifi已连接"];
                
                break;
            default:
                break;
        }
        
        FxLog(@"%ld",(long)status);
    }];                                                                                                              
}


+ (void)shake:(UITextField *)label {
    
    label.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:nil context:nil];//动画的开始
    [UIView setAnimationDuration:0.05];//完成时间
    [UIView setAnimationRepeatCount:3];//重复
    [UIView setAnimationRepeatAutoreverses:YES];//往返运动
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//控制速度变化
    label.transform = CGAffineTransformMakeTranslation(-5, 0);//设置横纵坐标的移动
    [UIView commitAnimations];//动画结束
}


//照片压缩
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


//获取AuthData
+ (id)getUserDefaultsForKey:(NSString *)key
{
    if (key ==nil || [key length] <=0) {
        return nil;
    }
    id  AuthData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return AuthData;
}

//保存AuthData
+ (void)setUserDefaultsObject:(id)value ForKey:(NSString *)key
{
    if (key !=nil && [key length] >0) {
        [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

//删除NSUserdefault
+ (void)UserDefaultRemoveObjectForKey:(NSString *)key
{
    if (key !=nil && [key length] >0) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (UIColor *)colorWithHex:(unsigned long)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:1];
}


+(void)cacheImage:(NSString *)urlStr withImageV:(UIImageView *)imageV withPlaceholder:(NSString *)placehImg{

    [imageV sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:placehImg]];
}

+ (void)cacheImagwWithSize:(CGSize)size imageID:(NSString *)imageID imageV:(UIImageView *)imageV placeholder:(NSString *)placehImg {

    NSString *urlStr = [NSString stringWithFormat:@"%@%@_%.0f_%.0f_0.png",BaseImageURL,imageID,size.width,size.height];
    NSURL    *url = [NSURL URLWithString:urlStr];
    FxLog(@"url = %@",url);
    [imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placehImg]];
}

+ (NSString *)toImageName:(NSString *)dataString {

    NSString *imageName;
    
    //红币
    if ([dataString isEqualToString:@"red"]) {
        
        imageName = @"图层-143";
    //蓝币
    }else if ([dataString isEqualToString:@"blue"]) {
        
        imageName = @"图层-146";
    
    //绿币
    }else if ([dataString isEqualToString:@"green"]) {
        
        imageName = @"图层-145";
        
    //黑币
    }else if ([dataString isEqualToString:@"black"]) {
        
        imageName = @"图层-144";
        
     //金币
    }else {
    
        imageName = @"图层-142";
    }
    
    
    return imageName;
    
}

+ (NSString *)toChinses:(NSString *)dataString {
    
    NSString *chinese;
    
    //红币
    if ([dataString isEqualToString:@"red"]) {
        
        chinese = @"红币";
        //蓝币
    }else if ([dataString isEqualToString:@"blue"]) {
        
        chinese = @"蓝币";
        
        //绿币
    }else if ([dataString isEqualToString:@"green"]) {
        
        chinese = @"绿币";
        
        //黑币
    }else if ([dataString isEqualToString:@"black"]) {
        
        chinese = @"黑币";
        
        //金币
    }else {
        
        chinese = @"金币";
    }
    
    
    return chinese;
}

+ (NSInteger)dayCountWithYear:(NSInteger)year month:(NSInteger)month {

    NSInteger count = 0;
    
        if (month == 2) {
            if((year % 4 == 0 && year % 100!=0) || year % 400 == 0) //是闰年
            {
                count = 29;
            }
            else
            {
                count = 28;
            }
            
        }else if (month == 4 || month == 6 || month == 9 || month == 11){
            count = 30;
            
        }else{
            
            count = 31;
        }
    
    return count;
}



////判断密码强弱
//+ (BOOL) judgeRange:(NSArray*) _termArray Password:(NSString*) _password
//{
//    NSRange range;
//    BOOL result =NO;
//    for(int i=0; i<[_termArray count]; i++)
//    {
//        range = [_password rangeOfString:[_termArray objectAtIndex:i]];
//        if(range.location != NSNotFound)
//        {
//            result =YES;
//        }
//    }
//    return result;
//}

//给你一个方法，输入参数是NSDate，输出结果是星期几的字符串。
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];

}

/////判断密码强弱
//+ (NSString*) judgePasswordStrength:(NSString*) _password
//{
//    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
//    
//    NSArray* termArray1 = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
//    NSArray* termArray2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
//    NSArray* termArray3 = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
//    NSArray* termArray4 = [[NSArray alloc] initWithObjects:@"~",@"`",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"-",@"_",@"+",@"=",@"{",@"}",@"[",@"]",@"|",@":",@";",@"“",@"'",@"‘",@"<",@",",@".",@">",@"?",@"/",@"、", nil];
//    
//    NSString* result1 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray1 Password:_password]];
//    NSString* result2 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray2 Password:_password]];
//    NSString* result3 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray3 Password:_password]];
//    NSString* result4 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray4 Password:_password]];
//    
//    [resultArray addObject:[NSString stringWithFormat:@"%@",result1]];
//    [resultArray addObject:[NSString stringWithFormat:@"%@",result2]];
//    [resultArray addObject:[NSString stringWithFormat:@"%@",result3]];
//    [resultArray addObject:[NSString stringWithFormat:@"%@",result4]];
//    
//    int intResult=0;
//    for (int j=0; j<[resultArray count]; j++)
//    {
//        if ([[resultArray objectAtIndex:j] isEqualToString:@"1"])
//        {
//            intResult++;
//        }
//    }
//    NSString* resultString = [[NSString alloc] init];
//    if (intResult <= 2)
//    {
//        resultString = @"密码强度低，建议修改";
//    }
//    else if (intResult == 2&&[_password length]>=6)
//    {
//        resultString = @"密码强度一般";
//    }
//    if (intResult > 2&&[_password length]>=6)
//    {
//        resultString = @"密码强度高";
//    }
//    return resultString;
//}

/*
 1.获得屏幕图像
 - (UIImage *)imageFromView: (UIView *) theView
 {
 
 UIGraphicsBeginImageContext(theView.frame.size);
 CGContextRef context = UIGraphicsGetCurrentContext();
 [theView.layer renderInContext:context];
 UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 
 return theImage;
 }
 
 2.label的动态size
 
 - (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize
 
 {
 
 NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
 
 paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
 
 NSDictionary* attributes =@{NSFontAttributeName:[UIFont fontWithName:@"MicrosoftYaHei" size:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
 
 CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
 
 labelSize.height=ceil(labelSize.height);
 return labelSize;
 
 }
 
 3.时间戳转化为时间
 
 -(NSString*)TimeTrasformWithDate:(NSString *)dateString
 {
 NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
 [formatter setDateFormat:@"YY-MM-dd HH:mm"];
 [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
 
 NSString *date = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:dateString.integerValue]];
 //NSLog(@"date1:%@",date);
 return date;
 
 }
 
 4.RGB转化成颜色
 
 + (UIColor *)colorFromHexRGB:(NSString *)inColorString
 {
 UIColor *result = nil;
 unsigned int colorCode = 0;
 unsigned char redByte, greenByte, blueByte;
 
 if (nil != inColorString)
 {
 NSScanner *scanner = [NSScanner scannerWithString:inColorString];
 (void) [scanner scanHexInt:&colorCode]; // ignore error
 }
 redByte = (unsigned char) (colorCode >> 16);
 greenByte = (unsigned char) (colorCode >> 8);
 blueByte = (unsigned char) (colorCode); // masks off high bits
 result = [UIColor
 colorWithRed: (float)redByte / 0xff
 green: (float)greenByte/ 0xff
 blue: (float)blueByte / 0xff
 alpha:1.0];
 return result;
 }
 
 5.加边框
 
 UIRectCorner corners=UIRectCornerTopLeft | UIRectCornerTopRight;
 UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
 byRoundingCorners:corners
 cornerRadii:CGSizeMake(4, 0)];
 CAShapeLayer *maskLayer = [CAShapeLayer layer];
 maskLayer.frame         = view.bounds;
 maskLayer.path          = maskPath.CGPath;
 view.layer.mask         = maskLayer;
 6.//压缩图片
 + (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
 {
 //创建一个图形上下文形象
 UIGraphicsBeginImageContext(newSize);
 // 告诉旧图片画在这个新的环境,所需的
 // new size
 [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
 //获取上下文的新形象
 UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
 // 结束上下文
 UIGraphicsEndImageContext();
 return newImage;
 }
 
 7.textfield的placeholder
 
 [textF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
 [textF setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
 8.
 
 butLeft. imageEdgeInsets = UIEdgeInsetsMake (7 , 5 , 7 , 25  );
 butLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
 9.//调用此方法改变label最后2个字符的大小
 - (void)label:(UILabel *)label BehindTextSize:(NSInteger)integer
 {
 NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc] initWithString:label.text];
 
 [mutaString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(label.text.length-2, 2)];
 label.attributedText = mutaString;
 }
 
 10.- (void)ChangeLabelTextColor:(UILabel *)label
 {
 NSMutableAttributedString *mutaString = [[NSMutableAttributedString alloc] initWithString:label.text];
 
 [mutaString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:207/255.0 green:34/255.0 blue:42/255.0 alpha:1] range:NSMakeRange(0, 5)];
 label.attributedText = mutaString;
 }
 
 11.
 
 if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
 
 [tableView setSeparatorInset:UIEdgeInsetsZero];
 
 }
 if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
 if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
 
 [tableView setLayoutMargins:UIEdgeInsetsZero];
 
 }
 }
 
 // Do any additional setup after loading the view.
 }
 - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
 
 {
 
 if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
 
 [cell setSeparatorInset:UIEdgeInsetsZero];
 
 }
 if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
 if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
 
 [cell setLayoutMargins:UIEdgeInsetsZero];
 
 }
 }
 
 
 }
 12。图片变灰度
 
 -(UIImage *) grayscaleImage: (UIImage *) image
 {
 CGSize size = image.size;
 CGRect rect = CGRectMake(0.0f, 0.0f, image.size.width,
 image.size.height);
 // Create a mono/gray color space
 CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
 CGContextRef context = CGBitmapContextCreate(nil, size.width,
 size.height, 8, 0, colorSpace, kCGImageAlphaNone);
 CGColorSpaceRelease(colorSpace);
 // Draw the image into the grayscale context
 CGContextDrawImage(context, rect, [image CGImage]);
 CGImageRef grayscale = CGBitmapContextCreateImage(context);
 CGContextRelease(context);
 // Recover the image
 UIImage *img = [UIImage imageWithCGImage:grayscale];
 CFRelease(grayscale);
 return img;
 }
 13.16进制转rgb
 
 #define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
 */


@end
