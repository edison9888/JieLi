//
//  SecondViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-12.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "SecondViewController.h"
#import "PicNameMc.h"

#define H_CONTROL_ORIGIN CGPointMake(20, 70)

@interface SecondViewController ()
@property (nonatomic,strong) BookShelfTableViewController *tC;
@end

@implementation SecondViewController
-(AppDelegate *)app{
    if (!_app) {
        _app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return _app;
}
-(DataBrain *)dataBrain{
    if (!_dataBrain) {
        _dataBrain = self.app.dataBrain;
    }
    return _dataBrain;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"搜索", @"搜索");
        self.tabBarItem.image = [UIImage imageNamed:@"tabBar_2"];
    }
    return self;
}
- (IBAction)viewTap:(id)sender {
    [self returnKeyBoard];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.myDiyTopBar.myTitle setText:@"图书搜索"];
    [self.sBackground setImage:[PicNameMc defaultBackgroundImage:@"sBg" withWidth:self.sBackground.frame.size.width withTitle:nil withColor:nil]];
    [self.myTextField setBackground:[PicNameMc defaultBackgroundImage:@"inputBox@2x.png" size:self.myTextField.frame.size leftCapWidth:10 topCapHeight:10]];
    self.dataBrain.getListDelegate = self;
    
    NSString *initParam = [[NSString alloc] initWithFormat:
						   @"server_url=%@,appid=%@",ENGINE_URL,APPID];
    
	// init the RecognizeControl
    // 初始化语音识别控件
	_iFlyRecognizeControl = [[IFlyRecognizeControl alloc] initWithOrigin:H_CONTROL_ORIGIN initParam:initParam];
	
    [self.view addSubview:_iFlyRecognizeControl];
    
    // Configure the RecognizeControl
    // 设置语音识别控件的参数,具体参数可参看开发文档
	[_iFlyRecognizeControl setEngine:@"sms" engineParam:nil grammarID:nil];
	[_iFlyRecognizeControl setSampleRate:16000];
	_iFlyRecognizeControl.delegate = self;
    

}

- (IBAction)searchButtonPressed:(id)sender {
    [self search];
}




- (void)search {
    int number = [self.myTextField.text length];
    if (number) {
        NSLog(@"以关键字：%@搜索",self.myTextField.text);
        [self returnKeyBoard];
        NSString *keyWord = self.myTextField.text;
        SearchPoeration *op = [[SearchPoeration alloc] initWithKeyWord:keyWord];
        op.delegate = self;
        [[AppDelegate shareQueue] addOperation:op];
    }
}

-(void)finishPoeration:(id)result{
    if (!result) {
        return;
    }
    NSLog(@"%@",result);
    NSArray *array = [BookInfo bookInfoWithJSON:result];
    if (self.tC) {
        [self.tC.view removeFromSuperview];
        self.tC = nil;
    }
    
        self.tC = [[BookShelfTableViewController alloc] initWithStyle:UITableViewStylePlain];
        self.tC.delegate = self;
        [self.tC.tableView setBackgroundColor:[UIColor clearColor]];
        [self.tC.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tC.tableView setShowsVerticalScrollIndicator:NO]; 
        [self.tC loadBooks:array];
        [self.tC.tableView setFrame:CGRectMake(0, 85, 320,326)];
        [self.view addSubview:self.tC.tableView];
}

-(void)pushOut:(HCTadBarController *)tab{
    [self.navigationController pushViewController:tab animated:YES];
}

#pragma mark
#pragma TextFiledrDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textFiel{
    [self returnKeyBoard];
    [self search];
    return YES;
}





-(void)returnKeyBoard{
    [self.myTextField endEditing:YES];
}
-(void)disableButton{
    [self returnKeyBoard];
}
- (IBAction)onButtonRecognize:(id)sender {
    if([_iFlyRecognizeControl start])
	{
		[self disableButton];
	}

}

-(void)onUpdateTextField:(NSString *)sentence{
    if ([sentence length]>0) {
        NSMutableString *string = [NSMutableString stringWithString:sentence];
        [string replaceCharactersInRange:NSMakeRange([sentence length]-1, 1) withString:@" "];
        sentence = string;

    }
    NSString *str = [[NSString alloc] initWithFormat:@"%@%@", self.myTextField.text, sentence];
	self.myTextField.text = str;
	NSLog(@"str");

}

- (void)onRecognizeResult:(NSArray *)array
{
    //  execute the onUpdateTextView function in main thread
    //  在主线程中执行onUpdateTextView方法
	[self performSelectorOnMainThread:@selector(onUpdateTextField:) withObject:
	 [[array objectAtIndex:0] objectForKey:@"NAME"] waitUntilDone:YES];
}




#pragma mark
#pragma 语音接口实现

- (void) onGrammer:(NSString *)grammer error:(int)err
{
    NSLog(@"the error is:%d",err);
    
}

- (void) onRecognizeEnd:(IFlyRecognizeControl *)iFlyRecognizeControl theError:(int)error
{
    NSLog(@"识别结束回调finish.....");
	NSLog(@"getUpflow:%d,getDownflow:%d",[iFlyRecognizeControl getUpflow],[iFlyRecognizeControl getDownflow]);
    
}

- (void)onResult:(IFlyRecognizeControl *)iFlyRecognizeControl theResult:(NSArray *)resultArray
{
	[self onRecognizeResult:resultArray];
	
}


//=================================================

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setMyTextField:nil];
    [self setMyBgImageView:nil];
    [self setMyDiyTopBar:nil];
    [self setSBackground:nil];
    [super viewDidUnload];
}

@end
