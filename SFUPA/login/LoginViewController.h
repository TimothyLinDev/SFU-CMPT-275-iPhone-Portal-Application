//
//  LoginViewController.h
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
//  Rylan      | Linking to storyboard

#import <UIKit/UIKit.h>

typedef enum {
    LOGIN_SUCCESS,
    LOGIN_INVALID,
    LOGIN_NO_CONNECTION
} LoginAttemptStatus;

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)pressedBtnLogin:(id)sender;
- (void)didReceiveLoginAttemptStatus:(LoginAttemptStatus)status;

@end
