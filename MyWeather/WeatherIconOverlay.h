//
//  WeatherIconOverlay.h
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/17/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WeatherIconOverlay : NSObject <MKOverlay>

@property (weak, nonatomic) UIImage *image;

-(id)initWithCoordinate:(CLLocationCoordinate2D) coord image:(UIImage *) image;

@end
