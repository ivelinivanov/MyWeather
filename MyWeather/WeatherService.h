//
//  WeatherService.h
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/18/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityWeatherWebService.h"

@interface WeatherService : NSObject

@property (copy, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSMutableData *receivedData;

-(void)getForecastDictionaryForCity:(NSString*) cityName withBlock:(void (^)(NSDictionary *)) block;
-(void)getGeolookupDictionaryForCity:(NSString*) cityName withBlock:(void (^)(NSDictionary *)) block;

@end
