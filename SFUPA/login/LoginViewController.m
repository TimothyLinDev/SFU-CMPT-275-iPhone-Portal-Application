//
//  LoginViewController.m
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

#import "LoginViewController.h"
#import "LoginManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController {
    LoginManager *manager;
    LoginAttemptStatus loginAttemptStatus;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [[LoginManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedBtnLogin:(id)sender {
    [manager logInWithUsername:[_usernameField text]
                      password:[_passwordField text]
                      delegate:self];
}

- (void)didReceiveLoginAttemptStatus:(LoginAttemptStatus)status {
    NSString *title;
    NSString *message;

    loginAttemptStatus = status;
    switch (status) {
        case LOGIN_SUCCESS:
            [_usernameField setText:@""];
            title = @"Login Successful";
            message = @"✓";
            break;
        case LOGIN_INVALID:
            title = @"Invalid Login";
            message = @"✗";
            break;
        case LOGIN_NO_CONNECTION:
            title = @"No Internet Connection";
            message = @"⚠";
            break;
    }
    [_passwordField setText:@""];
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:self
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (loginAttemptStatus == LOGIN_SUCCESS) {
        [self performSegueWithIdentifier:@"loginToMain" sender:self];
    }
}

@end
