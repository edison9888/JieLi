//
//  PositionAnnotation.m
//  MapTest
//
//  Created by zhangyicheng on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PositionAnnotation.h"

@implementation PositionAnnotation

//@synthesize centerCoordinate;
//@synthesize title_;
//@synthesize subtitle_;
- (id) initWithCoordinate:(CLLocationCoordinate2D)position withTitle:(NSString *)name{
    self = [super init];
    if (self != nil) {
        _centerCoordinate.latitude = position.latitude;
        _centerCoordinate.longitude = position.longitude;
        _titleName = name;
    }
    return self;
}


- (CLLocationCoordinate2D)coordinate;
{
    NSLog(@"%f,%f",_centerCoordinate.latitude,_centerCoordinate.longitude);
    return _centerCoordinate;
}

- (NSString *)title
{
    NSLog(@"%@",_titleName);
    return _titleName;
}

- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"%f,%f",_centerCoordinate.longitude,_centerCoordinate.latitude];
}

@end
