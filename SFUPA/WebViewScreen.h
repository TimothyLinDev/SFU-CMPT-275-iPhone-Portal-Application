//
//  WebViewScreen.h
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
//  Amandeep   | Created

#import <UIKit/UIKit.h>

@interface WebViewScreen : UIViewController <UIWebViewDelegate>
@property (retain, nonatomic) NSString *segueData;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *lblNavBar;

@end
