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

#import <UIKit/UIKit.h>
#import "LoginManager.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)pressedLoginButton:(id)sender;
- (void)didReceiveLoginAttemptStatus:(LoginAttemptStatus)status;

@end
