//
//  LoginManager.m
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
//  Rylan      | Created and set up login
//
//  Assignment 5:
//  Rylan      | Refactoring

#import "LoginManager.h"

@implementation LoginManager {
    LoginViewController *controller;
    NSMutableData *receivedData;
    NSURLConnection *casConnection;
    NSURLConnection *gosfuConnection;
    BOOL casSuccess;
    BOOL gosfuSuccess;
    NSString *loginTicket;
    NSString *flowExecutionKey;
}

- (void)logInWithUsername:(NSString *)username
                 password:(NSString *)password
                 delegate:(LoginViewController *)viewController {
    controller = viewController;
    casSuccess = NO;
    gosfuSuccess = NO;
    NSURL *url;
    NSString *query;
    NSMutableURLRequest *request;

    [casConnection cancel];
    [gosfuConnection cancel];
    [LoginManager logOut];

    // goSFU Login
    // Build the query string
    query = [NSString stringWithFormat:
             @"httpPort=&timezoneOffset=420&user=%@&pwd=%@&userid=%@&Submit=Login",
             username, password, username.uppercaseString];
    // Create a URL object
    url = [NSURL URLWithString:@"https://go.sfu.ca/psp/paprd/EMPLOYEE/EMPL/?cmd=login"];
    // Make an HTTP POST request
    request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSData dataWithBytes:[query UTF8String]
                                        length:strlen([query UTF8String])]];
    // Create an object in which to store data and make a connection
    receivedData = [NSMutableData dataWithCapacity:0];
    gosfuConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    // CAS Login
    // Fetch the SFU CAS login page and feed it to an XML parser.
    // Obtain login ticket and flow execution key from a parser delegate.
    url = [NSURL URLWithString:@"https://cas.sfu.ca/cas/login"];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser parse];
    
    if (!loginTicket || !flowExecutionKey) {
        [casConnection cancel];
        [gosfuConnection cancel];
        [controller didReceiveLoginAttemptStatus:LOGIN_NO_CONNECTION];
        return;
    }

    // Build the query string
    query = [NSString stringWithFormat:
             @"username=%@&password=%@&lt=%@&execution=%@&_eventId=%@",
             username, password, loginTicket, flowExecutionKey, @"submit"];

    // Make an HTTP POST request
    request = [NSMutableURLRequest requestWithURL:url];

    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSData dataWithBytes:[query UTF8String]
                                        length:strlen([query UTF8String])]];
    // Create an object in which to store data and make a connection
    receivedData = [NSMutableData dataWithCapacity:0];
    casConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

+ (BOOL)loggedIn {
    return [LoginManager casLoggedIn] && [LoginManager gosfuLoggedIn];
}

- (BOOL)loggedIn:(NSURLConnection *)connection {
    if (connection == casConnection) {
        return [LoginManager casLoggedIn];
    }
    if (connection == gosfuConnection) {
        return [LoginManager gosfuLoggedIn];
    }
    return NO;
}

+ (BOOL)casLoggedIn {
    // Return whether both `JSESSIONID` and `CASTGC` cookies exist for the domain `cas.sfu.ca`
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    BOOL jsessionidFlag = NO;
    BOOL castgcFlag = NO;
    for (NSHTTPCookie *cookie in cookies) {
        if ([[cookie domain] isEqualToString:@"cas.sfu.ca"]) {
            if ([[cookie name] isEqualToString:@"JSESSIONID"]) {
                jsessionidFlag = YES;
            } else if ([[cookie name] isEqualToString:@"CASTGC"]) {
                castgcFlag = YES;
            }
        }
    }
    return jsessionidFlag && castgcFlag;
}

+ (BOOL)gosfuLoggedIn {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    BOOL flag = NO;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:@"PS_LOGINLIST"] &&
            [cookie.value rangeOfString:@"https://sims-prd.sfu.ca/csprd"].location != NSNotFound) {
            flag = YES;
            break;
        }
    }
    return flag;
}

+ (void)logOut {
    // Clear all cookies
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSHTTPCookie *cookie;
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error {
    [casConnection cancel];
    [gosfuConnection cancel];
    [controller didReceiveLoginAttemptStatus:LOGIN_NO_CONNECTION];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([self loggedIn:connection]) {
        if (connection == casConnection) {
            casSuccess = YES;
        } else {
            gosfuSuccess = YES;
        }
    } else {
        [casConnection cancel];
        [gosfuConnection cancel];
        [controller didReceiveLoginAttemptStatus:LOGIN_INVALID];
        return;
    }
    if (casSuccess && gosfuSuccess) {
        [controller didReceiveLoginAttemptStatus:LOGIN_SUCCESS];
    }
}

#pragma mark - NSXMLParserDelegate

- (void)         parser:(NSXMLParser *)parser
        didStartElement:(NSString *)element
           namespaceURI:(NSString *)namespaceURI
          qualifiedName:(NSString *)qualifiedName
             attributes:(NSDictionary *)attributes {
    // Need the `value` attributes of `input` elements whose `name` attribute is "lt" or "execution"
    if ([element isEqualToString:@"input"]) {
        if ([attributes[@"name"] isEqualToString:@"lt"]) {
            loginTicket = attributes[@"value"];
        } else if ([attributes[@"name"] isEqualToString:@"execution"]) {
            flowExecutionKey = attributes[@"value"];
        }
    }
}

@end
