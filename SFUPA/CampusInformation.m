//
//  CampusInformation.m
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


#import "CampusInformation.h"
#import "CampusDetails.h"

@interface CampusInformation ()


@end

@implementation CampusInformation

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"Burnaby"])
    {
        CampusDetails *cd = (CampusDetails *)segue.destinationViewController;
        cd.segueData = @"Burnaby";
    }
    else if([segue.identifier isEqualToString:@"Surrey"])
    {
        CampusDetails *cd = (CampusDetails *)segue.destinationViewController;
        cd.segueData = @"Surrey";
    }
    else if([segue.identifier isEqualToString:@"Vancouver"])
    {
        CampusDetails *cd = (CampusDetails *)segue.destinationViewController;
        cd.segueData = @"Vancouver";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

