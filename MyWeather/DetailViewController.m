//
//  DetailViewController.m
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/15/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "DetailViewController.h"
#import "CityWeatherModel.h"

@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    self.detailDescriptionLabel.text = [self.detailItem description];
    self.loadingIndicator.hidesWhenStopped = YES;
    
    [self.loadingIndicator startAnimating];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
        
        self.weatherService = [[WeatherService alloc] init];
        
        [self.weatherService getForecastDictionaryForCity:[self.detailItem description] withBlock:^(NSDictionary *dataDictionary)
         {
             NSString *queryStatus = [dataDictionary valueForKeyPath:kErrorTypeKey];
             
             if (![queryStatus isEqual:@"querynotfound"])
             {
                 NSDictionary *forecastDict = [[dataDictionary valueForKeyPath:kForecastDictionaryKey] objectAtIndex:0];
                 self.forecastLabel.text = [forecastDict  objectForKey:kForecastTextKey];
                 
                 NSDictionary *conditionsDict = [[dataDictionary valueForKeyPath:kConditionsDictionaryKey] objectAtIndex:0];
                 NSString *degreeString = [[NSString alloc] initWithFormat:@"%@\u00B0 / %@\u00B0", [conditionsDict valueForKeyPath:kHighTempKey], [conditionsDict valueForKeyPath:kLowTempKey]];
                 self.degreeLabel.text = degreeString;
                 
                 NSString *iconURL = [conditionsDict objectForKey:kIconUrlKey];
                 
                 NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: iconURL]];
                 
                 self.weatherIcon.image = [UIImage imageWithData: data];
                 
                 [self.loadingIndicator stopAnimating];
                 
                 self.weatherIcon.hidden = NO;
                 self.forecastLabel.hidden = NO;
                 self.degreeLabel.hidden = NO;
             }
             else
             {
                 [self.loadingIndicator stopAnimating];
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"There is currently no weather information for this city." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
         }];
    }
}

#pragma mark - Alert View Delegate Methods

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
