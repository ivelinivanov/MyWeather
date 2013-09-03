//
//  WeatherIconOverlayView.h
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/17/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface WeatherIconOverlayView : MKOverlayView

@property (nonatomic, strong) UIImage *overlayImage;

- (id)initWithOverlay:(id<MKOverlay>)overlay overlayImage:(UIImage *)overlayImage;

@end
