//
//  ViewController.h
//  SFUPA
//
//  Created by Aman on 3/3/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleMaps/GoogleMaps.h"

@interface ViewController : UIViewController <GMSMapViewDelegate>{
    __weak IBOutlet UIButton *search;
    __weak IBOutlet UIView *slide;
    __weak IBOutlet UIButton *down;
    __weak IBOutlet UIButton *remove;
}

-(IBAction)clean:(id)sender;
-(IBAction)selfmarker:(id)sender;
-(IBAction)marker:(id)sender;
-(IBAction)remove:(id)sender;
-(IBAction)downward:(id)sender;
-(IBAction)upward:(id)sender;

@end

