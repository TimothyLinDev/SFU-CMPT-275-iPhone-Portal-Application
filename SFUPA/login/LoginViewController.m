//
//  LoginViewController.m
//  SFUPA
//
//  Created by Rylan on 2015-03-05.
//
//

#import "LoginViewController.h"
#import "LoginManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedLoginButton:(id)sender {
    LoginManager *manager = [[LoginManager alloc] init];
    [manager logInWithUsername:[_usernameField text]
                      password:[_passwordField text]
                      delegate:self];
}

- (void)didReceiveLoginAttemptStatus:(LoginAttemptStatus)status {
    NSString *title;
    NSString *message;

    switch (status) {
        case LOGIN_SUCCESS:
            NSLog(@"LOGIN_SUCCESS");
            [_usernameField setText:@""];
            title = @"Login Successful";
            message = @"✓";
            break;
        case LOGIN_INVALID:
            NSLog(@"LOGIN_INVALID");
            title = @"Invalid Login";
            message = @"✗";
            break;
        case LOGIN_NO_CONNECTION:
            NSLog(@"LOGIN_NO_CONNECTION");
            title = @"No Internet Connection";
            message = @"⚠";
            break;
    }
    [_passwordField setText:@""];
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

@end
