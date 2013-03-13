//
//  mapViewController.h
//  map
//
//  Created by ZYJ on 12-10-18.
//  Copyright (c) 2012年 ZYJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PositionAnnotation.h"

@interface mapViewController : UIView<CLLocationManagerDelegate,MKMapViewDelegate>{
}
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,assign) CLLocationCoordinate2D currentCoordinate;
//@property (nonatomic,retain) PositionAnnotation *selfAnnotation;
@property (nonatomic,retain) NSMutableArray *annotationArray;
@end

 