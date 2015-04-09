//
//  SFUNewsMasterView.m
//  SFUPA
//
//  Created by Timothy Lin on 2015-03-22.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//  * Missing Back button
//
//  Contributors: Timothy Lin
//
//  Assignment 4:
//  Edited by: | What was done?
//  Timothy    | Now reads multiple feeds
//  Timothy    | Changed to UITableViewController witin UIViewController
//  Timothy    | Created
// Code mostly taken from Michael Waterfall's MWFeedReader Application
//

#import "SFUNewsMasterView.h"
#import "NSString+HTML.h"
#import "SFUNewsDetailView.h"
#import "Reachability.h"

@interface SFUNewsMasterView()

@end

@implementation SFUNewsMasterView

@synthesize itemsForDisplayP;
@synthesize itemsForDisplayC;
@synthesize itemsForDisplayS;
@synthesize itemsForDisplayL;
@synthesize itemsForDisplayR;
@synthesize theURLs;


- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    //Setting up
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    parsedItems = [[NSMutableArray alloc] init];
    
    //Arrays to store parsed items for each feed
    self.itemsForDisplayP = [NSArray array];
    self.itemsForDisplayC = [NSArray array];
    self.itemsForDisplayS = [NSArray array];
    self.itemsForDisplayL = [NSArray array];
    self.itemsForDisplayR = [NSArray array];
    
    //URLS for the various News Feeds
    NSURL *newsURL0 = [NSURL URLWithString:@"feed://www.sfu.ca:80/content/sfu/sfunews/people/jcr:content/main_content/list.feed"];
    NSURL *newsURL1 = [NSURL URLWithString:@"feed://www.sfu.ca:80/content/sfu/sfunews/community/jcr:content/main_content/list.feed"];
    NSURL *newsURL2 = [NSURL URLWithString:@"feed://www.sfu.ca:80/content/sfu/sfunews/sports/jcr:content/main_content/list.feed"];
    NSURL *newsURL3 = [NSURL URLWithString:@"feed://www.sfu.ca:80/content/sfu/sfunews/learning/jcr:content/main_content/list.feed"];
    NSURL *newsURL4 = [NSURL URLWithString:@"feed://www.sfu.ca:80/content/sfu/sfunews/research/jcr:content/main_content/list.feed"];
    
    //URLs to be passed to parser
    urls = [[NSMutableArray alloc] initWithObjects:newsURL0, newsURL1, newsURL2, newsURL3, newsURL4, nil];
    
    //URLs for the More Cell
    MoreUrls = [[NSMutableArray alloc] initWithObjects:@"http://www.sfu.ca/sfunews/people.html", @"http://www.sfu.ca/sfunews/community.html", @"http://www.sfu.ca/sfunews/sports.html", @"http://www.sfu.ca/sfunews/learning.html",@"http://www.sfu.ca/sfunews/research.html",nil];
    
    //Parse
    currentIndex = 0;
    
    //Detects Wifi
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        [[[UIAlertView alloc] initWithTitle:@"No Internet Access"
                                   message:@"No Internet Access detected. SFU News will not load the latest articles without access to the internet."
                                  delegate:self
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil] show];

    }
    else if (status == ReachableViaWiFi)
    {
        [self parseNextURL];
    }
    else if (status == ReachableViaWWAN)
    {
        [self parseNextURL];
    }


    [self parseNextURL];
    
    

}
-(void)parseNextURL{
    NSURL *url = [urls objectAtIndex:currentIndex];
    parser = [[MWFeedParser alloc] initWithFeedURL:url];
    parser.delegate = self;
    parser.feedParseType = ParseTypeFull;
    parser.connectionType = ConnectionTypeAsynchronously;
    [parser parse];
}

