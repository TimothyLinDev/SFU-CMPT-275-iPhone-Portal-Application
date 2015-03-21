//
//  CourseViewController.m
//  SFUPA
//
//  Created by Rylan on 2015-03-20.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//

#import "CourseViewController.h"
#import "CourseManager.h"

@interface CourseViewController ()

@end

@implementation CourseViewController {
    CourseManager *courseManager;
    id outline;
    NSMutableArray *choices;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    courseManager = [[CourseManager alloc] init];
    outline = [courseManager fetchOutline];
    if (outline == nil) {
        return;
    }
    choices = [[NSMutableArray alloc] init];

    _courseTableView.delegate = self;
    _courseTableView.dataSource = self;

    [self parseOutline];
    [_courseTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)parseOutline {
    // Parse table data to be displayed
    // If `outline` is really just a list of valid values for a parameter
    [choices removeAllObjects];
    if ([outline isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in outline) {
            [choices addObject:[dict objectForKey:@"value"]];
        }
    }
    // If `outline` is actually a course outline or an error message
    else if ([outline isKindOfClass:[NSDictionary class]]) {
        ;//TEMP
    }
}

// UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [outline isKindOfClass:[NSDictionary class]] ? [outline count] : 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if ([outline isKindOfClass:[NSDictionary class]]) {
        return [[[outline allKeys] objectAtIndex:section] count];
    }
    return [choices count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([courseManager level] == 5) {
        return [[outline allKeys] objectAtIndex:section];
    }
    // else [courseManager level] is at least 0 and at most 4
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
    cell.textLabel.text = [[outline isKindOfClass:[NSDictionary class]] ?
                           [outline allKeys] :
                           choices
                           objectAtIndex:indexPath.row];
    return cell;
}

// UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([choices count] == 0) {
        return;
    }
    outline = [courseManager downToLevel:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    if (outline == nil) {
        return;
    }
    [self parseOutline];
    [_courseTableView reloadData];
}

@end
