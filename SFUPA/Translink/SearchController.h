//
//  SearchController.h
//  Translink
//
//  Created by Mavis on 15-3-18.
//  Copyright (c) 2015年 Mavis. All rights reserved.
//

#ifndef Translink_SearchController_h
#define Translink_SearchController_h
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface SearchController : UIViewController <GMSMapViewDelegate>

@property (retain, nonatomic) NSString *segueData;

-(NSString*) makeRestAPICall : (NSString*) reqURLStr;
-(IBAction)searchaction:(id)sender;
-(void)search;

@end

#endif
