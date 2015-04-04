//
//  LoginManager.h
//  SFUPA
//  Team 07
//  Created by Rylan on 2015-03-05.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Rylan Lim
//
//  Assignment 3:
//  Edited by: | What was done?
//  Rylan      | Created
//
//  Assignment 5:
//  Rylan      | Refactoring
//  Rylan      | Implemented goSFU login

#import <Foundation/Foundation.h>
#import "LoginViewController.h"

@interface LoginManager : NSObject <NSURLConnectionDelegate, NSXMLParserDelegate>

- (void)logInWithUsername:(NSString *)username
                 password:(NSString *)password
                 delegate:(LoginViewController *)viewController;
+ (BOOL)loggedIn;
+ (void)logOut;

@end
