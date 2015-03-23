//
//  AvailableLaptop.m
//  SFUPA
//
//  Created by Aman on 3/19/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Amandeep Saini
//
//  Assignment 3:
//  Edited by: | What was done?
//  Amandeep   | Created

#import <Foundation/Foundation.h>
#import "AvailableLaptop.h"

//Declare the URL where we will get the data
#define getDataURL @"http://api.lib.sfu.ca/equipment/laptop/count"
@interface AvailableLaptop ()
{
    //Declare some string that store the value of the total, checkedout, available and unavailable laptops
    NSString *total;
    NSString *checkedout;
    NSString *available;
    NSString *unavailable;
}


@end

@implementation AvailableLaptop
@synthesize jsonArray, laptopArray, checkedoutLabel, availableLabel, totalLabel, unavailableLabel;

- (void)viewDidLoad {
    [super viewDidLoad];

    //Calling the method Retrieve Data
    [self retrieveData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) retrieveData
{
    //Setting the URL variable with getDataURL
    NSURL * url = [NSURL URLWithString:getDataURL];
    NSData * data= [NSData dataWithContentsOfURL:url];
    
    //Storing the json file in this array
    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",jsonArray);

    //Assigning checkedout value to a variable named checkedout
    checkedout = [jsonArray valueForKey:@"checkedout"];
    NSLog(@"C: %@",checkedout);
    
    //Assigning total value to a variable named total
    total = [jsonArray valueForKey:@"total"];
    NSLog(@"T: %@",total);
    
    //Assigning available value to a variable named available
    available = [jsonArray valueForKey:@"available"];
    NSLog(@"A: %@",available);
    
    //Assigning unavailable value to a variable named unavailable
    unavailable = [jsonArray valueForKey:@"unavailable"];
    NSLog(@"U: %@",unavailable);
    
    
    //Transfering the assigned value to a Label
    [checkedoutLabel setText:[NSString stringWithFormat:@"%@", checkedout]];
    [totalLabel setText:[NSString stringWithFormat:@"%@", total]];
    [availableLabel setText:[NSString stringWithFormat:@"%@", available]];
    [unavailableLabel setText:[NSString stringWithFormat:@"%@", unavailable]];
    
    
}


@end