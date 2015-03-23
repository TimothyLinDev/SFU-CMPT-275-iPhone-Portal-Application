//
//  SFUNewsMasterView.m
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
// Code mostly taken from Michael Waterfall's MWFeedReader Application
//

#import "SFUNewsMasterView.h"
#import "NSString+HTML.h"
#import "SFUNewsDetailView.h"

@interface SFUNewsMasterView()

@end

@implementation SFUNewsMasterView

@synthesize itemsForDisplay;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    //Setting up
    self.title = @"Loading...";
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    parsedItems = [[NSMutableArray alloc] init];
    self.itemsForDisplay = [NSArray array];
    
    //Parsing URL Currently just hardcoded with the People section of SFU News
    NSURL *newsURL = [NSURL URLWithString:@"feed://www.sfu.ca:80/content/sfu/sfunews/people/jcr:content/main_content/list.feed"];
    
    //Parse
    parser = [[MWFeedParser alloc] initWithFeedURL:newsURL];
    parser.delegate = self;
    parser.feedParseType = ParseTypeFull;
    parser.connectionType = ConnectionTypeAsynchronously;
    [parser parse];
}

-(void)updateTableWithParsedItems{
    self.itemsForDisplay = [parsedItems sortedArrayUsingDescriptors:
                           [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date"
                                                                                ascending:NO]]];
    self.tableView.userInteractionEnabled = YES;
    self.tableView.alpha = 1;
    [self.tableView reloadData];
}

//Parser Delegate
- (void)feedParserDidStart:(MWFeedParser *)parser {
    NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    NSLog(@"Parsed Feed Info: “%@”", info.title);
    self.title = info.title;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSLog(@"Parsed Feed Item: “%@”", item.title);
    if (item) [parsedItems addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    [self updateTableWithParsedItems];
}
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"Finished Parsing With Error: %@", error);
    if (parsedItems.count == 0) {
        self.title = @"Failed"; // Show failed message in title
    } else {
        // Failed but some items parsed, so show and inform of error
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
                                                        message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];
    }
    [self updateTableWithParsedItems];
}




//TABLE STUFF
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return itemsForDisplay.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell.
    MWFeedItem *item = [itemsForDisplay objectAtIndex:indexPath.row];
    if (item) {
        
        // Process
        NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
        
        // Set
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.textLabel.text = itemTitle;
        NSMutableString *subtitle = [NSMutableString string];
        if (item.date) [subtitle appendFormat:@"%@: ", [formatter stringFromDate:item.date]];
        [subtitle appendString:itemSummary];
        cell.detailTextLabel.text = subtitle;
        
    }
    return cell;
}
//Sends URL information to web view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        //Grabbing article link
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MWFeedItem *item = [itemsForDisplay objectAtIndex:indexPath.row];
        NSString *string = item.link;
        
        //Sending link to View Controller
        SFUNewsDetailView *destinationViewController = segue.destinationViewController;
        destinationViewController.url = string;

        
    }
}


@end