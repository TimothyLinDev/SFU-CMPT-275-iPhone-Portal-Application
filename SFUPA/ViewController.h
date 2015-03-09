//
//  ViewController.h
//  SFUPA
//  Team 07
//  Created by Timothy Lin on 3/7/2015
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//
//  Contributors: Timothy Lin,
//
//  Assignment 3:
//  Edited by: | What was done?
//  Timothy    | Created

#import <UIKit/UIKit.h>
#import "iCarousel.h"


@interface ViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet UIButton *mainScreenLoginButton; // also the logout button
- (IBAction)pressedMainScreenLoginButton:(id)sender;

@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@end
