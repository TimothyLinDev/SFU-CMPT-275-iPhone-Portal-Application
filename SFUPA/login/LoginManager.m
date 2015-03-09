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
//  Rylan      | Created and set up log in
//  Rylan      | Linking to storyboard

#import "LoginManager.h"
#import "LoginViewController.h"

@interface XMLParserDelegate : NSObject <NSXMLParserDelegate>

@property NSString *loginTicket;
@property NSString *flowExecutionKey;

@end


@implementation LoginManager {
    NSMutableData *receivedData;
    id controller;
}

- (void)logInWithUsername:(NSString *)username
                 password:(NSString *)password
                 delegate:(id)viewController {
    controller = viewController;

    // Fetch the SFU CAS login page and feed it to an XML parser.
    // Obtain login ticket and flow execution key from a parser delegate.
    NSURL *url = [NSURL URLWithString:@"https://cas.sfu.ca/cas/login"];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    XMLParserDelegate *delegate = [[XMLParserDelegate alloc] init];
    [parser setDelegate:delegate];
    [parser parse];
    
    if (!delegate.loginTicket || !delegate.flowExecutionKey) {
        [controller didReceiveLoginAttemptStatus:LOGIN_NO_CONNECTION];
        return;
    }

    // Build the query string
    NSString *query = [NSString stringWithFormat:
                       @"username=%@&password=%@&lt=%@&execution=%@&_eventId=%@",
                       username, password, delegate.loginTicket,
                       delegate.flowExecutionKey, @"submit"];

    // Make an HTTP POST request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSData dataWithBytes:[query UTF8String]
                                        length:strlen([query UTF8String])]];

    receivedData = [NSMutableData dataWithCapacity:0];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

+ (BOOL)loggedIn {
    // Return whether both `JSESSIONID` and `CASTGC` cookies exist for the domain `cas.sfu.ca`
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    BOOL jsessionidFlag = NO;
    BOOL castgcFlag = NO;
    id cookie;
    for (cookie in cookies) {
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

+ (void)logOut {
    // Clear all cookies
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSHTTPCookie *cookie;
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

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
    [controller didReceiveLoginAttemptStatus:LOGIN_NO_CONNECTION];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([LoginManager loggedIn]) {
        [controller didReceiveLoginAttemptStatus:LOGIN_SUCCESS];
    } else {
        [controller didReceiveLoginAttemptStatus:LOGIN_INVALID];
    }
}
@end


@implementation XMLParserDelegate

- (void)         parser:(NSXMLParser *)parser
        didStartElement:(NSString *)element
           namespaceURI:(NSString *)namespaceURI
          qualifiedName:(NSString *)qualifiedName
             attributes:(NSDictionary *)attributes {
    // Need the `value` attributes of `input` elements whose `name` attribute is "lt" or "execution"
    if ([element isEqualToString:@"input"]) {
        if ([attributes[@"name"] isEqualToString:@"lt"]) {
            [self setLoginTicket:attributes[@"value"]];
        } else if ([attributes[@"name"] isEqualToString:@"execution"]) {
            [self setFlowExecutionKey:attributes[@"value"]];
        }
    }
}

- (void)    parser:(NSXMLParser *)parser
parseErrorOccurred:(NSError *)parseError {
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
}

@end
