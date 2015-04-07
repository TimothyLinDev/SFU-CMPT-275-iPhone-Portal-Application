//
//  MapViewController.m
//  SFUPA
//  Team 07
//  Created by Mavis and Victor 3/3/15
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//  User should change floor by themselves
//  Markers only works for the 2nd floor and 3rd floor
//  Wayfinding only works if the "To" room number is bigger than "From" - FIXED
//  Wayfinding only working for most of the 2nd floor
//  Wayfinding path not appearing for the 3rd floor - FIXED
//  Wayfinding only working for half of the 3rd floor
//  Wayfinding path not working for different floors
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

// Assignment 4:
// Victor | Fixing wayfinding so that it appears for the 3rd floor
// Victor | Fixing wayfinding so that "From" room number is bigger than "To" works
// Victor | Implementing wayfinding for different floors

#import "MapViewController.h"

@interface MapViewController (){
    
    //variables declaration
    double num[2000];
    double wayfind[2000];
    NSString *building[50];
    int recordbuilding;
    GMSMarker *marker;
    GMSCameraPosition *camera;
    CGFloat endLat;
    CGFloat endLong;
    CGFloat begLat;
    CGFloat begLong;
    long to;
    long from;
    IBOutlet GMSMapView *mapView;
    __weak IBOutlet UITextField *build;
    __weak IBOutlet UITextField *sbuild;
    __weak IBOutlet UITextField *room;
    __weak IBOutlet UITextField *sroom;
}

@end

@implementation MapViewController

-(IBAction)pressedBtnClean:(id)sender{
    [mapView clear];
}

-(IBAction)pressedBtnMarker:(id)sender{
    bool exist = false;
    for (int j=0 ; j< 50 ; j++){
        if([building[j] isEqualToString:build.text] == 1){
            exist = true;
        }
    }
    if (exist == false)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No such Building"
                                                        message:@"Please Try Again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if ([build.text isEqualToString:@"AQ"])
    {
        recordbuilding = 3;
        [self AQMarker];
    }
    else
    {
        NSString *input = build.text;
        for (int j=0 ; j< 50 ; j++)
        {
            if ([building[j] isEqualToString:input] == 1){
                recordbuilding = j;
                float la = [building[j+1] floatValue];
                float lon = [building[j+2] floatValue];
                camera = [GMSCameraPosition cameraWithLatitude:la
                    longitude:lon
                    zoom:18];
                [mapView animateToCameraPosition:camera];
                    CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(la, lon);
                marker = [GMSMarker markerWithPosition:positon];
                marker.title = @"Destination";
                marker.map =mapView;
            }
        }
    }
}

