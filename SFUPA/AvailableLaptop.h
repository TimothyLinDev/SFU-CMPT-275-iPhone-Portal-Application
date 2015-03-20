//
//  AvailableLaptop.h
//  SFUPA
//
//  Created by Aman on 3/19/15.
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

@interface AvailableLaptop : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSDictionary * jsonArray;
@property (nonatomic, strong) NSMutableArray * laptopArray;

#pragma mark -
#pragma mark Class Methods
- (void) retrieveData;
@property (weak, nonatomic) IBOutlet UILabel *checkedoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *availableLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *unavailableLabel;


@end