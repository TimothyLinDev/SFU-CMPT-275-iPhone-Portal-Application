//
//  FindABook.h
//  SFUPA
//
//  Created by Aman on 4/4/15.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Amandeep Saini
//
//  Assignment 5:
//  Edited by: | What was done?
//  Amandeep   | Created

#import <UIKit/UIKit.h>

@interface FindABook : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldDept;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNumber;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSection;
@property (weak, nonatomic) IBOutlet UITextField *textFieldInstructor;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSemester;
- (IBAction)btnSubmit:(id)sender;



@end