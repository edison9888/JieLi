//
//  PersonalitySettingViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-24.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "PersonalitySettingViewController.h"
#import "PicNameMc.h"

#define kDocument_Folder [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]


@interface PersonalitySettingViewController ()
{
    NSArray *leftImageArray;
}
@end

@implementation PersonalitySettingViewController

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
    [self.myTopBar setType:DiyTopBarTypeBack];
    self.myTopBar.myTitle.text = @"个性设置";
    [self.myTopBar.backButton addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
    
    leftImageArray = [[NSArray alloc] initWithObjects:
                      F_image_sina,
                      F_iamge_tencent,
                      F_image_renren,
//                      F_image_qzone,
//                      F_image_voicePoint,
//                      F_image_newVersionPoint,
//                      F_image_warningTone,
//                      F_image_Time,
                      F_image_presetThemes,
//                      F_image_diy,
                      F_image_themeD,
//                      F_image_alwaysHD,
                      F_image_wifiHD,
//                      F_image_cacheSettings,
                      F_image_removeCache,
                      nil];
    
    
        

    

}
-(NSString *)calculatedCapacity{
    NSFileManager *fM = [NSFileManager defaultManager];
    NSArray *fileList = [fM contentsOfDirectoryAtPath:kDocument_Folder error:nil];
    
    
    const unsigned int bytes = 1024*1024 ;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    [formatter setPositiveFormat:@"##0.00"];
    
    float size;
    NSString *path;
    
    
    //NSString *extension;
    for (int i = 1; i<[fileList count]; i++) {
        NSString *pathA = [kDocument_Folder stringByAppendingPathComponent:[fileList objectAtIndex:i]];
        NSArray *fileListAA = [fM contentsOfDirectoryAtPath:pathA error:nil];
        
        for(NSString *file in fileListAA) {
            
            path = [pathA stringByAppendingPathComponent:file];
            
            NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
            
            size=size+(float)[fileAttributes fileSize];
            
        }
    }
    NSNumber *total = [NSNumber numberWithFloat:(size/bytes)];
    
    NSLog(@"%@",[NSString stringWithFormat:@"占用容量：%@ MB",[formatter stringFromNumber:total]]);
    return [formatter stringFromNumber:total];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setMyTopBar:nil];
    [self setMyTableView:nil];
    [self setMyBgImageView:nil];
    [super viewDidUnload];
}

#pragma Mark - tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        default:
            break;
    }
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSArray *array = [PicNameMc imageName:@"icon-set5.png" numberOfH:5 numberOfW:1];

    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    switch (section) {
        case 0:
            
            switch (row) {
                case 0:
                    [cell setImage:[array objectAtIndex:row]];
                    cell.textLabel.text = @"账号绑定";
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (row) {
                case 0:
                    [cell setImage:[array objectAtIndex:2]];
                    cell.textLabel.text = @"预置主题";
                    break;
                case 1:
                    [cell setImage:[array objectAtIndex:3]];

                    cell.textLabel.text = [NSString stringWithFormat:@"缓存清空( %@ MB)",[self calculatedCapacity]];
                    break;
                case 2:
                    [cell setImage:[array objectAtIndex:4]];

                    cell.textLabel.text = @"打分鼓励";
                    break;
                default:
                    break;
            }

            break;
        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1&&indexPath.row ==0) {
        ThemesViewController *viewController = [[ThemesViewController alloc] initWithNibName:@"ThemesViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
    }

    if (indexPath.section ==1&&indexPath.row ==1) {
        NSString *mes = [NSString stringWithFormat:@"清除缓存%@ MB",[self calculatedCapacity]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"缓存清空" message:mes delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        

        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        //更改到待操作的目录下
        [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
        
        
        NSArray *fileList = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];
        NSLog(@"%@",fileList);
        for (int i = 1; i<[fileList count]; i++) {
            [fileManager removeItemAtPath:[fileList objectAtIndex:i] error:nil];

        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.myTableView reloadData];
            break;
        default:
            break;
    }
    
}


@end
