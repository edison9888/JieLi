//
//  PicNameMc.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-11-6.
//  Copyright (c) 2012年 中卡. All rights reserved.
//
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#import "PicNameMc.h"
typedef enum {
    ThemeRed = 0,
    ThemeBlue,
    ThemeGuoDong
}ThemeStyle;

@implementation PicNameMc

#pragma 主题设置
+(ThemeStyle)checkThemeStyle{
    NSString *style =  [[NSUserDefaults standardUserDefaults] objectForKey:ThemeKey];
    if (!style||[style isEqualToString:ThemesRed]) {
        return ThemeRed;
    }
    else if ([style isEqualToString:ThemesBlue]){
        return ThemeBlue;
    }
    else if ([style isEqualToString:ThemesGuoDong]){
        return ThemeGuoDong;
    }
    return ThemeRed;
}

+(NSString *)imageNameForThemeStyleWithNames:(NSArray *)names{
    int index = [[self class] checkThemeStyle];
    if (!(index<[names count])) {
        return nil;
    }
    return [names objectAtIndex:index];
}
//返回红底白字
+(UIImage *)buttonBg:(UIView *)view title:(NSString *)title{
    NSString *imageName = [[self class] imageNameForThemeStyleWithNames:@[@"rb",@"bb",@"guob"]];
    return [PicNameMc defaultBackgroundImage:imageName withWidth:view.frame.size.width withTitle:title withColor:[UIColor whiteColor]];
}
//返回灰底黑字
+(UIImage *)grayBg:(UIView *)view title:(NSString *)title{
    return [PicNameMc defaultBackgroundImage:@"gb" withWidth:view.frame.size.width withTitle:title withColor:[UIColor blackColor]];
}
//DiyTopBar背景
+(UIImage *)diyTopBarBackGroundImage{
    NSString *imageName = [[self class] imageNameForThemeStyleWithNames:@[@"topBar_red",@"topBar_blue",@"topBar_guodong"]];
    if ([imageName isEqualToString:@"topBar_guodong"]) {
        return [UIImage imageNamed:imageName];
    }
    return [[self class] defaultBackgroundImage:imageName size:CGSizeMake(320, 44) leftCapWidth:0 topCapHeight:0];
}
//首页六个图标
+(NSArray *)homeIcons{
    NSString *imageName = [[self class] imageNameForThemeStyleWithNames:@[@"homeicon_red@2x.png",@"homeicon_blue@2x.png",@"homeicon_guo@2x.png"]];
    return [[self class] imageName:imageName numberOfH:2 numberOfW:3];
}
//促销优惠-》详情连接
+(UIImage *)PromotionActLinkImage{
    NSString *imageName = [[self class] imageNameForThemeStyleWithNames:@[@"lfd_red@2x.png",@"lfd_blue@2x.png",@"lfd_gou@2x.png"]];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}
//背景
+(UIImage*)backGroundImage{
    NSString *imageName = [[self class] imageNameForThemeStyleWithNames:@[@"WoodPattern@2x.png",@"WoodPattern_blue@2x.png",@"WoodPattern_guo@2x.png"]];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}



//返回输入框，背景框iamge
+(UIImage *)inputImagewithView:(UIView *)view{
    return [PicNameMc defaultBackgroundImage:@"inputBox@2x.png" size:view.frame.size leftCapWidth:10 topCapHeight:10];
}
//
+(UIImage *)imageFromImageName:(NSString *)imageName{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:imagePath];
}
//图片分割输出
+(NSArray *)imageName:(NSString *)imageName numberOfH:(int)nh numberOfW:(int)nw{
    NSMutableArray *images = [NSMutableArray array];
    UIImage *image = [UIImage imageNamed:imageName];
    CGSize siz = image.size;
    float height = siz.height/nh;
    float width = siz.width/nw;
    for (int i = 0; i<nh; i++) {
        for (int j = 0; j<nw; j++) {
            CGRect rect = CGRectMake(width*j, height*i, width, height);
            CGImageRef imageRef=CGImageCreateWithImageInRect([image CGImage],rect);
            UIImage* elementImage=[UIImage imageWithCGImage:imageRef];
            [images addObject:elementImage];

        }
    }
    return [[NSArray alloc] initWithArray:images];
}


//返回可以带颜色文字的底图
+ (UIImage*)defaultBackgroundImage:(NSString *)imageName withWidth:(int)width withTitle:(NSString *)title withColor:(UIColor *)color{
    // Get the image that will form the top of the background
    UIImage* topImage = [UIImage imageNamed:imageName];
    
    // Create a new image context
    //UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, topImage.size.height*2 + 5), NO, 0.0);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, topImage.size.height), NO, 0.0);
    
    int d = (topImage.size.width -1)/2;
    // Create a stretchable image for the top of the background and draw it
    UIImage* stretchedTopImage = [topImage stretchableImageWithLeftCapWidth:d topCapHeight:0];
    //[stretchedTopImage drawInRect:CGRectMake(0, 5, width, topImage.size.height)];
    CGRect rect = CGRectMake(0, 0, width, topImage.size.height);
    [stretchedTopImage drawInRect:rect];
    if (title) {
        UILabel *label = [[UILabel alloc] init];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        [label setTextColor:color];
        [label drawTextInRect:rect];

    }
    
    // Draw a solid black color for the bottom of the background
    //    if (self.useGlossEffect) {
    //        [[UIColor blackColor] set];
    //        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, self.frame.size.height / 2, width, self.frame.size.height / 2));
    //    }
    
    // Generate a new image
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}
+(UIImage *)defaultBackgroundImage:(NSString *)imageName size:(CGSize)size leftCapWidth:(NSInteger )leftCapWidth topCapHeight:(NSInteger)topCapHeight{
    UIImage *img = [UIImage imageNamed:imageName];
    if (isRetina) {
        size = CGSizeMake(size.width*2, size.height*2);
//        leftCapWidth = leftCapWidth*2;
//        topCapHeight = topCapHeight*2;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    UIImage *bImage = [img stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [bImage drawInRect:rect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
    
}

@end
