//
//  SFUNewsDetailView.m
//  SFUPA
//
//  Created by Timothy Lin on 2015-03-22.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Timothy Lin
//
//  Assignment 4:
//  Edited by: | What was done?
//  Timothy    | Created

#import "SFUNewsDetailView.h"

@implementation SFUNewsDetailView

@synthesize url;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //Loads article URL in webView
    NSURL *myURL = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    [self.webView loadRequest:request];
}
@end