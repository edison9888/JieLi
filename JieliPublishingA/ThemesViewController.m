//
//  ThemesViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-1.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "ThemesViewController.h"
#import "PicNameMc.h"
@interface ThemesViewController ()

@end

@implementation ThemesViewController

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
    [self.diyTopBar setType:DiyTopBarTypeBack];
    [self.diyTopBar.myTitle setText:@"预置主题"];
    [self.diyTopBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)popBack{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDiyTopBar:nil];
    [super viewDidUnload];
}
@end
