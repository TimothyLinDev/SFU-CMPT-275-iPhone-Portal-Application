//
//  ViewController.h
//  Team 07
//  SFUPA
//  Created by Timothy Lin on 3/7/2015
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"


@interface ViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet UIButton *mainScreenLoginButton; // also the logout button
- (IBAction)pressedMainScreenLoginButton:(id)sender;

@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@end
