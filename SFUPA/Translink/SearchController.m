//
//  SearchController.m
//  Translink
//
//  Created by Mavis on 15-3-18.
//  Copyright (c) 2015年 Mavis. All rights reserved.
//
//  Known Bugs:
//
//
//  Contributors: Mavis
//
// Assignment 3:
// Edited by: | What was done?
// Mavis | Created
// Mavis | Implementing maps
// Mavis | Get API responses
// Mavis | Linking to storyboard

#import "SearchController.h"

@interface SearchController (){
    GMSCameraPosition *camera;
    GMSMarker *marker;
}

@property (strong, nonatomic) IBOutlet GMSMapView *Map;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UITextView *textfield;
@property (weak, nonatomic) IBOutlet UITextField *searchtext;
@end

@implementation SearchController

//send API request and record API responses
-(NSString*) makeRestAPICall : (NSString*) reqURLStr
{
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString: reqURLStr]];
    NSURLResponse *resp = nil;
    NSError *error = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest: Request returningResponse: &resp error: &error];
    NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"%@", responseString);
    return responseString;
}

-(IBAction)searchaction:(id)sender{
    [self search];
}

//search the buses position or stop schedule
-(void)search{
    //reads the insert
    int input=[self.searchtext.text integerValue];
    if(self.segueData != nil)
    {
        input =[self.segueData integerValue];
    }
    
    //initialize the variable
    NSString *MyUrl;
    NSString *resp;
    NSString *route;
    NSString *firstneedle;
    NSString *secondneedle;
    NSInteger Count;
    NSString *L1;
    NSString *L2;
    NSString *L3;
    NSString *L4;
    NSString *L5;
    NSString *L6;
    
    // if user tries to figure out the schedule for the stop
    if (input >=10000 && input <= 99999){
        
        //refresh the text field
        self.textfield.text = @"";
        
        //ask for the API response
        MyUrl = [NSString stringWithFormat:@"http://api.translink.ca/rttiapi/v1/stops/%i/estimates?apikey=ezVK3cAFTnCz2iCPSAVg",input];
        
        //get rid of the map view
        self.Map.hidden = YES;
        self.textfield.hidden = NO;
        self.num.text = [NSString stringWithFormat:@"Stop#: %i", input];
        
        //initialize the variable
        NSString* busnumber;
        resp=[self makeRestAPICall: MyUrl];
        
        //if it is an invaild stop number
        if ([resp containsString:@"</Message></Error>"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Such Stop"
                                                            message:@"Please try again"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        //format the schedule user interface
        //use the same method as get145schedule
        else{
            NSString *find = @"<RouteNo>";
            Count = [resp length] - [[resp stringByReplacingOccurrencesOfString:find withString:@""] length];
            Count /= [find length];
            for(int i=1;i <= Count; i++){
                route = [resp componentsSeparatedByString:@"<RouteNo>"][i];
                busnumber = [route componentsSeparatedByString:@"</RouteNo>"][0];
                NSString *sfind = @"<ExpectedLeaveTime>";
                NSInteger strCount = [route length] - [[route stringByReplacingOccurrencesOfString:sfind withString:@""] length];
                strCount /= [sfind length];
                
                if(strCount > 0){
                    firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][1];
                    secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
                    secondneedle = [secondneedle substringToIndex:6];
                    L1 = secondneedle;
                }
                else{
                    L1 = @"No Bus  ";
                }
                
                if(strCount > 1){
                    NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][2];
                    NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
                    secondneedle = [secondneedle substringToIndex:6];
                    L2 = secondneedle;
                }
                else{
                    L2 = @"No Bus  ";
                }
                
                if(strCount > 2){
                    NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][3];
                NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
                secondneedle = [secondneedle substringToIndex:6];
                L3 = secondneedle;
                }
                else{
                    L3 = @"No Bus  ";
                }
            
                if(strCount > 3){
                    NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][4];
                    NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
                    secondneedle = [secondneedle substringToIndex:6];
                    L4 = secondneedle;
                }
                else{
                    L4 = @"No Bus  ";
                }
            
                if(strCount > 4){
                    NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][5];
                    NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
                    secondneedle = [secondneedle substringToIndex:6];
                    L5 = secondneedle;
                }
                else{
                    L5 = @"No Bus  ";
                }
            
                if(strCount > 5){
                    NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][6];
                    NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
                    secondneedle = [secondneedle substringToIndex:6];
                    L6 = secondneedle;
                }
                else{
                    L6 = @"No Bus  ";
                }
            }
            self.textfield.text = [NSString stringWithFormat: @"%@\n%@\n%@\t\t%@\t\t%@\n%@\t\t%@\t\t%@",self.textfield.text,busnumber,L1,L2,L3,L4,L5,L6];
        }
    }
    // if user tries to figure out the bus position
    else if (input>0 && input<=999){
        //refresh the map view
        [self.Map clear];
        
        //get API response
        MyUrl = [NSString stringWithFormat:@"http://api.translink.ca/rttiapi/v1/buses?apikey=ezVK3cAFTnCz2iCPSAVg&routeNo=%i",input];
        resp=[self makeRestAPICall: MyUrl];
        
        //if it is an invaild stop number
        if ([resp containsString:@"</Message></Error>"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Such Bus"
                                                            message:@"Please try again"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        //get the latitude and longtitude of buses
        else{
            self.textfield.hidden = YES;
            self.Map.hidden = NO;
            self.num.text = [NSString stringWithFormat:@"Bus#: %i", input];
            NSString *find = @"<Latitude>";
            Count = [resp length] - [[resp stringByReplacingOccurrencesOfString:find withString:@""] length];
            Count /= [find length];
            for(int i=1; i <= Count; i++){
                NSString *templatitude = [resp componentsSeparatedByString:@"<Latitude>"][i];
                NSString *la = [templatitude componentsSeparatedByString:@"</Latitude>"][0];
                CGFloat latitude = [la floatValue];
                NSString *templongtitude = [resp componentsSeparatedByString:@"<Longitude>"][i];
                NSString *lon = [templongtitude componentsSeparatedByString:@"</Longitude>"][0];
                CGFloat longtitude = [lon floatValue];
                NSString *tempDest = [resp componentsSeparatedByString:@"<Destination>"][i];
                NSString *Dest = [tempDest componentsSeparatedByString:@"</Destination>"][0];
            
                //make the marker on each postion
                CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(latitude, longtitude);
                marker = [GMSMarker markerWithPosition:positon];
                marker.title = Dest;
                marker.map =self.Map;
            }
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Such Bus or Stop"
                                                        message:@"Please try again"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchtext.placeholder = @"Bus#/Stop#";

    //get the segue data
    self.searchtext.text = self.segueData;
    self.segueData = nil;
    [self search];

    //set map and camera position
    camera = [GMSCameraPosition cameraWithLatitude:49.220610
                                         longitude:-123.015910
                                              zoom:10];
    [self.Map animateToCameraPosition:camera];
    self.searchtext.placeholder = @"stop#";
    //Controls whether the My Location dot and accuracy circle is enabled.
    self.Map.myLocationEnabled = YES;
    //Controls the type of map tiles that should be displayed.
    self.Map.mapType = kGMSTypeNormal;
    //Shows the compass button on the map
    self.Map.settings.compassButton = YES;
    //Shows the my location button on the map
    self.Map.settings.myLocationButton = YES;
    //Sets the view controller to be the GMSMapView delegate
    self.Map.delegate = self;
    //- See more at: http://vikrambahl.com/google-maps-ios-xcode-storyboards/#sthash.MqjFWhRs.dpuf
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
