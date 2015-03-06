//
//  ViewController.m
//  SFUPA
//
//  Created by Aman on 3/3/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//


#import "ViewController.h"

@interface ViewController (){
    double num[1000];
    GMSMarker *marker;
    GMSCameraPosition *camera;
    CGFloat begLat;
    CGFloat begLong;
    CGFloat endLat;
    CGFloat endLong;
    IBOutlet GMSMapView *mapView;
    __weak IBOutlet UITextField *room;
    __weak IBOutlet UITextField *sroom;
}

@end

@implementation ViewController

-(IBAction)clean:(id)sender{
    [mapView clear];
}

-(IBAction)marker:(id)sender{
    //[mapView clear];
    CGFloat latitude=0;
    CGFloat longtitude=0;
    bool exist = NO;
    long temp;
    temp=[room.text integerValue];
    
    //read file
    NSInteger index = 0;
    NSInteger count = 0;
    while(index<1000)
    {
        //[test setText:[NSString stringWithFormat:@"%f", num[index]]];
        if (num[index] == temp){
            count=index;
            //[test setText:[NSString stringWithFormat:@"%f", num[index]]];
            exist=YES;
        }
        index++;
    }
    if (exist == YES){
        latitude=num[count+1];
        longtitude=num[count+2];
        endLat = latitude;
        endLong = longtitude;
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
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No such Room"
                                                        message:@"Please Try Again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        //[alert release];
    }
}

-(IBAction)selfmarker:(id)sender{
    //[mapView clear];
    GMSMutablePath *path = [GMSMutablePath path];
    CGFloat latitude=0;
    CGFloat longtitude=0;
    CGFloat readLat=0;
    CGFloat readLong=0;
    bool exist = NO;
    long temp;
    temp=[sroom.text integerValue];
    
    //read file
    NSInteger index = 0;
    NSInteger count = 0;
    while(index<1000)
    {
        if (num[index] == temp){
            count=index;
            exist=YES;
        
        }
        index++;
    }
    
    if (exist == YES){
        latitude=num[count+1];
        longtitude=num[count+2];
        begLat = latitude;
        begLong = longtitude;
        while(readLat != endLat && readLong != endLong)
        {
            readLat = num[count + 1];
            readLong = num[count + 2];
            [path addCoordinate:CLLocationCoordinate2DMake(readLat, readLong)];
            count = count + 3;
        }
        [path addCoordinate:CLLocationCoordinate2DMake(endLat, endLong)];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        camera = [GMSCameraPosition cameraWithLatitude:latitude
                                             longitude:longtitude
                                                  zoom:20];
        [mapView animateToCameraPosition:camera];
        //marker
        CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(latitude, longtitude);
        marker = [GMSMarker markerWithPosition:positon];
        marker.title = @"Begin";
        marker.map =mapView;
        polyline.map = mapView;
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No such Room"
                                                        message:@"Please Try Again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        //[alert release];
    }
}


-(IBAction)remove:(id)sender{
    [mapView clear];
}

-(IBAction)downward:(id)sender{
    slide.center = CGPointMake(159, 90);
}

-(IBAction)upward:(id)sender{
    slide.center = CGPointMake(159, 55);
}

- (void)viewDidLoad {
    camera = [GMSCameraPosition cameraWithLatitude:49.279937
                                         longitude:-122.919956
                                              zoom:15];
    [mapView animateToCameraPosition:camera];
    //mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    //Controls whether the My Location dot and accuracy circle is enabled.
    mapView.myLocationEnabled = YES;
    //Controls the type of map tiles that should be displayed.
    mapView.mapType = kGMSTypeNormal;
    //Shows the compass button on the map
    mapView.settings.compassButton = YES;
    //Shows the my location button on the map
    mapView.settings.myLocationButton = YES;
    //Sets the view controller to be the GMSMapView delegate
    mapView.delegate = self; //- See more at: http://vikrambahl.com/google-maps-ios-xcode-storyboards/#sthash.i08dW8lG.dpuf
    //self.view = mapView;
    //GMSMarker *marker = [[GMSMarker alloc] init];
    //marker.position = CLLocationCoordinate2DMake(49.279937, -122.919956);
    
    //read file
    NSString *contents = [NSString stringWithContentsOfFile:@"/Users/Aman/Desktop/SFUPA/SFUPA/AQ.txt" encoding:NSUTF8StringEncoding error:NULL];
    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    //double number[1000];
    NSInteger index = 0;
    //NSInteger count = 0;
    for (NSString *line in lines) {
        CGFloat nse = [line floatValue];
        num[index]=nse;
        index++;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

