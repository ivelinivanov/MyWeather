//
//  MapViewController.m
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/16/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController
{
    int receivedCoordinatesCounter;
    int receivedImagesCounter;
}

-(void)awakeFromNib
{
     self.cities = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:kCityListKey]];
    self.delegate = self;
    self.cityData = [[NSMutableDictionary alloc] init];
    receivedCoordinatesCounter = 0;
    receivedImagesCounter = 0;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
    [self.loadingIndicator startAnimating];
    self.loadingIndicator.hidesWhenStopped = YES;
    
    for(NSString *city in self.cities)
    {
        self.weatherService = [[WeatherService alloc] init];
        [self.weatherService getGeolookupDictionaryForCity:city withBlock:^(NSDictionary *dataDictionary)
         {
             NSString *latitude = [dataDictionary valueForKeyPath:@"location.lat"];
             NSString *longitude = [dataDictionary valueForKeyPath:@"location.lon"];
             NSString *cityName = [dataDictionary valueForKey:@"cityName"];
             
             NSMutableDictionary *location = [[NSMutableDictionary alloc] init];
             [location setValue:longitude forKey:@"lon"];
             [location setValue:latitude forKey:@"lat"];
             
             receivedCoordinatesCounter ++;
             
             [self.cityData setValue:location forKey:cityName];
             
             if(([self.cities count] == [self.cityData count]) && (receivedImagesCounter == [self.cities count]) && (receivedCoordinatesCounter == [self.cityData count]))
             {
                 receivedCoordinatesCounter = 0;
                 receivedImagesCounter = 0;
                 if([self.delegate respondsToSelector:@selector(dataDidFinishLoading)])
                     [self.delegate dataDidFinishLoading];
             }
         }];
    }
    
    for (NSString *city in self.cities)
    {
        self.weatherService = [[WeatherService alloc] init];
        [self.weatherService getForecastDictionaryForCity:city withBlock:^(NSDictionary *dataDictionary)
         {
             NSDictionary *conditionsDict = [[dataDictionary valueForKeyPath:kConditionsDictionaryKey] objectAtIndex:0];
             NSString *iconURL = [conditionsDict objectForKey:kIconUrlKey];
             NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: iconURL]];
             NSString *cityName = [dataDictionary valueForKey:@"cityName"];
             
             receivedImagesCounter++;
             
             UIImage *image = [UIImage imageWithData: data];
             
             [[self.cityData objectForKey:cityName] setValue:image forKey:@"weatherIconImage"];
             
             if(([self.cities count] == [self.cityData count]) && (receivedImagesCounter == [self.cities count]) && (receivedCoordinatesCounter == [self.cityData count]))
             {
                 receivedCoordinatesCounter = 0;
                 receivedImagesCounter = 0;
                 if([self.delegate respondsToSelector:@selector(dataDidFinishLoading)])
                     [self.delegate dataDidFinishLoading];
             }
         }];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MKCoordinateRegion CSC;
    
    CSC.center.latitude = kBulgariaLatitude;
    CSC.center.longitude = kBulgariaLongitude;

    CSC.span.latitudeDelta = kLatLonDelta;
    CSC.span.longitudeDelta = kLatLonDelta;
    
    [self.mapView setRegion:CSC animated:NO];

}

#pragma mark - MapViewController Delegate Methods

-(void)dataDidFinishLoading
{
    [self showIcons];
    [self.loadingIndicator stopAnimating];
    [self.mapView setHidden:NO];
}

#pragma mark - Overlay Methods

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:WeatherIconOverlay.class])
    {
        UIImage *image = [(WeatherIconOverlay *)overlay image];
        WeatherIconOverlayView *overlayView = [[WeatherIconOverlayView alloc] initWithOverlay:overlay overlayImage:image];
        
        return overlayView;
    }
    
    return nil;
}

- (void)showIcons
{
    NSArray *keys = [self.cityData allKeys];
    
    for(NSString *key in keys)
    {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [[[self.cityData objectForKey:key] objectForKey:@"lat"] doubleValue];
        coordinate.longitude = [[[self.cityData objectForKey:key] objectForKey:@"lon"] doubleValue];
        
        UIImage *image = [[self.cityData objectForKey:key] objectForKey:@"weatherIconImage"];
        
        [self addOverlay:image coordinates:coordinate];
    }
    
}

-(void)addOverlay:(UIImage *)image coordinates:(CLLocationCoordinate2D)coordinate
{
    WeatherIconOverlay *overlay = [[WeatherIconOverlay alloc] initWithCoordinate:coordinate image:image];
    [self.mapView addOverlay:overlay];
}


@end
