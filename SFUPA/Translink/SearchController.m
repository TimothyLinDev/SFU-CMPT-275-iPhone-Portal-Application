//
//  SearchController.m
//  Translink
//
//  Created by Mavis on 15-3-18.
//  Copyright (c) 2015年 Mavis. All rights reserved.
//

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

-(NSString*) makeRestAPICall : (NSString*) reqURLStr
{
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString: reqURLStr]];
    NSURLResponse *resp = nil;
    NSError *error = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest: Request returningResponse: &resp error: &error];
    NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
    return responseString;
}

-(IBAction)searchaction:(id)sender{
    [self search];
}

-(void)search{
    int input=[self.searchtext.text integerValue];
    NSLog(@"t:%i",input);
    if(self.segueData != nil)
    {
        input =[self.segueData integerValue];
    }
    NSLog(@"%i", input);
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
    if (input >=10000 && input <= 99999){
        NSLog(@"a1");
        self.textfield.text = @"";
        MyUrl = [NSString stringWithFormat:@"http://api.translink.ca/rttiapi/v1/stops/%i/estimates?apikey=ezVK3cAFTnCz2iCPSAVg",input];
        self.Map.hidden = YES;
        self.textfield.hidden = NO;
        self.num.text = [NSString stringWithFormat:@"Stop#: %i", input];
        resp=[self makeRestAPICall: MyUrl];
        NSString *find = @"<RouteNo>";
        Count = [resp length] - [[resp stringByReplacingOccurrencesOfString:find withString:@""] length];
        Count /= [find length];
        for(int i=1;i <= Count; i++){
            route = [resp componentsSeparatedByString:@"<RouteNo>"][i];
            NSString *busnumber = [route componentsSeparatedByString:@"</RouteNo>"][0];
            NSLog (@"%@",route);
            NSString *sfind = @"<ExpectedLeaveTime>";
            NSInteger strCount = [route length] - [[route stringByReplacingOccurrencesOfString:sfind withString:@""] length];
            strCount /= [sfind length];
            NSLog (@"%i", strCount);
            if(strCount > 0){
                firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][1];
                secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
                L1 = secondneedle;
                NSLog (@"%@",secondneedle);
            }
            else{
                L1 = @"No Bus";
            }
            if(strCount > 1){
                NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][2];
                NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
                L2 = secondneedle;
                NSLog (@"%@",secondneedle);
            }
            else{
                L2 = @"No Bus";
            }
            
            if(strCount > 2){
                NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][3];
                NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
                L3 = secondneedle;
                NSLog (@"%@",secondneedle);
            }
            else{
                L3 = @"No Bus";
            }
            
            if(strCount > 3){
                NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][4];
                NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
                L4 = secondneedle;
                NSLog (@"%@",secondneedle);
            }
            else{
                L4 = @"No Bus";
            }
            
            if(strCount > 4){
                NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][5];
                NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
                L5 = secondneedle;
                NSLog (@"%@",secondneedle);
            }
            else{
                L5 = @"No Bus";
            }
            
            if(strCount > 5){
                NSString *firstneedle = [route componentsSeparatedByString:@"<ExpectedLeaveTime>"][6];
                NSString *secondneedle = [firstneedle componentsSeparatedByString:@"</ExpectedLeaveTime>"][0];
                L6 = secondneedle;
                NSLog (@"%@",secondneedle);
            }
            else{
                L6 = @"No Bus";
            }
            self.textfield.text = [NSString stringWithFormat: @"%@\n%@\n%@\t\t\t%@\t\t\t%@\n%@\t\t\t%@\t\t\t%@",self.textfield.text,busnumber,L1,L2,L3,L4,L5,L6];
        }
    }
    else if (input>0 && input<=999){
        [self.Map clear];
        MyUrl = [NSString stringWithFormat:@"http://api.translink.ca/rttiapi/v1/buses?apikey=ezVK3cAFTnCz2iCPSAVg&routeNo=%i",input];
        resp=[self makeRestAPICall: MyUrl];
        //NSLog(@"%@",resp);
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
            NSLog(@"%f, %f",latitude, longtitude);
            NSString *tempDest = [resp componentsSeparatedByString:@"<Destination>"][i];
            NSString *Dest = [tempDest componentsSeparatedByString:@"</Destination>"][0];
            CLLocationCoordinate2D positon = CLLocationCoordinate2DMake(latitude, longtitude);
            marker = [GMSMarker markerWithPosition:positon];
            marker.title = Dest;
            marker.map =self.Map;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.segueData = self.textfield.text;
//    self.segueData = nil;
//    NSLog(@"segue: %@", self.segueData);
    self.searchtext.text = self.segueData;
    self.segueData = nil;
    [self search];
//    NSLog(@"test: %@",self.searchtext.text);
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
