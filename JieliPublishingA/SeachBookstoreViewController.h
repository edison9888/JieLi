//
//  SeachBookstoreViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-16.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PositionAnnotation.h"
#import "DiyTopBar.h"
#import "BMapKit.h"

@interface SeachBookstoreViewController : UIViewController<CLLocationManagerDelegate,BMKMapViewDelegate,BMKSearchDelegate>{
    BMKSearch *_search;
    BMKMapView *_mapView;

}

//@property (nonatomic,retain) CLLocationManager *locationManager;
//@property (nonatomic, assign) CLLocationCoordinate2D currentCoordinate;
//@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet DiyTopBar *myTopBar;
@end
