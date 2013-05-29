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
    [self.backGroundImageView setImage:[PicNameMc backGroundImage]];
    [self.diyTopBar setType:DiyTopBarTypeBack];
    [self.diyTopBar.myTitle setText:@"预置主题"];
    [self.diyTopBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *themeStyle = [[NSUserDefaults standardUserDefaults] objectForKey:ThemeKey];
    if ([themeStyle isEqualToString:ThemesRed]||themeStyle == nil) {
        [self red:nil];
    }
    else if ([themeStyle isEqualToString:ThemesBlue]) {
        [self blue:nil];
    }
    else if ([themeStyle isEqualToString:ThemesGuoDong]) {
        [self guodong:nil];
    }

    
}
- (IBAction)red:(id)sender {
    [self.redLabel setTextColor:[UIColor redColor]];
    [self.blueLabel setTextColor:[UIColor blackColor]];
    [self.guodongLabel setTextColor:[UIColor blackColor]];
    [self.redLabel setText:@"使用中"];
    [self.blueLabel setText:@"请选择"];
    [self.guodongLabel setText:@"请选择"];
    [[NSUserDefaults standardUserDefaults] setObject:ThemesRed forKey:ThemeKey];
    [self.diyTopBar updateThemeColor];
    [self.backGroundImageView setImage:[PicNameMc backGroundImage]];

}
- (IBAction)blue:(id)sender {
    [self.redLabel setTextColor:[UIColor blackColor]];
    [self.blueLabel setTextColor:[UIColor blueColor]];
    [self.guodongLabel setTextColor:[UIColor blackColor]];

    [self.redLabel setText:@"请选择"];
    [self.blueLabel setText:@"使用中"];
    [self.guodongLabel setText:@"请选择"];

    [[NSUserDefaults standardUserDefaults] setObject:ThemesBlue forKey:ThemeKey];
    [self.diyTopBar updateThemeColor];
    [self.backGroundImageView setImage:[PicNameMc backGroundImage]];


}
- (IBAction)guodong:(id)sender {
    [self.redLabel setTextColor:[UIColor blackColor]];
    [self.blueLabel setTextColor:[UIColor blackColor]];
    [self.guodongLabel setTextColor:[UIColor greenColor]];

    [self.redLabel setText:@"请选择"];
    [self.blueLabel setText:@"请选择"];
    [self.guodongLabel setText:@"使用中"];

    [[NSUserDefaults standardUserDefaults] setObject:ThemesGuoDong forKey:ThemeKey];
    [self.diyTopBar updateThemeColor];
    [self.backGroundImageView setImage:[PicNameMc backGroundImage]];


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
    [self setRedLabel:nil];
    [self setBlueLabel:nil];
    [self setGuodongLabel:nil];
    [super viewDidUnload];
}
- (void)dealloc {
    [_redLabel release];
    [_blueLabel release];
    [_guodongLabel release];
    [super dealloc];
}
@end
