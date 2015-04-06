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
//  Timothy    | Created

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@interface SFUNewsMasterView:UIViewController <UITableViewDataSource, UITableViewDelegate, MWFeedParserDelegate>{
    
    //For Parsing
    MWFeedParser *parser;
    NSMutableArray *parsedItems;
    
    //For Displaying
    NSArray *itemsForDisplay;
    NSDateFormatter *formatter;
}

@property(strong, nonatomic) NSArray *itemsForDisplay;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end