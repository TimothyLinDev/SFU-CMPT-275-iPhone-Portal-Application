//
//  LibraryHours.h
//  SFUPA
//
//  Created by Aman on 3/20/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Amandeep Saini
//
//  Assignment 3:
//  Edited by: | What was done?
//  Amandeep   | Created

#import <UIKit/UIKit.h>

@interface LibraryHours : UIViewController <UIWebViewDelegate>
//Array properties
@property (nonatomic, strong) NSDictionary * jsonArray;
@property (nonatomic, strong) NSMutableArray * hoursArray;

//Label properties
@property (weak, nonatomic) IBOutlet UILabel *bbyOpenTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *surOpenTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vanOpenTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bbyCloseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *surCloseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vanCloseTimeLabel;


//Method of retrieve Data
- (void) retrieveData;

@end