//
//  CourseViewController.m
//  SFUPA
//
//  Created by Rylan on 2015-03-20.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Rylan Lim
//
//  Assignment 4:
//  Edited by: | What was done?
//  Rylan      | Created

#import "CourseViewController.h"
#import "CourseManager.h"
#import "WebViewScreen.h"

@interface CourseViewController ()

@end

@implementation CourseViewController {
    CourseManager *courseManager;
    id jsonArray;
    NSMutableArray *choices;
    NSMutableDictionary *choiceDict;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Fetch a JSON array from the Course Outline API
    courseManager = [[CourseManager alloc] init];
    jsonArray = [courseManager fetchJSONArray];
    if (jsonArray == nil) { // was unable to fetch JSON array
        [[[UIAlertView alloc] initWithTitle:@"No Internet Connection"
                                    message:@"⚠"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        return;
    }
    // Parse the array and store the relevant data
    choices = [[NSMutableArray alloc] init];
    choiceDict = [[NSMutableDictionary alloc] init];
    [self updateChoices];

    // Display the data in the table view
    _courseTableView.delegate = self;
    _courseTableView.dataSource = self;
    [_courseTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - miscellaneous

- (void)updateChoices {
    [choices removeAllObjects];
    [choiceDict removeAllObjects];
    for (NSDictionary *dict in jsonArray) {
        [choices addObject:[dict objectForKey:@"text"]];
        [choiceDict setObject:[dict objectForKey:@"value"]
                       forKey:[dict objectForKey:@"text"]];
    }
}

#pragma mark - IBAction

- (IBAction)pressedBtnBack:(id)sender {
    // Do nothing if we are at the top level (i.e. selecting the year)
    if ([courseManager level] == 0) {
        return;
    }
    
    // Go up one level
    jsonArray = [courseManager upOneLevel];
    if (jsonArray == nil) { // was unable to fetch JSON array
        [[[UIAlertView alloc] initWithTitle:@"No Internet Connection"
                                    message:@"⚠"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        return;
    }
    [self updateChoices];
    [_courseTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [_courseTableView reloadData];
}

#pragma mark - NSSeguePerforming

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier
                                  sender:(id)sender {
    // Go back to the Academic Services screen only when the user is at the top level
    return [courseManager level] == 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // If we are about to view a course outline in the Web view,
    // send the URL of the outline to be viewed
    if([segue.identifier isEqualToString:@"courseToWeb"]){
        WebViewScreen *wvs = segue.destinationViewController;
        wvs.segueData = [[NSString alloc]
                         initWithFormat:@"https://www.sfu.ca/outlines.html?%@",
                         [courseManager query]];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    // Go back to the Academic Services screen after the user acknowledges
    // that the connection to the SFU server failed
    [self performSegueWithIdentifier:@"courseToAcademic" sender:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [choices count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // Precondition: [courseManager level] is at least 0 and at most 4
    return [[NSString alloc] initWithFormat:@"Please select a %@:", [@[
        @"year",
        @"term",
        @"department",
        @"course number",
        @"section"
    ] objectAtIndex:[courseManager level]]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    id color = indexPath.row & 1 ? [UIColor whiteColor] : [UIColor colorWithRed:(float)0xff/0xff
                                                                          green:(float)0xd3/0xff
                                                                           blue:(float)0xcc/0xff
                                                                          alpha:1];
    cell.backgroundView = [[UIView alloc] init];
    cell.backgroundView.backgroundColor = color;
    if ([choices count] > 0) {
        cell.textLabel.text = [choices objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    jsonArray = [courseManager downToLevel:
                 [choiceDict objectForKey:
                  [tableView cellForRowAtIndexPath:indexPath].textLabel.text]];
    if (jsonArray == nil) { // was unable to fetch JSON array
        [[[UIAlertView alloc] initWithTitle:@"No Internet Connection"
                                    message:@"⚠"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        return;
    }
    if ([courseManager level] == 5) {
        [self performSegueWithIdentifier:@"courseToWeb" sender:self];
        return;
    }

    [self updateChoices];
    [_courseTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [_courseTableView reloadData];
}

@end
