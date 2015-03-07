//
//  LoginViewController.h
//  SFUPA
//
//  Created by Rylan on 2015-03-05.
//
//

#import <UIKit/UIKit.h>
#import "LoginManager.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)pressedLoginButton:(id)sender;
- (void)didReceiveLoginAttemptStatus:(LoginAttemptStatus)status;
- (IBAction)pressedLogoutButton:(id)sender;

@end
