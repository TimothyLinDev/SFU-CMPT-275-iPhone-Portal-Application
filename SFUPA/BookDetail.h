//
//  BookDetail.h
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

@interface BookDetail : UIViewController <UITableViewDelegate, UITableViewDataSource>

//Getting data
@property (retain, nonatomic) NSString *dept;
@property (retain, nonatomic) NSString *number;
@property (retain, nonatomic) NSString *section;
@property (retain, nonatomic) NSString *instructor;
@property (retain, nonatomic) NSString *semester;

//Array properties
@property (nonatomic, strong) NSDictionary * jsonArray;
@property (nonatomic, strong) NSMutableArray * booksArray;
@property (weak, nonatomic) IBOutlet UITableView *bookTableView;


@end