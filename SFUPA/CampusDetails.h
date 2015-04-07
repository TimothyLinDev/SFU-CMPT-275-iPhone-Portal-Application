//
//  CampusDetail.h
//  SFUPA
//  Team 07
//  Created by Aman on 4/2/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Amandeep Saini
//
//  Assignment 5:
//  Edited by: | What was done?
//  Amandeep   | Created and assign and send value

#import <UIKit/UIKit.h>

@interface CampusDetails : UIViewController <UIWebViewDelegate>
@property (retain, nonatomic) NSString *segueData;
@property (weak, nonatomic) IBOutlet UILabel *lblNavBar;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblContactNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblEmergencyNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentTemp;
@property (weak, nonatomic) IBOutlet UILabel *lblTomStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblTomMin;
@property (weak, nonatomic) IBOutlet UILabel *lblTomMax;
@property (weak, nonatomic) IBOutlet UIImageView *UICurrentImage;
@property (weak, nonatomic) IBOutlet UIImageView *UITomImage;







//Array Properties
@property (nonatomic, strong) NSDictionary * jsonArray;
@property (nonatomic, strong) NSMutableArray * weatherArray;


@end
