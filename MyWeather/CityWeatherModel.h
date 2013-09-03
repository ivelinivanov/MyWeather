//
//  CityWeatherModel.h
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/16/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CityWeatherModelDelegate <NSObject>

@optional
- (void)didReceiveDataWithForecastDictionary:(NSDictionary*)dataDictionary;
- (void)didReceiveDataWithGeolookupDictionary:(NSDictionary*)dataDictionary;
@end

@interface CityWeatherModel : NSObject

@property (nonatomic, weak) id <CityWeatherModelDelegate> delegate;
@property (copy, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) void (^block)(NSDictionary *);

-(id)initWithCityName:(NSString *)cityName;
-(void)makeConnectionWithServerOfType:(NSString *)type;

-(void)getForecastDictionary:(void (^)(NSDictionary *)) block;
-(void)getGeolookupDictionary:(void (^)(NSDictionary *)) block;


@end
