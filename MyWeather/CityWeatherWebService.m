//
//  CityWeatherWebService.m
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/18/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "CityWeatherWebService.h"

static NSString *kForecastRequestURL = @"http://api.wunderground.com/api/bf2ad11a2cee5663/forecast/lang:BG/q/Bulgaria/%@.json";
static NSString *kGeolookupRequestURL = @"http://api.wunderground.com/api/bf2ad11a2cee5663/geolookup/lang:BG/q/Bulgaria/%@.json";

@implementation CityWeatherWebService

-(id)initWithCityName:(NSString *)cityName
{
    if([super init])
    {
        NSString *name = [cityName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        self.cityName = name;
        self.receivedData = [NSMutableData data];
        return self;
    }
    else
    {
        return nil;
    }
}

-(void)connectToServerUsingURL:(NSString *)url
{
    NSString* s = [[NSString alloc] initWithFormat:url, self.cityName];
    NSURL* urlPath = [NSURL URLWithString:s];
    NSURLRequest* req = [NSURLRequest requestWithURL:urlPath];
    NSURLConnection* conn = [NSURLConnection connectionWithRequest:req delegate:self];
}

#pragma mark - Get Data Dictionary Methods

-(void)getForecastDictionary:(void (^)(NSDictionary *))block
{
    self.block = block;
    [self connectToServerUsingURL:kForecastRequestURL];
}

-(void)getGeolookupDictionary:(void (^)(NSDictionary *))block
{
    self.block = block;
    [self connectToServerUsingURL:kGeolookupRequestURL];
}

#pragma mark - Connection Delegate Methods

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Something went wrong with retreiving data for this location." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    
    NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:self.receivedData options:kNilOptions error:&error];
    
    NSMutableDictionary *dictForSend = [NSMutableDictionary dictionaryWithDictionary:resultDict];
    
    [dictForSend setValue:self.cityName forKey:@"cityName"];
    
    self.block(dictForSend);
}

@end
