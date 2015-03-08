//
//  ViewController.h
//  SFUPA
//
//  Created by Rylan on 2015-03-08.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *mainScreenLoginButton; // also the logout button
- (IBAction)pressedMainScreenLoginButton:(id)sender;

@end
