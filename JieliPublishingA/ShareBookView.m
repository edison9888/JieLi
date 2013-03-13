//
//  ShareBookView.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-1-10.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "ShareBookView.h"
#import "DataBrain.h"
#import "PicNameMc.h"
@interface ShareBookView (){
NSDictionary *userInfo;
NSArray *statuses;
NSString *postStatusText;
WeiBoBar *sinaWeiBoBar;
}
@end


@implementation ShareBookView

- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.sinaweibo.delegate = self;
    return delegate.sinaweibo;
}
- (IBAction)addComment:(id)sender {
    [self.delegate pushMessageView];
    
    
}
- (IBAction)sendWeiBo:(id)sender {
    NSString *sendMessage = [self.delegate sendWeiBoWithString];
    UIImage *sendImage = [self.delegate sendWieBoWithImage];
    [self sendSinaWeiBoWithString:sendMessage withImage:sendImage];
    
}




-(void)sendSinaWeiBoWithString:(NSString *)string withImage:(UIImage *)image{
    SinaWeibo *sinaweibo = [self sinaweibo];
    BOOL authValid = sinaweibo.isAuthValid;
    if (!authValid) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        NSLog(@"%@", [keyWindow subviews]);
        userInfo = nil;
        statuses = nil;
        [sinaweibo logIn];
    }
    else{
        [sinaweibo requestWithURL:@"statuses/upload.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   string, @"status",
                                   image, @"pic", nil]
                       httpMethod:@"POST"
                         delegate:self];
        
    }

}
- (IBAction)logOutSina:(id)sender {
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo logOut];
    
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self storeAuthData];
    [sinaWeiBoBar setState:ShareState];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
    [sinaWeiBoBar setState:LogInState];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
    [sinaWeiBoBar setState:LogInState];

}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
    [sinaWeiBoBar setState:LogInState];

}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
    [sinaWeiBoBar setState:LogInState];

}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        userInfo = nil;
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        statuses = nil;
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" failed!", postStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        
        NSLog(@"Post status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" failed!", postStatusText]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
    
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        userInfo = result;
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        statuses = [result objectForKey:@"statuses"];
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        
        postStatusText = nil;
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        
        postStatusText = nil;
    }
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib{
    
    [self.addComment setImage:[PicNameMc defaultBackgroundImage:@"gb" withWidth:self.addComment.frame.size.width withTitle:@"添加评价" withColor:[UIColor blackColor]] forState:UIControlStateNormal];
    [self.sendWeiBo setImage:[PicNameMc defaultBackgroundImage:@"gb" withWidth:self.sendWeiBo.frame.size.width withTitle:@"发送分享" withColor:[UIColor blackColor]] forState:UIControlStateNormal];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WeiBoBar" owner:self options:nil];
    sinaWeiBoBar = [nib objectAtIndex:0];
    sinaWeiBoBar.weiBoStyle = KeyStyleOfSina;
    sinaWeiBoBar.delegate = self;
    [sinaWeiBoBar setTextWithLogeIn:@"绑定新浪微博" withShare:@"分享至新浪微博"];
    if (!self.sinaweibo.isAuthValid) {
        [sinaWeiBoBar setState:LogInState];
    }
    else{
        [sinaWeiBoBar setState:ShareState];
        [sinaWeiBoBar checkSelected];

    }
//    sinaWeiBoBar.backgroundColor = [UIColor redColor];
    sinaWeiBoBar.frame = CGRectMake(0, 50, 320, sinaWeiBoBar.frame.size.height);
    [self addSubview:sinaWeiBoBar];
}

-(void)shareBookViewAppear{
    if (!self.sinaweibo.isAuthValid) {
        [sinaWeiBoBar setState:LogInState];
    }
    else{
        [sinaWeiBoBar setState:ShareState];
    }

}

#pragma weibodelegate
-(void)logInWithWerboBar:(WeiBoBar *)weiBoBar{
    SinaWeibo *sinaweibo = [self sinaweibo];
    BOOL authValid = sinaweibo.isAuthValid;
    if (!authValid) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        NSLog(@"%@", [keyWindow subviews]);
        userInfo = nil;
        statuses = nil;
        [sinaweibo logIn];
    }
}



@end
