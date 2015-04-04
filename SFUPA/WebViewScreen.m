//
//  WebViewScreen.m
//  SFUPA
//  Team 07
//  Created by Aman on 3/7/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Amandeep Saini, Rylan Lim
//
//  Assignment 3:
//  Edited by: | What was done?
//  Amandeep   | Created and redirect to URL
//  Amandeep   | Linking to storyboard
//  Rylan      | Refactored Academic Services code
//  Rylan      | Accessing an academic service without Internet makes an error message appear
//  Amandeep   | Added Sakai
//
//  Assignment 4:
//  Rylan      | Added functionality for Course Viewer
//  Rylan      | Fixed a bug that causes the "No Internet" message to appear at the wrong times

#import "WebViewScreen.h"

@interface WebViewScreen ()

@end

@implementation WebViewScreen

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.segueData){
        return;
    }

    //After getting the value of segueData, each value has it corresponding website
    //For example, if the segueData = @"Canvas" then it will open a WebView and redirect it to Canvas Page
    
    NSURL *URL;
    if ([self.segueData isEqualToString:@"Canvas"]){
        URL = [NSURL URLWithString:@"https://canvas.sfu.ca/"];
    }
    else if ([self.segueData isEqualToString:@"CourSys"]){
        URL = [NSURL URLWithString:@"https://courses.cs.sfu.ca/"];
    }
    else if([self.segueData isEqualToString:@"Connect"]){
        URL = [NSURL URLWithString:@"https://connect.sfu.ca/"];
    }
    else if([self.segueData isEqualToString:@"goSFU"]){
        URL = [NSURL URLWithString:@"https://go.sfu.ca/psp/paprd/EMPLOYEE/EMPL/h/?tab=SFU_STUDENT_CENTER"];
    }
    else if([self.segueData isEqualToString:@"Symplicity"]){
        URL = [NSURL URLWithString:@"https://sfu-csm.symplicity.com/sso/students"];
    }
    else if([self.segueData isEqualToString:@"Sakai"]){
        URL = [NSURL URLWithString:@"http://sakai.sfu.ca/portal"];
    }
    else if([self.segueData rangeOfString:@"https://www.sfu.ca/outlines.html?"].location != NSNotFound){
        URL = [NSURL URLWithString:self.segueData];
        self.segueData = @"Course Viewer";
    }
    _webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [_webView loadRequest:request];
    self.lblNavBar.text = self.segueData;

    self.segueData = nil;
}

- (void)webView:webView
didFailLoadWithError:error {
    if ([error code] != -1009) {
        return;
    }
    //Notifying the user that there is no Internet Connection
    [[[UIAlertView alloc] initWithTitle:@"No Internet Connection"
                                message:@"⚠"
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self performSegueWithIdentifier:@"webViewToAcademic" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

