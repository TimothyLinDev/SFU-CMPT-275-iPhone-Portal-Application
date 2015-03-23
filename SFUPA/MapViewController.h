//
//  MapViewController.m
//  SFUPA
//  Team 07
//  Created by Mavis and Victor 3/3/15
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//  User should change floor by themselves
//  Markers only works for the 2nd floor and 3rd floor
//  Wayfinding only works if the "To" room number is bigger than "From" - FIXED
//  Wayfinding only working for most of the 2nd floor
//  Wayfinding path not appearing for the 3rd floor - FIXED
//  Wayfinding only working for half of the 3rd floor
//  Wayfinding path not working for different floors
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

// Assignment 4:
// Victor | Fixing wayfinding so that it appears for the 3rd floor
// Victor | Fixing wayfinding so that "From" room number is bigger than "To" works
// Victor | Implementing wayfinding for different floors


#import <UIKit/UIKit.h>
#import "GoogleMaps/GoogleMaps.h"

@interface MapViewController : UIViewController <GMSMapViewDelegate>{
    __weak IBOutlet UIButton *btnSearch;
    __weak IBOutlet UIView *viewSlide;
    __weak IBOutlet UIButton *btnDown;
    __weak IBOutlet UIButton *btnRemove;
}

-(IBAction)pressedBtnClean:(id)sender;
-(IBAction)pressedBtnSelfMarker:(id)sender;
-(IBAction)pressedBtnMarker:(id)sender;
-(IBAction)pressedBtnDownward:(id)sender;
-(IBAction)pressedBtnUpward:(id)sender;

@end

