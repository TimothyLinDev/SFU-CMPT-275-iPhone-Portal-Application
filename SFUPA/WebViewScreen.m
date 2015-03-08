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
    // Do any additional setup after loading the view, typically from a nib.
    NSString *value;
    value = [NSString stringWithFormat:@"Your data: %@", _segueData];
    NSLog(@"Value of Data: %@", _segueData);
    
    if(self.segueData)
    {
        if ([self.segueData isEqualToString:@"Canvas"])
        {
            NSURL *URL = [NSURL URLWithString:@"https://canvas.sfu.ca/"];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            [_webView loadRequest:request];
            self.lblNavBar.text = @"Canvas";
            
        }
        else if([self.segueData isEqualToString:@"Coursys"])
        {
            NSURL *URL = [NSURL URLWithString:@"https://courses.cs.sfu.ca/"];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            [_webView loadRequest:request];
            self.lblNavBar.text = @"CourSys";
        }
        else if([self.segueData isEqualToString:@"Connect"])
        {
            NSURL *URL = [NSURL URLWithString:@"https://connect.sfu.ca/"];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            [_webView loadRequest:request];
            self.lblNavBar.text = @"Connect";
        }
        else if([self.segueData isEqualToString:@"goSFU"])
        {
            NSURL *URL = [NSURL URLWithString:@"https://go.sfu.ca/"];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            [_webView loadRequest:request];
            self.lblNavBar.text = @"goSFU";
        }
        else if([self.segueData isEqualToString:@"Simplicity"])
        {
            NSURL *URL = [NSURL URLWithString:@"https://sfu-csm.symplicity.com/sso/students"];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            [_webView loadRequest:request];
            self.lblNavBar.text = @"Symplicity";
        }
        self.segueData = nil;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

