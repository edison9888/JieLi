//
//  PositionAnnotation.h
//  MapTest
//
//  Created by zhangyicheng on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PositionAnnotation : NSObject <MKAnnotation> {
//    CLLocationCoordinate2D centerCoordinate;
}

@property (nonatomic, assign) CLLocationCoordinate2D centerCoordinate;
@property (nonatomic, retain) NSString* titleName;
@property (nonatomic,assign) NSString* subtitleName;
- (id) initWithCoordinate:(CLLocationCoordinate2D)position withTitle:(NSString *)name;

@end
