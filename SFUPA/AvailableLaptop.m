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

#define getDataURL @"http://api.lib.sfu.ca/equipment/laptop/count"
@interface AvailableLaptop ()
{
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
    
    
}


@end