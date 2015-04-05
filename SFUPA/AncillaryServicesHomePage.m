//
//  AncillaryServicesHomePage.m
//  SFUPA
//
//  Created by Aman on 3/19/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//
//  Known Bugs:
//
//  Contributors: Amandeep Saini
//
//  Assignment 3:
//  Edited by: | What was done?
//  Amandeep   | Created

#import <Foundation/Foundation.h>
#import "AncillaryServicesHomePage.h"
#import "WebViewScreen.h"

@interface AncillaryServicesHomePage ()

@end

@implementation AncillaryServicesHomePage

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LibraryButton:(id)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ancillaryBookstoreToWeb"]) {
        [segue.destinationViewController setSegueData:@"http://sfu.collegestoreonline.com/"];
    }
}
@end