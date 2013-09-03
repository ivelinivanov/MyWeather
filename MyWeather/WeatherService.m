//
//  WeatherService.m
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/18/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "WeatherService.h"

@implementation WeatherService

-(void)getForecastDictionaryForCity:(NSString *)cityName withBlock:(void (^)(NSDictionary *))block
{
    CityWeatherWebService *webService = [[CityWeatherWebService alloc] initWithCityName:cityName];
    [webService getForecastDictionary:block];
}

-(void)getGeolookupDictionaryForCity:(NSString *)cityName withBlock:(void (^)(NSDictionary *))block
{
    CityWeatherWebService *webService = [[CityWeatherWebService alloc] initWithCityName:cityName];
    [webService getGeolookupDictionary:block];
}

@end
