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

#import <Foundation/Foundation.h>

typedef enum {
    LOGIN_SUCCESS,
    LOGIN_INVALID,
    LOGIN_NO_CONNECTION
} LoginAttemptStatus;

@interface LoginManager : NSObject <NSURLConnectionDelegate>

- (void)logInWithUsername:(NSString *)username
                 password:(NSString *)password
                 delegate:(id)viewController;
+ (BOOL)loggedIn;
+ (void)logOut;

@end
