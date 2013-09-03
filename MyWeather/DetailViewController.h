//
//  DetailViewController.h
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/15/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CityWeatherModel.h"
#import "WeatherService.h"
#import "Constants.h"

@interface DetailViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *degreeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *forecastLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) WeatherService *weatherService;

@end
