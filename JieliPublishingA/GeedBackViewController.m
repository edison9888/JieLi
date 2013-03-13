//
//  GeedBackViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-2-26.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "GeedBackViewController.h"

@interface GeedBackViewController ()

@end

@implementation GeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.diyTopBar.myTitle.text = @"意见反馈";
    [self.diyTopBar setType:DiyTopBarTypeBackAndCollect];
    [self.diyTopBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.diyTopBar.collectButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.diyTopBar.collectButton addTarget:self action:@selector(faSong) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)faSong{
    
}
-(void)popBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self.textFildA setPlaceholder:@""];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.textView.text length]==0) {
        [self.textFildA setPlaceholder:@"请输入您的意见反馈"];

    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];

    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDiyTopBar:nil];
    [self setTextFildA:nil];
    [self setTextView:nil];
    [super viewDidUnload];
}
@end
