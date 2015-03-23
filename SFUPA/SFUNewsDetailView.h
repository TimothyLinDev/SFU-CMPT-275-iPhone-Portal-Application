//
//  SFUNewsDetailView.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MWFeedItem.h"

@interface SFUNewsDetailView:UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) NSString *url;

@end