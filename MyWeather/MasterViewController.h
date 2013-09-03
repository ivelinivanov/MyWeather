//
//  MasterViewController.h
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/15/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface MasterViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *cities;

- (IBAction)showMapView:(id)sender;

@end
