//
//  BookDetail.m
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

#import <Foundation/Foundation.h>
#import "BookDetail.h"
#import "BookInformation.h"

#define getDataURL(x) @"http://api.lib.sfu.ca/reserves/search?department="x"&number=&section=&instructor=&semester=&rows=&start=&group="

@interface BookDetail ()
{
    NSString *deptValue;
    NSString *numberValue;
    NSString *sectionValue;
    NSString *instructorValue;
    NSString *semesterValue;
    NSDictionary *reserved;
    NSArray *bookName;
}

@end


@implementation BookDetail
{
    BookInformation *bookInfo;
}
@synthesize jsonArray, booksArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self retrieveData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) retrieveData
{
    deptValue = self.dept;
    numberValue = self.number;
    sectionValue = self.section;
    instructorValue = self.instructor;
    semesterValue = self.semester;
    
    NSLog(@"This is DEPT: %@",self.dept);
    
    NSLog(@"This is NUMBER: %@",self.number);
    NSLog(@"This is SECTION: %@",self.section);
    NSLog(@"This is INSTRUCTOR: %@",self.instructor);
    NSLog(@"This is SEMESTER: %@",self.semester);
    
    //NSURL * url = [NSURL URLWithString:getDataURL("CMPT")];
    NSString *urlStr = [NSString stringWithFormat:@"http://api.lib.sfu.ca/reserves/search?department=%@&number=%@&section=%@&instructor=%@&semester=%@&rows=&start=&group=", deptValue, numberValue, sectionValue, instructorValue, semesterValue];
    
    
    NSURL *request = [NSURL URLWithString: urlStr];
    //NSLog(@"%@",url);
    NSData * data= [NSData dataWithContentsOfURL:request];
    
    //Storing the json file in this array
    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"%@",jsonArray);
    
    reserved = [jsonArray valueForKey:@"reserves"];
    //NSLog(@"RESERVED!!!! %@",reserved);
    
    bookName = [reserved valueForKey:@"title"];
    NSLog(@"BOOK NAME: %@",bookName);
    
    //tableData = [NSArray arrayWithObjects:bookName, nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [bookName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([bookName count] > 0) {
        cell.textLabel.text = [bookName objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // If we are at the top level
        if (indexPath.row >= 0) {
            [self performSegueWithIdentifier:@"BookInfo" sender:self];
            return;
    }
}
@end