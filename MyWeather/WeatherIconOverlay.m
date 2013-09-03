//
//  WeatherIconOverlay.m
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/17/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "WeatherIconOverlay.h"


@implementation WeatherIconOverlay 

@synthesize boundingMapRect;
@synthesize coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord image:(UIImage *)image
{
    self = [super init];
    if (self)
    {
        self.image = image;
        coordinate = coord;

        MKMapPoint upperLeft   = MKMapPointForCoordinate(CLLocationCoordinate2DMake(self.coordinate.latitude + 0.3, self.coordinate.longitude - 0.4));
        MKMapPoint upperRight  = MKMapPointForCoordinate(CLLocationCoordinate2DMake(self.coordinate.latitude + 0.3, self.coordinate.longitude + 0.4));
        MKMapPoint bottomLeft  = MKMapPointForCoordinate(CLLocationCoordinate2DMake(self.coordinate.latitude - 0.3, self.coordinate.longitude - 0.4));

        
        MKMapRect bounds = MKMapRectMake(upperLeft.x, upperLeft.y, fabs(upperLeft.x - upperRight.x), fabs(upperLeft.y - bottomLeft.y));
        
        boundingMapRect = bounds;
    }
    
    return self;
}



@end