-(void)AQMarker{
    CGFloat latitude=0;
    CGFloat longtitude=0;
    bool exist = NO;
    to=[room.text integerValue]; //read user input
    
    NSInteger index = 0;
    NSInteger count = 0;
    
    //NSInteger wfIndex = 0;
    
    //compare user input in "To" search bar with room location coordinates
    while(index<2000){
        if (num[index] == to){
            count=index;
            exist=YES;
        }
        index++;
    }
    
    

    
    //if room found, set a marker at room location, store coordinates as ending coordinate for wayfinding
    if (exist == YES){
        latitude=num[count+1];
        longtitude=num[count+2];
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
    NSString *input = sbuild.text;
    int recordsbuilding = 0;
    bool exist = false;
    for (int j=0 ; j< 50 ; j++){
        if([building[j] isEqualToString:input] == 1){
            exist = true;
        }
    }
    if (exist == false)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No such Building"
                                                        message:@"Please Try Again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if ([build.text isEqualToString:@"AQ"] && [sbuild.text isEqualToString:@"AQ"]){
        [self AQSelfMarker];
    }
    else if ([sbuild.text isEqualToString:@"AQ"] && [build.text isEqualToString:@"AQ"] == 0){
        GMSMutablePath *path = [GMSMutablePath path];
        for (int j=0 ; j< 50 ; j++){
            if ([building[j] isEqualToString:input] == 1){
                recordsbuilding = j;
                float la = [building[j+1] floatValue];
                float lon = [building[j+2] floatValue];
                camera = [GMSCameraPosition cameraWithLatitude:la
                                                     longitude:lon
                                                          zoom:16];
                [mapView animateToCameraPosition:camera];
                CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(la, lon);
                marker = [GMSMarker markerWithPosition:positon];
                marker.title = @"Begin";
                marker.map =mapView;
            }
        }
        if (recordsbuilding > recordbuilding)
        {
            int i=0;
            while (i<=recordsbuilding)
            {
                float lati = [building[i+1] floatValue];
                float lonti = [building[i+2] floatValue];
                [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                i=i+3;
            }
        }
        else
        {
            int i=3;
            while (i<=recordbuilding)
            {
                float lati = [building[i+1] floatValue];
                float lonti = [building[i+2] floatValue];
                [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                i=i+3;
            }
        }
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeWidth = 5;
        polyline.strokeColor = [UIColor redColor];
        polyline.map = mapView;
        [path removeAllCoordinates];
    }
    else if ([sbuild.text isEqualToString:@"AQ"] == 0 && [build.text isEqualToString:@"AQ"]){
        GMSMutablePath *path = [GMSMutablePath path];
        for (int j=0 ; j< 50 ; j++){
            if ([building[j] isEqualToString:input] == 1){
                recordsbuilding = j;
                float la = [building[j+1] floatValue];
                float lon = [building[j+2] floatValue];
                camera = [GMSCameraPosition cameraWithLatitude:la
                                                     longitude:lon
                                                          zoom:16];
                [mapView animateToCameraPosition:camera];
                CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(la, lon);
                marker = [GMSMarker markerWithPosition:positon];
                marker.title = @"Begin";
                marker.map =mapView;
            }
        }
        if (recordbuilding > recordsbuilding)
        {
            int i=0;
            while (i<=recordbuilding)
            {
                float lati = [building[i+1] floatValue];
                float lonti = [building[i+2] floatValue];
                [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                i=i+3;
            }
        }
        else
        {
            int i=3;
            while (i<=recordsbuilding)
            {
                float lati = [building[i+1] floatValue];
                float lonti = [building[i+2] floatValue];
                [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                i=i+3;
            }
        }
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeWidth = 5;
        polyline.strokeColor = [UIColor redColor];
        polyline.map = mapView;
        [path removeAllCoordinates];
    }
    
    else if (([sbuild.text isEqualToString:@"BLU"] && [build.text isEqualToString:@"SEC"]) || ([sbuild.text isEqualToString:@"SEC"] && [build.text isEqualToString:@"BLU"]))
    {
        GMSMutablePath *path = [GMSMutablePath path];
        for (int j=0 ; j< 50 ; j++){
            if ([building[j] isEqualToString:input] == 1){
                recordsbuilding = j;
                float la = [building[j+1] floatValue];
                float lon = [building[j+2] floatValue];
                camera = [GMSCameraPosition cameraWithLatitude:la
                                                     longitude:lon
                                                          zoom:16];
                [mapView animateToCameraPosition:camera];
                CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(la, lon);
                marker = [GMSMarker markerWithPosition:positon];
                marker.title = @"Begin";
                marker.map =mapView;
            }
        }
        [path addCoordinate:CLLocationCoordinate2DMake(49.279043, -122.913094)];
        [path addCoordinate:CLLocationCoordinate2DMake(49.277008, -122.912742)];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeWidth = 5;
        polyline.strokeColor = [UIColor redColor];
        polyline.map = mapView;
        [path removeAllCoordinates];
    }
    else{
        GMSMutablePath *path = [GMSMutablePath path];
        for (int j=0 ; j< 50 ; j++){
            if ([building[j] isEqualToString:input] == 1){
                recordsbuilding = j;
                float la = [building[j+1] floatValue];
                float lon = [building[j+2] floatValue];
                camera = [GMSCameraPosition cameraWithLatitude:la
                                                     longitude:lon
                                                          zoom:16];
                [mapView animateToCameraPosition:camera];
                CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(la, lon);
                marker = [GMSMarker markerWithPosition:positon];
                marker.title = @"Begin";
                marker.map =mapView;
            }
        }
        if (recordsbuilding > recordbuilding)
        {
            if((recordsbuilding < 20 && recordbuilding < 20) || (recordsbuilding >= 20 && recordbuilding >= 20))
            {
                int i = recordbuilding;
                while (i <= recordsbuilding)
                {
                    float lati = [building[i+1] floatValue];
                    float lonti = [building[i+2] floatValue];
                    [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                    i=i+3;
                }
            }
            else if (recordsbuilding >= 20 && recordbuilding < 20)
            {
                if (recordbuilding < 5)
                {
                    int i = recordbuilding;
                    while (i <= 3)
                    {
                        float lati = [building[i+1] floatValue];
                        float lonti = [building[i+2] floatValue];
                        [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                        i=i+3;
                    }
                }
                else if (recordbuilding >=5 && recordbuilding < 12)
                {
                    int i = recordbuilding;
                    while (i <= 12)
                    {
                        float lati = [building[i+1] floatValue];
                        float lonti = [building[i+2] floatValue];
                        [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                        i=i+3;
                    }
                }
                else
                {
                    int i = 18;
                    while (i >= 12)
                    {
                        float lati = [building[i+1] floatValue];
                        float lonti = [building[i+2] floatValue];
                        [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                        i=i-3;
                    }
                }
                if (recordsbuilding < 30)
                {
                    int i = 30;
                    while (i >= recordsbuilding)
                    {
                        float lati = [building[i+1] floatValue];
                        float lonti = [building[i+2] floatValue];
                        [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                        i=i-3;
                    }
                }
                else
                {
                    int i = 30;
                    while (i <=recordsbuilding)
                    {
                        float lati = [building[i+1] floatValue];
                        float lonti = [building[i+2] floatValue];
                        [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                        i=i+3;
                    }
                }
            }
        }
        else if (recordbuilding > recordsbuilding)
        {
            if((recordsbuilding < 20 && recordbuilding < 20) || (recordsbuilding >= 20 && recordbuilding >= 20))
            {
                int i = recordsbuilding;
                while (i <= recordbuilding)
                {
                    float lati = [building[i+1] floatValue];
                    float lonti = [building[i+2] floatValue];
                    [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                    i=i+3;
                }
            }
            else if (recordbuilding >= 20 && recordsbuilding < 20)
            {
                if (recordsbuilding < 5)
                {
                    int i = recordsbuilding;
                    while (i <= 3)
                    {
                        float lati = [building[i+1] floatValue];
                        float lonti = [building[i+2] floatValue];
                        [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                        i=i+3;
                    }
                }
                else if (recordsbuilding >=5 && recordsbuilding < 12)
                {
                    int i = recordsbuilding;
                    while (i <= 12)
                    {
                        float lati = [building[i+1] floatValue];
                        float lonti = [building[i+2] floatValue];
                        [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                        i=i+3;
                    }
                }
                else
                {
                    int i = 18;
                    while (i >= 12)
                    {
                        float lati = [building[i+1] floatValue];
                        float lonti = [building[i+2] floatValue];
                        [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                        i=i-3;
                    }
                }
                if (recordbuilding < 30)
                {
                    int i = 30;
                    while (i >= recordbuilding)
                    {
                        float lati = [building[i+1] floatValue];
                        float lonti = [building[i+2] floatValue];
                        [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                        i=i-3;
                    }
                }
                else
                {
                    int i = 30;
                    while (i <=recordbuilding)
                    {
                        float lati = [building[i+1] floatValue];
                        float lonti = [building[i+2] floatValue];
                        [path addCoordinate:CLLocationCoordinate2DMake(lati, lonti)];
                        i=i+3;
                    }
                }
            }
        }
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeWidth = 5;
        polyline.strokeColor = [UIColor redColor];
        polyline.map = mapView;
        [path removeAllCoordinates];
    }
}

-(void)AQSelfMarker{
    GMSMutablePath *path = [GMSMutablePath path];
    CGFloat latitude=0;
    CGFloat longtitude=0;
    CGFloat readLat=0;
    CGFloat readLong=0;
    CGFloat floorFrom=0;
    CGFloat floorTo=0;
    long tempTo=0;
   // NSString *tempFrom;
    bool exist = NO;

    from=[sroom.text integerValue];
    
 
    NSInteger index = 0;
    NSInteger count = 0;
    
    NSInteger wfIndex = 0;
   // NSInteger tempIndex;
    NSInteger begIndex1 = 0;
    NSInteger begIndex2 = 0;
    NSInteger numEle = 0;
    
    floorFrom = from/1000;
    floorTo = to/1000;
    [NSString stringWithFormat:@" %.0f", (floorFrom)];
    [NSString stringWithFormat:@" %.0f", (floorTo)];
    
    
    if (floorFrom == 2){
        NSString *wayfindFile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wayfindAQ2" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
        NSArray *wayfindLines = [wayfindFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        for (NSString *wfLines in wayfindLines){
            CGFloat nse2 = [wfLines floatValue];
            wayfind[wfIndex] = nse2;
            wfIndex++;
        }
    }
    
   else if (floorFrom == 3){
        NSString *wayfindFile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wayfindAQ3" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
        NSArray *wayfindLines = [wayfindFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        for (NSString *wfLines in wayfindLines){
            CGFloat nse2 = [wfLines floatValue];
            wayfind[wfIndex] = nse2;
            wfIndex++;
        }
    }
    
   else if (floorFrom == 4){
        NSString *wayfindFile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wayfindAQ4" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
        NSArray *wayfindLines = [wayfindFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        for (NSString *wfLines in wayfindLines){
            CGFloat nse2 = [wfLines floatValue];
            wayfind[wfIndex] = nse2;
            wfIndex++;
        }
    }
    
   else if (floorFrom == 5){
       NSString *wayfindFile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wayfindAQ5" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
       NSArray *wayfindLines = [wayfindFile componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
       for (NSString *wfLines in wayfindLines){
           CGFloat nse2 = [wfLines floatValue];
           wayfind[wfIndex] = nse2;
           wfIndex++;
       }
   }
    
   // CGFloat z;
   // z = wayfind[195];
    numEle = wfIndex;
    wfIndex = 0;
    
    //compare user input in "From" search bar with room location coordinates
    while(index<2000){
        if (num[index] == from){
            count=index;
            exist=YES;
        }
        index++;
    }
    
    //compare user input in "To" search bar with wayfinding path coordinates
    if(floorFrom == floorTo){
        while(wfIndex < 2000){
            if (wayfind[wfIndex] == to){
                endLat = wayfind[wfIndex+1];
                endLong = wayfind[wfIndex+2];
                break;
            }
            wfIndex = wfIndex + 3;
        }
    }
    
    else if(floorFrom != floorTo){
        tempTo = to;
        to = 99999;
        while(wfIndex < 2000){
            if (wayfind[wfIndex] == to){
                endLat = wayfind[wfIndex+1];
                endLong = wayfind[wfIndex+2];
                break;
            }
            wfIndex = wfIndex + 3;
        }    }
    
    if((floorFrom == 2) || (floorFrom == 4)){
        wfIndex = 0;
    }
    
   else if((floorFrom == 3) || (floorFrom == 5)){
       wfIndex = numEle/3 - 1;
    }
    
    
    //compare user input in "From" search bar with wayfinding path coordinates
    while(wfIndex <2000){
        if (wayfind[wfIndex] == from){
            begLat = wayfind[wfIndex+1];
            begLong = wayfind[wfIndex+2];
            //tempIndex = wfIndex;
            begIndex1 = wfIndex;
            begIndex2 = wfIndex;
            break;
        }
        wfIndex = wfIndex + 3;
    }
    
    
    //if room found, set a marker at room location and draw path from "From" to "To" coordinates
    if (exist == YES){
        latitude=num[count+1];
        longtitude=num[count+2];

       /* if ((floorFrom == floorTo) && (floorFrom == 2 || floorFrom == 4)){
            //condition for when room number to > from and rooms are on the same floor
           /* if (to > from){
                while(readLat != endLat && readLong != endLong){
                    readLat = wayfind[wfIndex + 1];
                    readLong = wayfind[wfIndex + 2];
                    [path addCoordinate:CLLocationCoordinate2DMake(readLat, readLong)];
                    wfIndex = wfIndex + 3;
                }
            }
            
            //Condition for when room number From > to and rooms are on the same floor
            else if (from > to){
                while(readLat != endLat && readLong != endLong){
                    readLat = wayfind[wfIndex +1];
                    readLong = wayfind[wfIndex +2];
                    [path addCoordinate:CLLocationCoordinate2DMake(readLat, readLong)];
                    wfIndex = wfIndex - 3;
                }
            }*/
            /*for(int i = 0; i<numEle; i++){
                if (wayfind[begIndex1] == to){
                    while(readLat != endLat && readLong != endLong){
                        readLat = wayfind[wfIndex + 1];
                        readLong = wayfind[wfIndex + 2];
                        [path addCoordinate:CLLocationCoordinate2DMake(readLat, readLong)];
                        wfIndex = wfIndex + 3;
                    }
                    break;
                }
                if(wayfind[begIndex2] == to){
                    while(readLat != endLat && readLong != endLong){
                        readLat = wayfind[wfIndex +1];
                        readLong = wayfind[wfIndex +2];
                        [path addCoordinate:CLLocationCoordinate2DMake(readLat, readLong)];
                        wfIndex = wfIndex - 3;
                    }
                    break;
                }
                begIndex1 = begIndex1 + 3;
                begIndex2 = begIndex2 - 3;
            }
        }*/
        
        if(floorFrom == 2 || floorFrom == 3 || floorFrom == 4){
            if(floorFrom != floorTo){
                for(int i = 0; i<numEle; i++){
                    if (wayfind[begIndex1] == to){
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
                        CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(readLat, readLong);
                        marker = [GMSMarker markerWithPosition:positon];
                        marker.title = @"Please go to floor";
                        marker.icon = [UIImage imageNamed:@"stairs"];
                        marker.map =mapView;
                        polyline.strokeWidth = 5;
                        polyline.strokeColor = [UIColor blueColor];
                        polyline.map = mapView;                         break;
                    }
                    if(wayfind[begIndex2] == to){
                        while(readLat != endLat && readLong != endLong){
                            readLat = wayfind[wfIndex +1];
                            readLong = wayfind[wfIndex +2];
                            [path addCoordinate:CLLocationCoordinate2DMake(readLat, readLong)];
                            wfIndex = wfIndex - 3;
                        }
                        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
                        camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                             longitude:longtitude
                                                                  zoom:20];
                        [mapView animateToCameraPosition:camera];
                        CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(readLat, readLong);
                        marker = [GMSMarker markerWithPosition:positon];
                        marker.title = @"Please change floors";
                        marker.icon = [UIImage imageNamed:@"stairs"];
                        marker.map =mapView;
                        polyline.strokeWidth = 5;
                        polyline.strokeColor = [UIColor blueColor];
                        polyline.map = mapView;                        break;
                    }
                    begIndex1 = begIndex1 + 3;
                    begIndex2 = begIndex2 - 3;
                }
            }
            else{
            for(int i = 0; i<numEle; i++){
                if (wayfind[begIndex1] == to){
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
                    polyline.strokeWidth = 5;
                    polyline.strokeColor = [UIColor greenColor];
                    polyline.map = mapView;
                    break;
                }
                if(wayfind[begIndex2] == to){
                    while(readLat != endLat && readLong != endLong){
                        readLat = wayfind[wfIndex +1];
                        readLong = wayfind[wfIndex +2];
                        [path addCoordinate:CLLocationCoordinate2DMake(readLat, readLong)];
                        wfIndex = wfIndex - 3;
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
                    polyline.strokeWidth = 5;
                    polyline.strokeColor = [UIColor greenColor];
                    polyline.map = mapView;                    break;
                }
                begIndex1 = begIndex1 + 3;
                begIndex2 = begIndex2 - 3;
            }
            }
        }
        
        else if(floorFrom == 5 || floorFrom == 6){
            for(int i = 0; i<numEle; i++){
                if (wayfind[begIndex1] == to){
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
                    polyline.strokeWidth = 5;
                    polyline.strokeColor = [UIColor greenColor];
                    polyline.map = mapView;
                    break;
                }
                if(wayfind[begIndex2] == to){
                    while(readLat != endLat && readLong != endLong){
                        readLat = wayfind[wfIndex +1];
                        readLong = wayfind[wfIndex +2];
                        [path addCoordinate:CLLocationCoordinate2DMake(readLat, readLong)];
                        wfIndex = wfIndex - 3;
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
                    polyline.strokeWidth = 5;
                    polyline.strokeColor = [UIColor greenColor];
                    polyline.map = mapView;                    break;
                }
                begIndex1 = begIndex1 + 3;
                begIndex2 = begIndex2 - 3;
            }
        
        }


    /*    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        camera = [GMSCameraPosition cameraWithLatitude:latitude
                                             longitude:longtitude
                                                  zoom:20];
        [mapView animateToCameraPosition:camera];
        CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(latitude, longtitude);
        marker = [GMSMarker markerWithPosition:positon];
        marker.title = @"Begin";
        marker.map =mapView;
        polyline.strokeWidth = 5;
        polyline.strokeColor = [UIColor greenColor];
        polyline.map = mapView;*/
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

-(IBAction)pressedBtnDownward:(id)sender{
    viewSlide.center = CGPointMake(160, 100);
}

-(IBAction)pressedBtnUpward:(id)sender{
    viewSlide.center = CGPointMake(160, 67);
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
    
    //UiTextField
    room.placeholder=@"Room#:";
    sroom.placeholder=@"Room#:";

    
    //read file for room location coordinates
    NSString *contents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AQ" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
    NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSInteger index = 0;
    for (NSString *line in lines) {
        CGFloat nse = [line floatValue];
        num[index]=nse;
        index++;
        
    NSString *content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"building" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
    NSArray *l = [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSInteger i = 0;
    for (NSString *ls in l) {
        NSString *nse = ls;
        building[i]=nse;
        i++;
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
