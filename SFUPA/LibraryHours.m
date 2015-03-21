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

#define getDataURL @"http://api.lib.sfu.ca/hours/summary"
@interface LibraryHours ()
{
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
    
    [self retrieveData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) retrieveData
{
    NSURL * url = [NSURL URLWithString:getDataURL];
    NSData * data= [NSData dataWithContentsOfURL:url];
    
    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",jsonArray);
    
    //location = [jsonArray valueForKey:@"location"];
    //NSLog(@"LOCATION: %@", location);
    
    bennettOpenTime = [jsonArray valueForKey:@"open_time"];
    NSLog(@"Bennett Open Time: %@",bennettOpenTime[0]);
    
    bennettCloseTime = [jsonArray valueForKey:@"close_time"];
    NSLog(@"Bennett Closed Time: %@",bennettCloseTime[0]);
    
    fraserOpenTime = [jsonArray valueForKey:@"open_time"];
    NSLog(@"Fraser Open Time: %@",fraserOpenTime[1]);
    
    fraserCloseTime = [jsonArray valueForKey:@"close_time"];
    NSLog(@"Fraser Closed Time: %@",fraserCloseTime[1]);
    
    belzbergOpenTime = [jsonArray valueForKey:@"open_time"];
    NSLog(@"Belzberg Open Time: %@",belzbergOpenTime[2]);
    
    belzbergCloseTime = [jsonArray valueForKey:@"close_time"];
    NSLog(@"Belzberg Closed Time: %@",belzbergCloseTime[2]);
    
    [bbyOpenTimeLabel setText:[NSString stringWithFormat:@"%@", bennettOpenTime[0]]];
    [bbyCloseTimeLabel setText:[NSString stringWithFormat:@"%@", bennettCloseTime[0]]];
    //[surOpenTimeLabel setText:[NSString stringWithFormat:@"%@", fraserOpenTime[1]]];
    //[surCloseTimeLabel setText:[NSString stringWithFormat:@"%@", fraserCloseTime[1]]];
    //[vanOpenTimeLabel setText:[NSString stringWithFormat:@"%@", belzbergOpenTime[2]]];
    //[vanCloseTimeLabel setText:[NSString stringWithFormat:@"%@", belzbergCloseTime[2]]];
    
    
    
    /*
    checkedout = [jsonArray valueForKey:@"checkedout"];
    total = [jsonArray valueForKey:@"total"];
    available = [jsonArray valueForKey:@"available"];
    unavailable = [jsonArray valueForKey:@"unavailable"];
    NSLog(@"C: %@",checkedout);
    NSLog(@"T: %@",total);
    NSLog(@"A: %@",available);
    NSLog(@"U: %@",unavailable);
    
    [checkedoutLabel setText:[NSString stringWithFormat:@"%@", checkedout]];
    [totalLabel setText:[NSString stringWithFormat:@"%@", total]];
    [availableLabel setText:[NSString stringWithFormat:@"%@", available]];
    [unavailableLabel setText:[NSString stringWithFormat:@"%@", unavailable]];
    */
    
}


@end