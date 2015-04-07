//
//  SFUNewsMasterView.h
//  SFUPA
//
//  Created by Timothy Lin on 2015-03-22.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Timothy Lin
//
//  Assignment 4:
//  Edited by: | What was done?
//  Timothy    | Added in a bunch of arrays
//  Timothy    | Created

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@interface SFUNewsMasterView:UIViewController <UINavigationBarDelegate, UITableViewDataSource, UITableViewDelegate, MWFeedParserDelegate>{
    
    //For Parsing
    MWFeedParser *parser;
    NSMutableArray *parsedItems;
    NSMutableArray *urls;
    NSInteger currentIndex;
    
    //For Displaying
    NSArray *itemsForDisplayP;
    NSArray *itemsForDisplayC;
    NSArray *itemsForDisplayS;
    NSArray *itemsForDisplayL;
    NSArray *itemsForDisplayR;
    NSArray *theURLs;
    NSMutableArray *MoreUrls;
    NSDateFormatter *formatter;
    

    
    
}

@property(strong, nonatomic) NSArray *itemsForDisplayP;
@property(strong, nonatomic) NSArray *itemsForDisplayC;
@property(strong, nonatomic) NSArray *itemsForDisplayS;
@property(strong, nonatomic) NSArray *itemsForDisplayL;
@property(strong, nonatomic) NSArray *itemsForDisplayR;
@property(strong, nonatomic) NSArray *theURLs;


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end