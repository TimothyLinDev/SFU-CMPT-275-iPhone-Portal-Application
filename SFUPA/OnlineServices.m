//
//  OnlineServices.m
//  SFUPA
//
//  Created by Aman on 3/7/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//

#import "OnlineServices.h"
#import "WebViewScreen.h"

@interface OnlineServices ()


@end

@implementation OnlineServices

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CanvasScreen"])
    {
        WebViewScreen *wvs = (WebViewScreen *)segue.destinationViewController;
        wvs.segueData = @"Canvas";
    }
    else if([segue.identifier isEqualToString:@"CoursysScreen"])
    {
        WebViewScreen *controller = (WebViewScreen *)segue.destinationViewController;
        controller.segueData = @"Coursys";
    }
    if([segue.identifier isEqualToString:@"ConnectScreen"])
    {
        WebViewScreen *wvs = (WebViewScreen *)segue.destinationViewController;
        wvs.segueData = @"Connect";
    }
    else if([segue.identifier isEqualToString:@"goSFUScreen"])
    {
        WebViewScreen *controller = (WebViewScreen *)segue.destinationViewController;
        controller.segueData = @"goSFU";
    }
    else if([segue.identifier isEqualToString:@"SimplicityScreen"])
    {
        WebViewScreen *controller = (WebViewScreen *)segue.destinationViewController;
        controller.segueData = @"Simplicity";
    }
    
}

- (IBAction)btnCanvas:(id)sender
{
}
- (IBAction)btnCoursys:(id)sender
{
}
- (IBAction)btnConnect:(id)sender
{
}
- (IBAction)btngoSFU:(id)sender
{
}
- (IBAction)btnSimplicity:(id)sender
{
}
@end

