//
//  WebViewScreen.h
//  SFUPA
//
//  Created by Aman on 3/7/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewScreen : UIViewController
@property (retain, nonatomic) NSString *segueData;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *lblNavBar;

@end
