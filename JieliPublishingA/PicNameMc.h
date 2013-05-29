//
//  PicNameMc.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-11-6.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ThemeKey @"themes"
#define ThemesRed @"red"
#define ThemesBlue @"blue"
#define ThemesGuoDong @"guodong"



#define DefaultImage @"defaultImage"
#define WoodPattern @"WoodPattern"
#define Logo @"logo"
//首页
#define F_btn_1 @"F_btn_book"//接力好书
#define F_btn_2 @"F_btn_promotion"//促销优惠
#define F_btn_3 @"F_btn_active"//读书活动
#define F_btn_4 @"F_btn_map"//身边书店
#define F_btn_5 @"F_btn_vip"//会员专区
#define F_btn_6 @"F_btn_setting"//个性设置

#define F_bg @"F_woodBg" //背景

#define F_btn_bg @"F_btn_bg" //通用按钮背景

//接力好书
#define F_image_pattren1 @"F_image_pattren1"
#define F_image_pattren2 @"F_image_pattren2"
#define F_image_pattren3 @"F_image_pattren3"
#define F_image_pattren4 @"F_image_pattren4"

#define _image_priceBg @"priceBg"//书架价格木条

//书籍详情
#define F_btn_collect @"F_btn_collect"

#define F_btn_compereBuy @"F_btn_compereBuy"
#define F_btn_evaShare @"F_btn_evaShare"
#define F_btn_readOnLine @"F_btn_readOnLine"
#define F_btn_share @"F_btn_share"
 
#define F_image_woodFrame @"F_image_woodFrame"

//促销优惠
#define F_image_woodBar1 @"priceBg"
#define F_btn_actDeLink @"F_btn_actDeLink"

//读书活动
#define F_image_poste @"F_image_poste"
#define F_btn_joinActivity @"F_btn_joinActivity"
#define F_btn_shareActivity @"F_btn_shareActivity"


#define F_btn_daJoin @"F_btn_daJoin"
#define F_btn_dirLeft @"F_btn_dirLeft"
#define F_btn_dirRight @"F_btn_dirRight"
#define F_btn_dirShare @"F_btn_dirShare"
#define F_image_photoBg @"F_image_photoBg"




//会员登录
#define F_btn_cancel @"F_btn_cancel"
#define F_btn_edit @"F_btn_edit"
#define F_btn_logIn @"F_btn_logIn"
#define F_btn_register @"F_btn_register"
#define F_btn_sure @"F_btn_sure"
#define F_image_logBg @"F_image_logBg"
#define F_image_bgOfVip1 @"F_image_bgOfVip1"
#define F_image_bgOfVip2 @"F_image_bgOfVip2"
#define F_image_bgOfVip3 @"F_image_bgOfVip3"
#define F_image_bgOfVip4 @"F_image_bgOfVip4"
#define F_quickLogBg @"F_quickLogBg"
#define F_image_shelfBg @"F_image_shelfBg"
#define F_btn_myBuy @"F_btn_myBuy"
#define F_btn_myCollect @"F_btn_myCollect"

//个性设置
#define F_image_sina @"F_image_sina"
#define F_iamge_tencent @"F_image_tencent"
#define F_image_renren @"F_image_renren"
#define F_image_qzone @"F_image_qzone"

#define F_image_voicePoint @"F_image_voicePoint"
#define F_image_newVersionPoint @"F_image_newVersionPoint"
#define F_image_warningTone @"F_image_warningTone"
#define F_image_Time @"F_image_Time"

#define F_image_presetThemes @"F_image_presetThemes"
#define F_image_diy @"F_image_diy"
#define F_image_themeD @"F_image_themeD"

#define F_image_alwaysHD @"F_image_alwaysHD"
#define F_image_wifiHD @"F_image_wifiHD"
#define F_image_cacheSettings @"F_image_cacheSettings"
#define F_image_removeCache @"F_image_removeCache"


//搜索
#define F_image_search @"F_image_search"
#define F_btn_search @"F_btn_search"
//更多
#define F_image_informFriend @"F_image_informFriend"
#define F_image_grade @"F_image_grade"
#define F_image_geedback @"F_image_geedback"
#define F_image_aboutUs @"F_image_aboutUs"
#define F_image_version @"F_image_version"
#define F_image_versionUpdate @"F_image_versionUpdate"
#define F_image_help @"F_image_help"

@interface PicNameMc : NSObject
+(UIImage *)imageFromImageName:(NSString *)imageName;
+(NSArray *)imageName:(NSString *)imageName numberOfH:(int)nh numberOfW:(int)nw;
+ (UIImage*)defaultBackgroundImage:(NSString *)imageName withWidth:(int)width withTitle:(NSString *)title withColor:(UIColor *)color;
+(UIImage *)defaultBackgroundImage:(NSString *)imageName size:(CGSize)size leftCapWidth:(NSInteger )leftCapWidth topCapHeight:(NSInteger)topCapHeight;
+(UIImage *)inputImagewithView:(UIView *)view;

//主题
+(UIImage *)buttonBg:(UIView *)view title:(NSString *)title;
+(UIImage *)grayBg:(UIView *)view title:(NSString *)title;
+(UIImage *)diyTopBarBackGroundImage;
+(NSArray *)homeIcons;
+(UIImage *)PromotionActLinkImage;
+(UIImage*)backGroundImage;

@end
