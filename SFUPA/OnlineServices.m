//
//  OnlineServices.m
//  SFUPA
//  Team 07
//  Created by Aman on 3/7/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Amandeep Saini
//
//  Assignment 3:
//  Edited by: | What was done?
//  Amandeep   | Created and assign and send value
//  Amandeep   | Linking to storyboard
//  Amandeep   | Added Sakai

#import "OnlineServices.h"
#import "WebViewScreen.h"

@interface OnlineServices ()


@end

@implementation OnlineServices

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //Getting the value of the Segue Identifier then assigning value to segueData (Canvas) and
    //proceed to WebViewScreen
    if([segue.identifier isEqualToString:@"CanvasScreen"]){
        WebViewScreen *wvs = (WebViewScreen *)segue.destinationViewController;
        wvs.segueData = @"Canvas";
    }
    else if([segue.identifier isEqualToString:@"CoursysScreen"]) {
        WebViewScreen *controller = (WebViewScreen *)segue.destinationViewController;
        controller.segueData = @"CourSys";
    }
    else if([segue.identifier isEqualToString:@"ConnectScreen"]) {
        WebViewScreen *wvs = (WebViewScreen *)segue.destinationViewController;
        wvs.segueData = @"Connect";
    }
    else if([segue.identifier isEqualToString:@"goSFUScreen"]){
        WebViewScreen *controller = (WebViewScreen *)segue.destinationViewController;
        controller.segueData = @"goSFU";
    }
    else if([segue.identifier isEqualToString:@"SimplicityScreen"]){
        WebViewScreen *controller = (WebViewScreen *)segue.destinationViewController;
        controller.segueData = @"Symplicity";
    }
    else if([segue.identifier isEqualToString:@"SakaiScreen"]){
        WebViewScreen *controller = (WebViewScreen *)segue.destinationViewController;
        controller.segueData = @"Sakai";
    }
    
}

- (IBAction)pressedBtnCanvas:(id)sender{
}
- (IBAction)pressedBtnCourSys:(id)sender{
}
- (IBAction)pressedBtnConnect:(id)sender{
}
- (IBAction)pressedBtnGoSFU:(id)sender{
}
- (IBAction)pressedBtnSymplicity:(id)sender{
}
@end

