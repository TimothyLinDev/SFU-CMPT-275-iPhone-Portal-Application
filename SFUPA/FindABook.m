//
//  FindABook.m
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

#import <Foundation/Foundation.h>
#import "FindABook.h"
#import "BookDetail.h"

@interface FindABook ()

@end

@implementation FindABook

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"BookDetail"])
    {
        BookDetail *bd = (BookDetail *)segue.destinationViewController;
        bd.dept = self.textFieldDept.text;
        bd.number = self.textFieldNumber.text;
        bd.section = self.textFieldSection.text;
        bd.instructor = self.textFieldInstructor.text;
        bd.semester = self.textFieldSemester.text;
    }
}


- (IBAction)btnSubmit:(id)sender {
}
@end