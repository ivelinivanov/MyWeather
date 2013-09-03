//
//  CityWeatherModel.m
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/16/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "CityWeatherModel.h"

static NSString *requestURL = @"http://api.wunderground.com/api/bf2ad11a2cee5663/%@/lang:BG/q/Bulgaria/%@.json";

@implementation CityWeatherModel

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

-(void)makeConnectionWithServerOfType:(NSString *)type
{
    self.type = type;
    NSString* s = [[NSString alloc] initWithFormat:requestURL,type,self.cityName];
    NSURL* url = [NSURL URLWithString:s];
    NSURLRequest* req = [NSURLRequest requestWithURL:url];
    NSURLConnection* conn = [NSURLConnection connectionWithRequest:req delegate:self];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // connection is starting, clear buffer
    [self.receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // data is arriving, add it to the buffer
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    // something went wrong, clean up interface as needed
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Something went wrong with retreiving data for this location." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // all done, we are ready to rock and roll
    // do something with self.receivedData
    
    
    NSError *error = nil;
    
    NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:self.receivedData options:kNilOptions error:&error];
    
    NSMutableDictionary *dictForSend = [NSMutableDictionary dictionaryWithDictionary:resultDict];
    
    [dictForSend setValue:self.cityName forKey:@"cityName"];
    
    if ([self.type isEqual:@"forecast"])
    {
        if ([self.delegate respondsToSelector:@selector(didReceiveDataWithForecastDictionary:)])
        {
            [self.delegate didReceiveDataWithForecastDictionary:dictForSend];
        }
    }
    else if ([self.type isEqual:@"geolookup"])
    {
        if ([self.delegate respondsToSelector:@selector(didReceiveDataWithGeolookupDictionary:)])
        {
            [self.delegate didReceiveDataWithGeolookupDictionary:dictForSend];
        }
    }
}

@end
