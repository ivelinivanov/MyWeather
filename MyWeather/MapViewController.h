//
//  MapViewController.h
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/16/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "WeatherIconOverlay.h"
#import "WeatherIconOverlayView.h"
#import "WeatherService.h"
#import "Constants.h"

@protocol MapViewControllerDelegate <NSObject>

-(void)dataDidFinishLoading;

@end

@interface MapViewController : UIViewController <MKMapViewDelegate, MapViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@property (strong, nonatomic) NSMutableArray *cities;
@property (strong, atomic) NSMutableDictionary *cityData;
@property (strong, nonatomic) WeatherService *weatherService;
@property (nonatomic, weak) id <MapViewControllerDelegate> delegate;

- (void)showIcons;
-(void)addOverlay:(UIImage *)image coordinates:(CLLocationCoordinate2D)coordinate;

@end
