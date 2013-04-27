//
//  CellOfBd.m
//  JieliPublishingA
//
//  Created by HuaChen on 13-4-27.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "CellOfBd.h"
#import "PicNameMc.h"
@interface CellOfBd (){
    BOOL isBoorn;
}
@property (nonatomic,strong)UIImage *uBdImage;
@property (nonatomic,strong)UIImage *bdImage;
@property (nonatomic,assign)BOOL *isBd;
@property (nonatomic,assign)ShareType type;
@end

@implementation CellOfBd

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib{
    isBoorn = YES;
    [self.titleLabel setText:@"账号未绑定"];
    
    [self.logOutButton setImage:[PicNameMc defaultBackgroundImage:@"rb" withWidth:self.logOutButton.frame.size.width withTitle:@"注销" withColor:[UIColor whiteColor]] forState:UIControlStateNormal];
}
-(void)setShareType:(ShareType)type{
    self.type = type;
    NSString *imagePathu = nil;
    NSString *imagePathB = nil;
    if (type == ShareTypeSinaWeibo) {
        imagePathu = [[NSBundle mainBundle] pathForResource:@"F_image_share_sina@2x" ofType:@"png"];
        imagePathB = [[NSBundle mainBundle] pathForResource:@"F_image_share_sinaB@2x" ofType:@"png"];
    }
    else if (type == ShareTypeTencentWeibo){
        imagePathu = [[NSBundle mainBundle] pathForResource:@"F_image_share_teng@2x" ofType:@"png"];
        imagePathB = [[NSBundle mainBundle] pathForResource:@"F_image_share_tengB@2x" ofType:@"png"];
    }
    self.uBdImage = [UIImage imageWithContentsOfFile:imagePathu];
    self.bdImage = [UIImage imageWithContentsOfFile:imagePathB];

    [self checkState];

}
-(void)checkState{
    id<ISSCredential> ic = [ShareSDK getCredentialWithType:self.type];
    
    if ([ic available]) {
        NSLog(@"授权状态");
        [self.BdImageView setImage:self.bdImage];
        [self.titleLabel setText:@"账号已绑定"];
        [self.logOutButton setHidden:NO];
    }
    else{
        [self.BdImageView setImage:self.uBdImage];
        [self.titleLabel setText:@"账号未绑定"];
        [self.logOutButton setHidden:YES];

    }

}
- (IBAction)logOutTouched:(id)sender {
    [ShareSDK cancelAuthWithType:self.type];
    [self checkState];
}
-(void)shouQuan{
    [ShareSDK ssoEnabled:NO];
    id<ISSCredential> ic = [ShareSDK getCredentialWithType:self.type];
    
    if (![ic available]) {
        id<ISSAuthOptions> op = [ShareSDK authOptionsWithAutoAuth:YES allowCallback:NO authViewStyle:SSAuthViewStylePopup viewDelegate:nil authManagerViewDelegate:nil];
        
        [ShareSDK authWithType:self.type options:op result:^(SSAuthState state, id<ICMErrorInfo> error) {
            if (state == SSAuthStateSuccess)
            {
                NSLog(@"成功");
                [self checkState];
            }
            else if (state == SSAuthStateFail)
            {
                NSLog(@"失败");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"账号绑定" message:@"授权失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
        }];
        
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)dealloc {
    [_BdImageView release];
    [_titleLabel release];
    [_logOutButton release];
    [super dealloc];
}
@end
