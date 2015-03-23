//
//  LibraryHours.m
//  SFUPA
//
//  Created by Aman on 3/20/15.
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
#import "LibraryHours.h"

//Declare the URL where we will get the data
#define getDataURL @"http://api.lib.sfu.ca/hours/summary"
@interface LibraryHours ()
{
    //Declare some Array's that store the value of the OpenTime and CloseTime of the 3 campus
    NSArray *bennettOpenTime;
    NSArray *bennettCloseTime;
    NSArray *bennettTime;
    NSArray *fraserOpenTime;
    NSArray *fraserCloseTime;
    NSArray *belzbergOpenTime;
    NSArray *belzbergCloseTime;
}


@end

@implementation LibraryHours
@synthesize jsonArray, hoursArray, bbyOpenTimeLabel, surOpenTimeLabel, vanOpenTimeLabel, bbyCloseTimeLabel, surCloseTimeLabel, vanCloseTimeLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Caling the method Retrieve Data
    [self retrieveData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Method
- (void) retrieveData
{
    //Setting the URL variable with getDataURL
    NSURL * url = [NSURL URLWithString:getDataURL];
    NSData * data= [NSData dataWithContentsOfURL:url];
    
    //Storing the json file in this array 
    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",jsonArray);
    
    //Assigning Open time value to Bennett
    bennettOpenTime = [jsonArray valueForKey:@"open_time"];
    NSLog(@"Bennett Open Time: %@",bennettOpenTime[0]);
    
    //Assigning Close time value to Bennett
    bennettCloseTime = [jsonArray valueForKey:@"close_time"];
    NSLog(@"Bennett Close Time: %@",bennettCloseTime[0]);
    
    //Assigning Open time value to Fraser
    fraserOpenTime = [jsonArray valueForKey:@"open_time"];
    NSLog(@"Fraser Open Time: %@",fraserOpenTime[1]);
    
    //Assigning Close time value to Fraser
    fraserCloseTime = [jsonArray valueForKey:@"close_time"];
    NSLog(@"Fraser Close Time: %@",fraserCloseTime[1]);
    
    //Assigning Open time value to Belzberg
    belzbergOpenTime = [jsonArray valueForKey:@"open_time"];
    NSLog(@"Belzberg Open Time: %@",belzbergOpenTime[2]);
    
    //Assigning Close time value to Belzberg
    belzbergCloseTime = [jsonArray valueForKey:@"close_time"];
    NSLog(@"Belzberg Close Time: %@",belzbergCloseTime[2]);
    
    //Transfering the assigned value to a Label
    [bbyOpenTimeLabel setText:[NSString stringWithFormat:@"%@", bennettOpenTime[0]]];
    [bbyCloseTimeLabel setText:[NSString stringWithFormat:@"%@", bennettCloseTime[0]]];
    [surOpenTimeLabel setText:[NSString stringWithFormat:@"%@", fraserOpenTime[1]]];
    [surCloseTimeLabel setText:[NSString stringWithFormat:@"%@", fraserCloseTime[1]]];
    [vanOpenTimeLabel setText:[NSString stringWithFormat:@"%@", belzbergOpenTime[2]]];
    [vanCloseTimeLabel setText:[NSString stringWithFormat:@"%@", belzbergCloseTime[2]]];
}
@end