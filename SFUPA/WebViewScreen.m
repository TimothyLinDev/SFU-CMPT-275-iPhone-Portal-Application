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
            NSURL *URL = [NSURL URLWithString:@"https://cas.sfu.ca/cas/login?service=https%3A%2F%2Fcanvas.sfu.ca%2Flogin%2Fcas"];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            [_webView loadRequest:request];
            
        }
        else if([self.segueData isEqualToString:@"Coursys"])
        {
            NSURL *URL = [NSURL URLWithString:@"https://courses.cs.sfu.ca/"];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            [_webView loadRequest:request];
        }
        else if([self.segueData isEqualToString:@"Connect"])
        {
            NSURL *URL = [NSURL URLWithString:@"https://cas.sfu.ca/cas/login?app=SFU+Connect&allow=sfu,zimbra&service=https%3A%2F%2Fconnect.sfu.ca%2Fzimbra%2Fpublic%2Fpreauth.jsp"];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            [_webView loadRequest:request];
        }
        else if([self.segueData isEqualToString:@"goSFU"])
        {
            NSURL *URL = [NSURL URLWithString:@"https://go.sfu.ca/psp/paprd/EMPLOYEE/EMPL/h/?tab=PAPP_GUEST"];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            [_webView loadRequest:request];
        }
        else if([self.segueData isEqualToString:@"Simplicity"])
        {
            NSURL *URL = [NSURL URLWithString:@"https://cas.sfu.ca/cas/login?service=http%3A%2F%2Fsfu-csm.symplicity.com%2Fsso%2Fstudents%2Flogin&PHPSESSID=c5bcc201d19543f7d737776fd5b13251"];
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            [_webView loadRequest:request];
        }
        self.segueData = nil;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

