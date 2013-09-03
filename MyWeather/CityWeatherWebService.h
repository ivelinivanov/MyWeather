//
//  CityWeatherWebService.h
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/18/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityWeatherWebService : NSObject

@property (copy, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (copy, nonatomic) void (^block)(NSDictionary *);

-(id)initWithCityName:(NSString *)cityName;
-(void)connectToServerUsingURL:(NSString *) url;

-(void)getForecastDictionary:(void (^)(NSDictionary *)) block;
-(void)getGeolookupDictionary:(void (^)(NSDictionary *)) block;

@end
