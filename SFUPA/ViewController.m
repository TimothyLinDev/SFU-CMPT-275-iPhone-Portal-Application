//
//  ViewController.m
//  SFUPA
//
//  Created by Rylan on 2015-03-08.
//
//

#import "ViewController.h"
#import "LoginManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *imageName;
    if ([LoginManager loggedIn]) {
        imageName = @"logout.png";
    } else {
        imageName = @"login button.png";
    }
    [_mainScreenLoginButton setImage:[UIImage imageNamed:imageName]
                            forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedMainScreenLoginButton:(id)sender {
    if (![LoginManager loggedIn]) {
        return;
    }
    [LoginManager logOut];
    [[[UIAlertView alloc] initWithTitle:@"Logout Successful"
                                message:@"✓"
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    [_mainScreenLoginButton setImage:[UIImage imageNamed:@"login button.png"]
                            forState:UIControlStateNormal];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier
                                  sender:(id)sender {
    if ([identifier isEqualToString:@"mainToLogin"]) {
        return ![LoginManager loggedIn];
    } else {
        return YES;
    }
}

@end
