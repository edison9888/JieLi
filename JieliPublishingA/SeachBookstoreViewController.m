//
//  SeachBookstoreViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-16.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "SeachBookstoreViewController.h"
#import "mapViewController.h"
@interface SeachBookstoreViewController ()

@end

@implementation SeachBookstoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
//        mapViewController *mapUIView = [[mapViewController alloc] initWithFrame:self.view.frame];
//        [self.view addSubview:mapUIView];

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.myTopBar setType:DiyTopBarTypeBack];
    self.myTopBar.myTitle.text = @"身边书店";
    [self.myTopBar.backButton addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];

}







- (void)viewDidUnload {
    [self setMyTopBar:nil];
    [super viewDidUnload];
}
@end
