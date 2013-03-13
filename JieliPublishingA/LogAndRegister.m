//
//  LogAndRegister.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-11-2.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "LogAndRegister.h"
#import "PicNameMc.h"
#import "DataBrain.h"
@interface LogAndRegister()

@end
@implementation LogAndRegister

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib{
    self.userNameLabel.delegate = self;
    self.passWordLabel.delegate = self;
    
    self.regUserName.delegate = self;
    self.regPassWord.delegate = self;
    self.registerView.frame = CGRectMake(self.registerView.frame.size.width,self.registerView.frame.origin.y,self.registerView.frame.size.width,self.registerView.frame.size.height);

//    //log
//    [self.myImage_bg setImage:[PicNameMc imageFromImageName:F_image_logBg]];
//    [self.myBtn_cancel setImage:[PicNameMc imageFromImageName:F_btn_cancel] forState:UIControlStateNormal];
//    
//    [self.myBtn_edit setImage:[PicNameMc imageFromImageName:F_btn_edit] forState:UIControlStateNormal];
    [self.myBtn_logIn setImage:[PicNameMc defaultBackgroundImage:@"gb" withWidth:self.myBtn_logIn.frame.size.width withTitle:@"登录" withColor:[UIColor blackColor]] forState:UIControlStateNormal];
    [self.myBtn_reg setImage:[PicNameMc defaultBackgroundImage:@"gb" withWidth:self.myBtn_reg.frame.size.width withTitle:@"注册" withColor:[UIColor blackColor]] forState:UIControlStateNormal];
//
//    
//    //reg
//    [self.myImage_bg2 setImage:[PicNameMc imageFromImageName:F_image_logBg]];
//    [self.myBtn_cancel2 setImage:[PicNameMc imageFromImageName:F_btn_cancel] forState:UIControlStateNormal];
    [self.MyBtn_sure setImage:[PicNameMc defaultBackgroundImage:@"gb" withWidth:self.MyBtn_sure.frame.size.width withTitle:@"注册" withColor:[UIColor blackColor]] forState:UIControlStateNormal];

    

    
}
-(BOOL)checkBeforeUpDate{
    if (self.userNameLabel.text.length==0||self.passWordLabel.text.length==0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"账号或密码不能为空" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:@"关闭", nil];
        [alertView show];
        return NO;
    }
    return YES;

}
- (IBAction)logButtonPressed:(id)sender {
//    [self.delegate logWithUserName:self.userNameLabel.text withPassWord:self.passWordLabel.text];
    if ([self checkBeforeUpDate]) {
        [self logWithUserName:self.userNameLabel.text withPassWord:self.passWordLabel.text];
    }
}

- (IBAction)toRegisterView:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    self.logView.frame = CGRectMake(-self.logView.frame.size.width,self.logView.frame.origin.y,self.logView.frame.size.width,self.logView.frame.size.height);
    self.registerView.frame = CGRectMake(0,self.registerView.frame.origin.y,self.registerView.frame.size.width,self.registerView.frame.size.height);
    
    [UIView commitAnimations];
}

- (IBAction)registButtonPresed:(id)sender {
//    [self.delegate registerWithUserName:self.regUserName.text withPassWord:self.regPassWord.text];
    if ([self checkBeforeUpDate]) {
    [self registerWithUserName:self.regUserName.text withPassWord:self.regPassWord.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
//    CGRect winRect = [[UIScreen mainScreen] bounds];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    self.frame = CGRectMake(0, 64, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];

    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    self.frame = CGRectMake(0,44,self.frame.size.width,self.frame.size.height);
    [UIView commitAnimations];

}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{

}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
-(void)logWithUserName:(NSString *)userName withPassWord:(NSString *)passWord{
    NSString *urlString = [NSString stringWithFormat:@"?c=Member&m=login&user=%@&password=%@",userName,passWord];
    NSURL *url = [NSURL URLWithString:[[BaseURL stringByAppendingString:urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length]>0 &&error == nil) {
            NSDictionary *result =[NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions error:&error];
            NSLog(@"用户登录%@",result);
            //            NSLog(@"获取促销优惠列表成功。");
            //            NSNumber *typeNumber = [NSNumber numberWithInt:type];
            //            [array addObject:typeNumber];
            [self performSelectorOnMainThread:@selector(logFinish:) withObject:result waitUntilDone:NO];
        }
        else if ([data length] == 0 && error == nil){
            NSLog(@"没有东西被下载。"); }
        else if (error != nil){
            NSLog(@"发生错误 = %@", error);
            
        }
    }];
    
}
-(void)registerWithUserName:(NSString *)userName withPassWord:(NSString *)passWord{
    NSString *urlString = [NSString stringWithFormat:@"?c=Member&m=register&user=%@&password=%@",userName,passWord];
    NSLog(@"%@",urlString);
    NSURL *url = [NSURL URLWithString:[[BaseURL stringByAppendingString:urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length]>0 &&error == nil) {
            NSDictionary *result =[NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions error:&error];
            NSLog(@"注册用户%@",result);
            //            NSLog(@"获取促销优惠列表成功。");
            //            NSNumber *typeNumber = [NSNumber numberWithInt:type];
            //            [array addObject:typeNumber];
            [self performSelectorOnMainThread:@selector(logFinish:) withObject:result waitUntilDone:NO];
        }
        else if ([data length] == 0 && error == nil){
            NSLog(@"没有东西被下载。"); }
        else if (error != nil){
            NSLog(@"发生错误 = %@", error);
            
        }
    }];
    
}
-(void)logFinish:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    int biaozhi = [[dic objectForKey:@"result"] integerValue];
    if (biaozhi==1) {
        [self close];
        [self.delegate logSuccessWithMemberInfo:dic];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"账号或密码错误" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:@"关闭", nil];
        [alertView show];
        
    }
    
}
-(void)regFinish:(NSDictionary *)dic{
    NSLog(@"%@",dic);
    
}
-(void)close{
    [self.bgImageView removeFromSuperview];
    [self removeFromSuperview];

    
}

- (IBAction)cancel:(id)sender {
    
    //    self.pointToView.hidden = NO;
    [self close];
    [self.delegate cancleBack];

}

#pragma mark-
#pragma alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [self cancel:nil];
            break;
        default:
            break;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
