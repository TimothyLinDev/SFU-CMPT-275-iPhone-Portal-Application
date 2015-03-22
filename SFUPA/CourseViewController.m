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

- (void)viewDidLoad {
    [super viewDidLoad];

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
    choices = [[NSMutableArray alloc] init];
    choiceDict = [[NSMutableDictionary alloc] init];

    _courseTableView.delegate = self;
    _courseTableView.dataSource = self;

    [self updateChoices];
    [_courseTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier
                                  sender:(id)sender {
    // Go back to the Academic Services screen only when the user is at the top level
    return [courseManager level] == 0;
}

- (IBAction)pressedBtnBack:(id)sender {
    if ([courseManager level] == 0) {
        return;
    }
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"courseToWeb"]){
        WebViewScreen *wvs = segue.destinationViewController;
        wvs.segueData = [[NSString alloc]
                         initWithFormat:@"https://www.sfu.ca/outlines.html?%@",
                         [courseManager query]];
    }
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self performSegueWithIdentifier:@"courseToAcademic" sender:self];
}

- (void)updateChoices {
    [choices removeAllObjects];
    [choiceDict removeAllObjects];
    for (NSDictionary *dict in jsonArray) {
        [choices addObject:[dict objectForKey:@"text"]];
        [choiceDict setObject:[dict objectForKey:@"value"]
                      forKey:[dict objectForKey:@"text"]];
    }
}

// UITableViewDataSource

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
    if ([choices count] > 0) {
        cell.textLabel.text = [choices objectAtIndex:indexPath.row];
    }
    return cell;
}

// UITableViewDelegate

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