-(void)updateTableWithParsedItems{
    NSArray *temp = [parsedItems sortedArrayUsingDescriptors:
                     [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date"
                                                                          ascending:NO]]];
    switch(currentIndex){
        case 0:
            self.itemsForDisplayP = [temp arrayByAddingObjectsFromArray:itemsForDisplayP];
            self.itemsForDisplayP = [itemsForDisplayP arrayByAddingObject:[MoreUrls objectAtIndex:currentIndex]];
            break;
        case 1:
            self.itemsForDisplayC = [temp arrayByAddingObjectsFromArray:itemsForDisplayC];
            self.itemsForDisplayC = [itemsForDisplayC arrayByAddingObject:[MoreUrls objectAtIndex:currentIndex]];
            break;
        case 2:
            self.itemsForDisplayS = [temp arrayByAddingObjectsFromArray:itemsForDisplayS];
            self.itemsForDisplayS = [itemsForDisplayS arrayByAddingObject:[MoreUrls objectAtIndex:currentIndex]];
            break;
        case 3:
            self.itemsForDisplayL = [temp arrayByAddingObjectsFromArray:itemsForDisplayL];
            self.itemsForDisplayL = [itemsForDisplayL arrayByAddingObject:[MoreUrls objectAtIndex:currentIndex]];
            break;
        case 4:
            self.itemsForDisplayR = [temp arrayByAddingObjectsFromArray:itemsForDisplayR];
            self.itemsForDisplayR = [itemsForDisplayR arrayByAddingObject:[MoreUrls objectAtIndex:currentIndex]];
            break;
    }
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
    parsedItems = [[NSMutableArray alloc] init];
    currentIndex++;
    if(currentIndex < urls.count){
        [self parseNextURL];
    }else{
        [parser stopParsing];
    }
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
    return 5;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *sectionName;
    switch(section){
        case 0:
            sectionName = @"People";
            break;
        case 1:
            sectionName = @"Community";
            break;
        case 2:
            sectionName = @"Sports";
            break;
        case 3:
            sectionName = @"Learning";
            break;
        case 4:
            sectionName = @"Research";
            break;
    }
    return sectionName;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = 0;
    switch(section){
        case 0:
            count = itemsForDisplayP.count;
            break;
        case 1:
            count = itemsForDisplayC.count;
            break;
        case 2:
            count = itemsForDisplayS.count;
            break;
        case 3:
            count = itemsForDisplayL.count;
            break;
        case 4:
            count = itemsForDisplayR.count;
            break;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = [indexPath section];
    NSInteger row = [tableView numberOfRowsInSection:indexPath.section];
    
    
    static NSString *CellIdentifier1 = @"Article";
    static NSString *CellIdentifier2 = @"More";
    
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (cell1 == nil) {
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier1];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    if (cell2 == nil) {
        cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier2];
        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if(indexPath.row < row - 1){
        
        MWFeedItem *item;
        NSArray *placeholder;
        
        // Configure the cell.
        switch(section){
            case 0:
                placeholder = [itemsForDisplayP subarrayWithRange:NSMakeRange(0, row - 1)];
                item = [placeholder objectAtIndex:indexPath.row];
                break;
            case 1:
                placeholder = [itemsForDisplayC subarrayWithRange:NSMakeRange(0, row - 1 )];
                item = [placeholder objectAtIndex:indexPath.row];
                break;
            case 2:
                placeholder = [itemsForDisplayS subarrayWithRange:NSMakeRange(0, row - 1)];
                item = [placeholder objectAtIndex:indexPath.row];
                break;
            case 3:
                placeholder = [itemsForDisplayL subarrayWithRange:NSMakeRange(0, row - 1 )];
            item = [placeholder objectAtIndex:indexPath.row];
                break;
            case 4:
                placeholder = [itemsForDisplayR subarrayWithRange:NSMakeRange(0, row - 1)];
                item = [placeholder objectAtIndex:indexPath.row];
                break;
        }
        
        if (item) {
        
            // Process
            NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No       Title]";
            NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
        
            // Set
            cell1.textLabel.font = [UIFont boldSystemFontOfSize:15];
            cell1.textLabel.text = itemTitle;
            NSMutableString *subtitle = [NSMutableString string];
            if (item.date) [subtitle appendFormat:@"%@: ", [formatter stringFromDate:item.date]];
            [subtitle appendString:itemSummary];
            cell1.detailTextLabel.text = subtitle;
            return cell1;
        
        }
    }else{
        cell2.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell2.textLabel.text = @"More";
        return cell2;
    }
    return cell2;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Grab total numbers of rows
    NSInteger row = [tableView numberOfRowsInSection:indexPath.section];
    
    //Check if it is the last row
    if (indexPath.row == row - 1) {
        [self performSegueWithIdentifier:@"more" sender:self];
    }else{
        [self performSegueWithIdentifier:@"showDetail" sender:self];
    }
   
}

//Sends URL information to web view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSInteger section = indexPath.section;
    NSString *title;
    switch(section){
        case 0:
            title = @"People";
            break;
        case 1:
            title = @"Community";
            break;
        case 2:
            title = @"Sports";
            break;
        case 3:
            title = @"Learning";
            break;
        case 4:
            title = @"Research";
            break;
    }
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        //Grabbing article link
       
        MWFeedItem *item;
        switch(section){
            case 0:
                item = [itemsForDisplayP objectAtIndex:indexPath.row];
                break;
            case 1:
                item = [itemsForDisplayC objectAtIndex:indexPath.row];
                break;
            case 2:
                item = [itemsForDisplayS objectAtIndex:indexPath.row];
                break;
            case 3:
                item = [itemsForDisplayL objectAtIndex:indexPath.row];
                break;
            case 4:
                item = [itemsForDisplayR objectAtIndex:indexPath.row];
                break;
            
        }
        NSString *string = item.link;
        //Sending link to View Controller
        SFUNewsDetailView *destinationViewController = segue.destinationViewController;
        destinationViewController.url = string;
        destinationViewController.atitle = title;
        
    }else if([[segue identifier] isEqualToString:@"more"]){
        
        NSString *string = [MoreUrls objectAtIndex:section];
        //Sending link to View Controller
        SFUNewsDetailView *destinationViewController = segue.destinationViewController;
        destinationViewController.url = string;
        destinationViewController.atitle = title;
        
        
    }
    
}


@end