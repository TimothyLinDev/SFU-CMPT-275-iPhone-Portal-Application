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
//  Contributors: Timothy Lin, Rylan Lim
//
//  Assignment 3:
//  Edited by: | What was done?
//  Timothy    | Created
//  Rylan      | Implemented main screen login/logout button

#import <UIKit/UIKit.h>
#import "iCarousel.h"


@interface ViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnMainScreenLogin; // also the logout button
- (IBAction)pressedBtnMainScreenLogin:(id)sender;

@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@end
