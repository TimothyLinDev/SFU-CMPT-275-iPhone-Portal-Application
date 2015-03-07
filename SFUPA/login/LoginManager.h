//
//  LoginManager.h
//  SFUPA
//
//  Created by Rylan on 2015-03-05.
//
//

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
