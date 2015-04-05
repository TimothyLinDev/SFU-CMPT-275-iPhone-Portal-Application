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
    choices = [[NSMutableArray alloc] init];
    [choices setArray:@[@"Course Outlines", @"My Courses"]];
    choiceDict = [[NSMutableDictionary alloc] init];
    courseManager = [[CourseManager alloc] init];

    // Display choices in the table view
    _courseTableView.delegate = self;
    _courseTableView.dataSource = self;
    [_courseTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - miscellaneous

NSString *currentTerm() {
    NSDateComponents *components = [[NSCalendar currentCalendar]
                                    components:NSCalendarUnitYear | NSCalendarUnitMonth
                                    fromDate:[NSDate date]];
    NSInteger trimester;
    if ([components month] < 5) {
        trimester = 1;
    } else if ([components month] < 9) {
        trimester = 4;
    } else {
        trimester = 7;
    }
    return [[NSString alloc] initWithFormat:@"%ld", ([components year] - 1900) * 10 + trimester];
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

#pragma mark - IBAction

- (IBAction)pressedBtnBack:(id)sender {
    switch ([courseManager level]) {
        case 0:
            // Do nothing if we are at the top level.
            // A segue will take us to the previous screen.
            return;
        case 1:
            // Allow the user to choose to view either course outlines or
            // a list of their courses
            [choices setArray:@[@"Course Outlines", @"My Courses"]];
            courseManager.outlinesWasSelected = NO;
            break;
        default:
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
    }
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
        WebViewScreen *controller = segue.destinationViewController;
        // Check whether user chose "My Courses"
        controller.segueData = [courseManager level] == 0 ?
                                // Load "My Courses"
                                [[NSString alloc]
                                 initWithFormat:@"https://sims-prd.sfu.ca/psc/csprd_1/EMPLOYEE/HRMS/c/SA_LEARNER_SERVICES.SS_ES_STUDY_LIST.GBL?STRM=%@",
                                 currentTerm()] :
                                // Load "Course Outlines"
                                [[NSString alloc]
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
    // Precondition: [courseManager level] is at least 0 and at most 5
    return [[NSString alloc] initWithFormat:@"Please select %@:", [@[
        @"an item to view",
        @"a year",
        @"a term",
        @"a department",
        @"a course number",
        @"a section"
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
    // If we are at the top level
    if (courseManager.level == 0) {
        // If "My Courses" was selected
        if (indexPath.row == 1) {
            [self performSegueWithIdentifier:@"courseToWeb" sender:self];
            return;
        }

        // "Course Outlines" was selected.
        courseManager.outlinesWasSelected = YES;
        // Fetch a JSON array from the Course Outline API
        jsonArray = [courseManager fetchJSONArray];
        if (jsonArray == nil) { // was unable to fetch JSON array
            [[[UIAlertView alloc] initWithTitle:@"No Internet Connection"
                                        message:@"⚠"
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            return;
        }
    } else {
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
        if ([courseManager level] == 6) {
            [self performSegueWithIdentifier:@"courseToWeb" sender:self];
            return;
        }
    }

    [self updateChoices];   // Parse the fetched JSON array and store the relevant data
    [_courseTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [_courseTableView reloadData];
}

@end
