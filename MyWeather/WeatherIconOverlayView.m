//
//  WeatherIconOverlayView.m
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/17/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "WeatherIconOverlayView.h"

@implementation WeatherIconOverlayView

- (id)initWithOverlay:(id<MKOverlay>)overlay overlayImage:(UIImage *)overlayImage
{
    self = [super initWithOverlay:overlay];
    if (self)
    {
        self.overlayImage = overlayImage;
    }
    
    return self;
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context
{
    CGImageRef imageReference = self.overlayImage.CGImage;
    
    MKMapRect theMapRect = self.overlay.boundingMapRect;
    CGRect theRect = [self rectForMapRect:theMapRect];
    
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -theRect.size.height);
    CGContextDrawImage(context, theRect, imageReference);

}

@end