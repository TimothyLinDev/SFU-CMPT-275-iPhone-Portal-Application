//
//  MapViewController.h
//  SFUPA
//  Team 07
//  Created by Mavis and Victor 3/3/15
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//  User should change floor by themselves
//  Markers only works for the 2nd floor and 3rd floor
//  Wayfinding only works if the "To" room number is bigger than "From"
//  Wayfinding only working for most of 2nd floor
//  Wayfinding path not appearing for 3rd floor
//
//  Contributors: Mavis and Victor
//
// Assignment 3:
// Edited by: | What was done?
// Mavis and Victor | Created
// Mavis and Victor | Implementing maps
// Mavis | Linking to storyboard
// Mavis | Reading file with coordinates
// Victor | Implementing wayfinding

#import <UIKit/UIKit.h>
#import "GoogleMaps/GoogleMaps.h"

@interface MapViewController : UIViewController <GMSMapViewDelegate>{
    __weak IBOutlet UIButton *btnSearch;
    __weak IBOutlet UIView *viewSlide;
    __weak IBOutlet UIButton *btnDown;
    __weak IBOutlet UIButton *btnRemove;
}

-(IBAction)clean:(id)sender;
-(IBAction)selfmarker:(id)sender;
-(IBAction)marker:(id)sender;
-(IBAction)downward:(id)sender;
-(IBAction)upward:(id)sender;

@end

