//
//  MapViewController.m
//  SFUPA
//  Team 07
//  Created by Mavis and Victor 3/3/15
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//  Wayfinding only works if the "To" room number is bigger than "From"
//  Wayfinding only working for most of 2nd floor
//  Wayfinding path not appearing for 3rd floor
//
//  Contributors: Mavis and Victor
//
// Assignment 3:
// Edited by: | What was done?
// Mavis and Victor | Created
// Mavis and Victor | Implementing maps
// Mavis | Linking to storyboard
// Mavis | Reading file with coordinates
// Victor | Implementing wayfinding
// test

#import "MapViewController.h"

@interface MapViewController (){
    
    //variables declaration
    double num[1000];
    double wayfind[1000];
    GMSMarker *marker;
    GMSCameraPosition *camera;
    CGFloat endLat;
    CGFloat endLong;
    long to;
    long from;
    IBOutlet GMSMapView *mapView;
    __weak IBOutlet UITextField *room;
    __weak IBOutlet UITextField *sroom;
}

@end

@implementation MapViewController

-(IBAction)pressedBtnClean:(id)sender{
    [mapView clear];
}

-(IBAction)pressedBtnMarker:(id)sender{
    CGFloat latitude=0;
    CGFloat longtitude=0;
    bool exist = NO;
    to=[room.text integerValue]; //read user input
    
    NSInteger index = 0;
    NSInteger count = 0;
    
    NSInteger wfIndex = 0;
    
    //compare user input in "To" search bar with room location coordinates
    while(index<1000){
        if (num[index] == to){
            count=index;
            exist=YES;
        }
        index++;
    }
    
    //compare user input in "To" search bar with wayfinding path coordinates
    while(wfIndex < 1000){
        if (wayfind[wfIndex] == to){
            break;
        }
        wfIndex = wfIndex + 3;
    }
    
    //if room found, set a marker at room location, store coordinates as ending coordinate for wayfinding
    if (exist == YES){
        latitude=num[count+1];
        longtitude=num[count+2];
        endLat = wayfind[wfIndex+1];
        endLong = wayfind[wfIndex+2];
        camera = [GMSCameraPosition cameraWithLatitude:latitude
                                             longitude:longtitude
                                                  zoom:20];
        [mapView animateToCameraPosition:camera];
        //marker
        CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(latitude, longtitude);
        marker = [GMSMarker markerWithPosition:positon];
        marker.title = @"Destination";
        marker.map =mapView;
    }
    
    //if room not found, ask user try again
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No such Room"
                                                        message:@"Please Try Again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(IBAction)pressedBtnSelfMarker:(id)sender{
  
    GMSMutablePath *path = [GMSMutablePath path];
    CGFloat latitude=0;
    CGFloat longtitude=0;
    CGFloat readLat=0;
    CGFloat readLong=0;
    bool exist = NO;

    from=[sroom.text integerValue];
    
 
    NSInteger index = 0;
    NSInteger count = 0;
    
    NSInteger wfIndex = 0;
    
    //compare user input in "From" search bar with room location coordinates
    while(index<1000){
        if (num[index] == from){
            count=index;
            exist=YES;
        }
        index++;
    }
    
    //compare user input in "From" search bar with wayfinding path coordinates
    while(wfIndex <1000){
        if (wayfind[wfIndex] == from){
            break;
        }
        wfIndex = wfIndex + 3;
    }
    
    //if room found, set a marker at room location and draw path from "From" to "To" coordinates
    if (exist == YES){
        latitude=num[count+1];
        longtitude=num[count+2];
        while(readLat != endLat && readLong != endLong){
            readLat = wayfind[wfIndex + 1];
            readLong = wayfind[wfIndex + 2];
            [path addCoordinate:CLLocationCoordinate2DMake(readLat, readLong)];
            wfIndex = wfIndex + 3;
        }
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        camera = [GMSCameraPosition cameraWithLatitude:latitude
                                             longitude:longtitude
                                                  zoom:20];
        [mapView animateToCameraPosition:camera];
        CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(latitude, longtitude);
        marker = [GMSMarker markerWithPosition:positon];
        marker.title = @"Begin";
        marker.map =mapView;
        polyline.map = mapView;
    }
    
    //if room not found, ask user try again
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No such Room"
                                                        message:@"Please Try Again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


-(IBAction)pressedBtnRemove:(id)sender{
    [mapView clear];
}

-(IBAction)pressedBtnDownward:(id)sender{
    viewSlide.center = CGPointMake(160, 90);
}

-(IBAction)pressedBtnUpward:(id)sender{
    viewSlide.center = CGPointMake(160, 55);
}

- (void)viewDidLoad {
    
    //load Map to SFU Burnaby Campus location
    camera = [GMSCameraPosition cameraWithLatitude:49.279937
                                         longitude:-122.919956
                                              zoom:15];
    [mapView animateToCameraPosition:camera];
   
    //enable location
    //display location button, compass button, and normal map
    mapView.myLocationEnabled = YES;
    mapView.mapType = kGMSTypeNormal;
    mapView.settings.compassButton = YES;
    mapView.settings.myLocationButton = YES;
    mapView.delegate = self;

    
    //read file for room location coordinates
    NSString *contents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AQ" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSInteger index = 0;
    for (NSString *line in lines) {
        CGFloat nse = [line floatValue];
        num[index]=nse;
        index++;
        
    //read file of coordinates for creating wayfinding paths
    NSString *wayfindFile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wayfind" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
    NSArray *wayfindLines = [wayfindFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSInteger wfIndex = 0;
    for (NSString *wfLines in wayfindLines){
        CGFloat nse2 = [wfLines floatValue];
        wayfind[wfIndex] = nse2;
        wfIndex++;
    }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
