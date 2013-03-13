//
//  mapViewController.m
//  map
//
//  Created by ZYJ on 12-10-18.
//  Copyright (c) 2012年 ZYJ. All rights reserved.
//

#import "mapViewController.h"
#import "JSON.h"
#define SearchRadius 8000.f
#define SelfLocation self.mapView.userLocation.coordinate
#define SearchKey @"书店"
#define URL [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%f&types=book_store&name=%@&sensor=false&key=AIzaSyCNh9vLq11BiWhXjbvlzMkhymlLxb3kj6U",SelfLocation.latitude,SelfLocation.longitude,SearchRadius,SearchKey]
@interface mapViewController(){
    NSTimer *timer;//update更新
}
@end

@implementation mapViewController
- (NSMutableArray *)annotationArray{
    if (!_annotationArray) {
        _annotationArray = [[NSMutableArray alloc] init];
        [_annotationArray removeAllObjects];
    }
    return _annotationArray;
}


//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        //检测定位服务是否开启
//        BOOL ok = [CLLocationManager locationServicesEnabled];
//
//        if (ok) {
//            self.locationManager = [[CLLocationManager alloc] init];
//            self.locationManager.distanceFilter = 1000;
//            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//            self.locationManager.delegate = self;
//            [self.locationManager startUpdatingLocation];
//            
//        }else{
//            [self openLocationManager];
//        }
//        [self addMapView];
//    }
//    return self;
//}
//
-(void)awakeFromNib{
    //检测定位服务是否开启
    BOOL ok = [CLLocationManager locationServicesEnabled];
    
    if (ok) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.distanceFilter = 1000;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
        
    }else{
        [self openLocationManager];
    }
    
    [self addMapView];
    

}
- (void)addMapView{
    self.mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.mapView.showsUserLocation = YES;
    
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setUserInteractionEnabled:YES];
    
    [self.mapView setDelegate:self];
    [self addSubview:self.mapView];

//    [self addSelfLocationAnnotation];
}
- (void)addLocationAnnotation:(CLLocationCoordinate2D )coord withName:(NSString *)name{
    for (NSObject *obj in self.annotationArray) {
        PositionAnnotation *obj_Ann = (PositionAnnotation *)obj;
        if ([name isEqualToString:obj_Ann.titleName]) {
            return;
        }
    }
    
    PositionAnnotation *ann = [[PositionAnnotation alloc] initWithCoordinate:coord withTitle:name];
    [self.mapView addAnnotation:ann];
    [self.annotationArray addObject:ann];
}
- (void)updateSelfAnnotationLocation{
    MKCoordinateRegion reg = MKCoordinateRegionMakeWithDistance(SelfLocation, 500, 500);
    self.mapView.region = reg;
    
    [self searchNear];

}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {

    NSTimeInterval howRecent = [newLocation.timestamp timeIntervalSinceNow];
    NSLog(@"%f",howRecent);
    
    if (howRecent < -10)  return;
    if (newLocation.horizontalAccuracy >100) return;
        
    [self.locationManager stopUpdatingLocation];

    
}
#pragma mark - mapkit Methods

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"更新自己坐标");
    [self updateSelfAnnotationLocation];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	
	[self.locationManager stopUpdatingLocation];
	self.locationManager.delegate = nil;
}

#pragma mark - 开启定位服务

-(void)openLocationManager{
    NSLog(@"开启定位服务");
}

#pragma mark - 定位搜索
-(void)searchNear{
    //@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=500&name=书店&sensor=false&key=AIzaSyCNh9vLq11BiWhXjbvlzMkhymlLxb3kj6U",SelfLocation.latitude,SelfLocation.longitude
    NSString *urlString = URL;

    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
//    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
//    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length]>0 &&error == nil) {
            NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",result);
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSDictionary *json = [parser objectWithString:result error:nil];
            
            NSDictionary *d_Result = [json objectForKey:@"results"];
            
            NSArray *a = (NSArray *)d_Result;
            
            for (int i = 0; i < a.count; i++) {
                
                NSDictionary *bookStore = (NSDictionary *)[a objectAtIndex:i];
                NSString *bookStore_Name = [self bookStoreName:bookStore];
                CLLocationCoordinate2D bookStore_Location = [self bookStoreLocation:bookStore];
                [self addLocationAnnotation:bookStore_Location withName:bookStore_Name];
                
            }

//            [self resolveResult:result];

        }
        else if ([data length] == 0 && error == nil){
            NSLog(@"Nothing was downloaded."); }
        else if (error != nil){
            NSLog(@"Error happened = %@", error);
        }
    }];
}
- (NSString *)bookStoreName:(NSDictionary *)bookStore{
    NSString *name = [bookStore objectForKey:@"name"];
    NSLog(@"书店");
    NSLog(@"%@",name);
    return name;
}
- (CLLocationCoordinate2D )bookStoreLocation:(NSDictionary *)bookStore{
    NSDictionary *geometry = [bookStore objectForKey:@"geometry"];
    NSDictionary *location = [geometry objectForKey:@"location"];
    NSString *lat = [location objectForKey:@"lat"];
    NSString *lng = [location objectForKey:@"lng"];
    NSLog(@"坐标：：");
    NSLog(@"%.6f,%.6f",[lat floatValue],[lng floatValue]);
    return CLLocationCoordinate2DMake([lat floatValue], [lng floatValue]);
}
- (void)resolveResult:(NSString *)result{
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSDictionary *json = [parser objectWithString:result error:nil];
    
    NSDictionary *d_Result = [json objectForKey:@"results"];
    
    NSArray *a = (NSArray *)d_Result;
    
    for (int i = 0; i < a.count; i++) {
        
        NSDictionary *bookStore = (NSDictionary *)[a objectAtIndex:i];
        NSString *bookStore_Name = [self bookStoreName:bookStore];
        CLLocationCoordinate2D bookStore_Location = [self bookStoreLocation:bookStore];
        [self addLocationAnnotation:bookStore_Location withName:bookStore_Name];
        
    }

}




@end
