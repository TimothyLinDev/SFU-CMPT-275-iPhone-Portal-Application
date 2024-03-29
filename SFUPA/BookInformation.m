//
//  BookInformation.m
//  SFUPA
//
//  Created by Aman on 4/7/15.
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
#import "BookInformation.h"
@interface BookInformation ()
{
    NSString *bookNameValue;
    NSString *bookAuthorNameValue;
    NSString *bookCoverUrlValue;
}

@end

@implementation BookInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self displayData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) displayData
{
    bookNameValue = self.nameBook;
    bookAuthorNameValue = self.nameAuthor;
    bookCoverUrlValue = self.bookCoverUrl;
    
    _lblBookName.text = bookNameValue;
    _lblAuthorName.text = bookAuthorNameValue;
    
    NSURL *URL = [NSURL URLWithString:bookCoverUrlValue];
    _CoverUrlWebView.delegate = self;
    //Requesting to URL
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [_CoverUrlWebView loadRequest:request];
}

@end