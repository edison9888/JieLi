//
//  SeachBookstoreViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-16.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "SeachBookstoreViewController.h"
#import "mapViewController.h"

@interface SeachBookstoreViewController (){
    BMKUserLocation *userLoc;
}

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
-(void)loadMap{
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
    //    self.view = _mapView;
    [self.view addSubview:_mapView];
    [_mapView setZoomLevel:14];
    _mapView.delegate = self;
    _search = [[BMKSearch alloc] init];
    _search.delegate = self;
    [_mapView setShowsUserLocation:YES];
}
-(void)removeMap{
    if (_mapView) {
        [_mapView removeFromSuperview];
        _mapView = nil;
    }
    [_mapView setShowsUserLocation:NO];
}
-(void)displayMapinfo:(BMKUserLocation *)userLocation{
    if (userLocation != nil) {
        userLoc = userLocation;
		NSLog(@"%f %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
        
        [_mapView setCenterCoordinate:userLocation.location.coordinate animated:NO];
        
        
        [_search poiSearchNearBy:@"书店" center:userLocation.location.coordinate radius:5000 pageIndex:0];
        
        BMKCircle *circle = [BMKCircle circleWithCenterCoordinate:userLocation.location.coordinate radius:5000];
        [_mapView addOverlay:circle];
	}
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadMap];
}
-(void)viewDidDisappear:(BOOL)animated{
    [self removeMap];
}

-(void)onGetPoiResult:(NSArray *)poiResultList searchType:(int)type errorCode:(int)error{
    if (error == BMKErrorOk) {
        BMKPoiResult *result = [poiResultList objectAtIndex:0];
        for (int i = 0; i<result.poiInfoList.count; i++) {
            BMKPoiInfo *poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation *item = [[BMKPointAnnotation alloc] init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [_mapView addAnnotation:item];
        }
    }
}
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
	[self displayMapinfo:userLocation];
}
-(BMKOverlayView*)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay{
    if([overlay isKindOfClass:[BMKCircle class]]){
        BMKCircleView *circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.03];
        circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        circleView.lineWidth = 1.5;
        return circleView;
    }
    return nil;
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
