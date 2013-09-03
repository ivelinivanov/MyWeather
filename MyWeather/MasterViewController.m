//
//  MasterViewController.m
//  MyWeather
//
//  Created by Ivelin Ivanov on 7/15/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@implementation MasterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	    
    UIBarButtonItem *barMapButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(showMapView:)];
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    
    //NSArray *buttons = @[barMapButton];
    
    self.navigationItem.rightBarButtonItem = barMapButton;

    //Putting the Buttons on the Carrier
    
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.cities = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:kCityListKey]];
    
    }

#pragma mark - City List Management Methots

- (void)insertNewObject:(id)sender
{
    if (!self.cities) {
        self.cities = [[NSMutableArray alloc] init];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add city" message:@"Enter city name:" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
       
}

-(void)saveCityList
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:self.cities] forKey:kCityListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark Alert View Delegate Methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *alertText = [alertView textFieldAtIndex:0].text;
    BOOL flag = YES;
    
    for(NSString *city in self.cities)
    {
        if( [alertText caseInsensitiveCompare:city] == NSOrderedSame )
        {
            flag = NO;
        }
    }
    
    if ((buttonIndex == 0) && (alertText.length !=0) && flag)
    {
        [self.cities insertObject:[alertView textFieldAtIndex:0].text atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self saveCityList];
    }
}

#pragma mark - Table View

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    id object = [self.cities objectAtIndex:sourceIndexPath.row];
    [self.cities removeObjectAtIndex:sourceIndexPath.row];
    [self.cities insertObject:object atIndex:destinationIndexPath.row];
    
    [self saveCityList];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.cities[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.cities removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 
        [self saveCityList];
    }
        
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];

    if(editing)
    {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
        self.navigationItem.rightBarButtonItem = addButton;
    }
    else
    {
        UIBarButtonItem *barMapButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(showMapView:)];
        self.navigationItem.rightBarButtonItem = barMapButton;
    }
}

#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *object = self.cities[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (IBAction)showMapView:(id)sender
{
    [self performSegueWithIdentifier:@"mapSegue" sender:sender];
}

@end
