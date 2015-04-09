//
//  BookInformation.h
//  SFUPA
//
//  Created by Aman on 4/7/15.
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

@interface BookInformation : UIViewController <UIWebViewDelegate>

//Getting data
@property (retain, nonatomic) NSString *nameBook;
@property (retain, nonatomic) NSString *nameAuthor;
@property (retain, nonatomic) NSString *bookCoverUrl;
@property (weak, nonatomic) IBOutlet UILabel *lblBookName;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthorName;
@property (weak, nonatomic) IBOutlet UIWebView *CoverUrlWebView;


@end