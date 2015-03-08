//
//  WebViewScreen.m
//  SFUPA
//
//  Created by Aman on 3/7/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//


#import "WebViewScreen.h"

@interface WebViewScreen ()

@end

@implementation WebViewScreen

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!self.segueData)
    {
        return;
    }

    NSURL *URL;
    if ([self.segueData isEqualToString:@"Canvas"])
    {
        URL = [NSURL URLWithString:@"https://canvas.sfu.ca/"];
    }
    else if ([self.segueData isEqualToString:@"CourSys"])
    {
        URL = [NSURL URLWithString:@"https://courses.cs.sfu.ca/"];
    }
    else if([self.segueData isEqualToString:@"Connect"])
    {
        URL = [NSURL URLWithString:@"https://connect.sfu.ca/"];
    }
    else if([self.segueData isEqualToString:@"goSFU"])
    {
        URL = [NSURL URLWithString:@"https://go.sfu.ca/"];
    }
    else if([self.segueData isEqualToString:@"Symplicity"])
    {
        URL = [NSURL URLWithString:@"https://sfu-csm.symplicity.com/sso/students"];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [_webView loadRequest:request];
    self.lblNavBar.text = self.segueData;

    self.segueData = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

