//
//  ViewController.m
//  SFUPA
//  Team 07
//  Created by Timothy Lin on 3/7/2015
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//  occassionally cause signal SIGABRT to appear when app exited
//
//  Contributors: Timothy Lin,
//
//  Assignment 3:
//  Edited by: | What was done?
//  Timothy    | Changed carousel to have hard coded temporary images
//  Timothy    | Created from iCarousel's Storyboard Example

#import "ViewController.h"
#import "LoginManager.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *items;

@end


@implementation ViewController

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

@synthesize carousel;
@synthesize items;

- (void)awakeFromNib{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray array];
    for (int i = 0; i < 4; i++){
        [items addObject:@(i)];
    }
}

- (void)dealloc{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    carousel.delegate = nil;
    carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];

    // configure login/logout button
    NSString *imageName;
    if ([LoginManager loggedIn]) {
        imageName = @"logout.png";
    } else {
        imageName = @"login button.png";
    }
    [_mainScreenLoginButton setImage:[UIImage imageNamed:imageName]
                            forState:UIControlStateNormal];

    //configure carousel
    carousel.type = iCarouselTypeCoverFlow2;
}

- (void)viewDidUnload{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    //return the total number of items in the carousel
    return [items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    UILabel *temp = nil;
    
    //create new view if no view is available for recycling
    if (view == nil){
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240.0f, 190.0f)];
        view.contentMode = UIViewContentModeScaleAspectFit;
        
        //editing temporary label
        temp = [[UILabel alloc] initWithFrame:view.bounds];
        temp.backgroundColor = [UIColor clearColor];
        temp.textAlignment = NSTextAlignmentCenter;
        temp.font = [temp.font fontWithSize:30];
        temp.textColor = [UIColor redColor];
        temp.tag = 1;
        [view addSubview:temp];
    } else{
        temp = (UILabel *)[view viewWithTag:1];
    }
    
    //hard coded for temporary images as placeholders

    ((UIImageView *)view).image = [UIImage imageNamed:@"cute-cat.jpg"];
    temp.text = @"Placeholder";
    
    return view;
}

@end
