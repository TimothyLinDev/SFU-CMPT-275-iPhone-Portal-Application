//
//  LibraryWebsite.m
//  SFUPA
//
//  Created by Aman on 3/19/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Amandeep Saini
//
//  Assignment 3:
//  Edited by: | What was done?
//  Amandeep   | Created

#import <Foundation/Foundation.h>
#import "LibraryWebsite.h"

@interface LibraryWebsite ()


@end

@implementation LibraryWebsite

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *URL = [NSURL URLWithString:@"http://www.lib.sfu.ca/"];
    _webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end