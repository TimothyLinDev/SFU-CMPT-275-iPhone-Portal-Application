//
//  CampusDetail.h
//  SFUPA
//  Team 07
//  Created by Aman on 4/2/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Amandeep Saini
//
//  Assignment 5:
//  Edited by: | What was done?
//  Amandeep   | Created and assign and send value
//

#import "CampusDetails.h"
#import <Foundation/Foundation.h>


@interface CampusDetails ()
{
    NSDictionary *currentWeather;
    NSDictionary *tomWeather;
    NSDictionary *todayWeather;
}

@end


#define getDataURL @"http://api.lib.sfu.ca/weather/forecast?key=&lat=&long=&location=burnaby"

@implementation CampusDetails
@synthesize jsonArray, weatherArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", self.segueData);
    //_lblNavBar.text = self.segueData;
    
    if ([self.segueData isEqualToString:@"Burnaby"])
    {
        [self retrieveDataBurnaby];
    }
    else if ([self.segueData isEqualToString:@"Surrey"])
    {
        [self retrieveDataSurrey];
    }
    else if ([self.segueData isEqualToString:@"Vancouver"])
    {
        [self retrieveDataVancouver];
    }
    
    
    //[self retrieveDataBurnaby];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) retrieveDataBurnaby
{
    _lblNavBar.text = self.segueData;
    _lblAddress.text = @"8888 University Drive, \n Burnaby, BC V5A 1S6";
    _lblContactNumber.text = @"(778) 782-3111";
    _lblEmergencyNumber.text = @"(778)782-4500 ";
    [self retireveDataWeather];
}

- (void) retrieveDataSurrey
{
    _lblNavBar.text = self.segueData;
    _lblAddress.text = @"250 - 13450 – 102nd Avenue, Surrey, BC V3T 0A3";
    _lblContactNumber.text = @"(778) 782-3111";
    _lblEmergencyNumber.text = @"(778) 782-7511";
    [self retireveDataWeather];
}

- (void) retrieveDataVancouver
{
    _lblNavBar.text = self.segueData;
    _lblAddress.text = @"Harbour Centre 515 West Hastings St. Vancouver, BC V6B 5K3";
    _lblContactNumber.text = @"(778) 782-6930";
    _lblEmergencyNumber.text = @"(778) 782-5252 ";
    [self retireveDataWeather];
}

-(void) retireveDataWeather
{
    NSURL * url = [NSURL URLWithString:getDataURL];
    NSData * data= [NSData dataWithContentsOfURL:url];
    
    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",jsonArray);
    
    currentWeather = [jsonArray valueForKey:@"currently"];
    NSLog(@"Current: %@", currentWeather);
    
    if(currentWeather != nil)
    {
        NSLog(@"Icon: %@", [currentWeather objectForKey:@"icon"]);
        if([[currentWeather objectForKey:@"icon"]  isEqual: @"rain"])
        {
            _UICurrentImage.image = [UIImage imageNamed:@"rain.png"];
        }
        else if ([[currentWeather objectForKey:@"icon"]  isEqual: @"partly-cloudy-night"])
        {
            _UICurrentImage.image = [UIImage imageNamed:@"partlycloudynight.png"];
        }
        else if ([[currentWeather objectForKey:@"icon"]  isEqual: @"partly-cloudy-day"])
        {
            _UICurrentImage.image = [UIImage imageNamed:@"partlycloudyday.png"];
        }
        else if ([[currentWeather objectForKey:@"icon"]  isEqual: @"clear-day"])
        {
            _UICurrentImage.image = [UIImage imageNamed:@"clearday.png"];
        }
        
        _lblCurrentStatus.text = [currentWeather objectForKey:@"summary"];
        //NSLog(@"Summary: %@", [currentWeather objectForKey:@"summary"]);
        
        _lblCurrentTemp.text = [currentWeather objectForKey:@"temperature"];
        //NSLog(@"Temp: %@", [currentWeather objectForKey:@"temperature"]);
    }
    else
    {
        NSLog(@"ERROR: Will put message box here");
    }
    

    tomWeather = [jsonArray valueForKey:@"tomorrow"];
    NSLog(@"Tomorrow: %@", tomWeather);
    
    if(tomWeather != nil)
    {
        NSLog(@"Icon: %@", [tomWeather objectForKey:@"icon"]);
        
        if([[tomWeather objectForKey:@"icon"]  isEqual: @"rain"])
        {
            _UITomImage.image = [UIImage imageNamed:@"rain.png"];
        }
        else if ([[tomWeather objectForKey:@"icon"]  isEqual: @"partly-cloudy-night"])
        {
            _UITomImage.image = [UIImage imageNamed:@"partly-cloudy-night.png"];
        }
        else if ([[tomWeather objectForKey:@"icon"]  isEqual: @"partly-cloudy-day"])
        {
            _UITomImage.image = [UIImage imageNamed:@"partly-cloudy-day.png"];
        }
        else if ([[tomWeather objectForKey:@"icon"]  isEqual: @"clear-day"])
        {
            _UITomImage.image = [UIImage imageNamed:@"clear-day.png"];
        }
        
        _lblTomStatus.text = [tomWeather objectForKey:@"summary"];
        //NSLog(@"Summary: %@", [tomWeather objectForKey:@"summary"]);
        
        _lblTomMin.text = [tomWeather objectForKey:@"min_temperature"];
        //NSLog(@"Min Temp: %@", [tomWeather objectForKey:@"min_temperature"]);
        
        _lblTomMax.text = [tomWeather objectForKey:@"max_temperature"];
        //NSLog(@"Max Temp: %@", [tomWeather objectForKey:@"max_temperature"]);
    }
    else
    {
        NSLog(@"ERROR: Will put message box here");
    }
}
@end