//
//  MapViewController.m
//  SFUPA
//
//  Created by Aman on 3/3/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//


#import "MapViewController.h"

@interface MapViewController (){
    double num[1000];
    double wayfind[1000];
    GMSMarker *marker;
    GMSCameraPosition *camera;
    CGFloat begLat;
    CGFloat begLong;
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

-(IBAction)clean:(id)sender{
    [mapView clear];
}

-(IBAction)marker:(id)sender{
    //[mapView clear];
    CGFloat latitude=0;
    CGFloat longtitude=0;
    bool exist = NO;
    //long temp;
    to=[room.text integerValue];
    
    //read file
    NSInteger index = 0;
    NSInteger count = 0;
    
    NSInteger wfIndex = 0;
    
    while(index<1000)
    {
        //[test setText:[NSString stringWithFormat:@"%f", index]];
        if (num[index] == to){
            count=index;
            //[test setText:[NSString stringWithFormat:@"%f", num[index]]];
            exist=YES;
        }
        index++;
    }
    while(wfIndex < 1000)
    {
        if (wayfind[wfIndex] == to){
            break;
        }
        wfIndex = wfIndex + 3;
    }
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
    //long temp;
    from=[sroom.text integerValue];
    
    //read file
    NSInteger index = 0;
    NSInteger count = 0;
    
    NSInteger wfIndex = 0;
    
    while(index<1000)
    {
        if (num[index] == from){
            count=index;
            exist=YES;
            
        }
        index++;
    }
    
    while(wfIndex <1000)
    {
        if (wayfind[wfIndex] == from){
            break;
        }
        wfIndex = wfIndex + 3;
    }
    
    if (exist == YES){
        latitude=num[count+1];
        longtitude=num[count+2];
        //    begLat = latitude;
        //   begLong = longtitude;
        //  if (to > from)
        //{
        while(readLat != endLat && readLong != endLong)
        {
            readLat = wayfind[wfIndex + 1];
            readLong = wayfind[wfIndex + 2];
            [path addCoordinate:CLLocationCoordinate2DMake(readLat, readLong)];
            wfIndex = wfIndex + 3;
        }
        // [path addCoordinate:CLLocationCoordinate2DMake(endLat, endLong)];
        // }
        
        
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
        //mapView = GMSOverlay:polyline.map;
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
    slide.center = CGPointMake(160, 90);
}

-(IBAction)upward:(id)sender{
    slide.center = CGPointMake(160, 55);
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
    NSString *contents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AQ" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    //double number[1000];
    NSInteger index = 0;
    //NSInteger count = 0;
    for (NSString *line in lines) {
        CGFloat nse = [line floatValue];
        num[index]=nse;
        index++;
        
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
