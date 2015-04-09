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
    NSArray *reserved;
    NSArray *listAllBookName;
    NSArray *listAllAuthorName;
    NSArray *listAllCoverURL;
    NSString *bookName;
    NSString *authorName;
    NSString *bookCover;
    NSDictionary *bookDetails;
    
    //BookInformation *bi;
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
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.lib.sfu.ca/reserves/search?department=%@&number=%@&section=%@&instructor=%@&semester=%@&rows=&start=&group=", deptValue, numberValue, sectionValue, instructorValue, semesterValue];
    
    
    NSURL *request = [NSURL URLWithString: urlStr];
    NSData * data= [NSData dataWithContentsOfURL:request];
    
    //Storing the json file in this array
    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    reserved = [jsonArray valueForKey:@"reserves"];
    //NSLog(@"RESERVED!!!! %@",reserved);
    
    listAllBookName = [reserved valueForKey:@"title"];
    listAllAuthorName = [reserved valueForKey:@"author"];
    listAllCoverURL = [reserved valueForKey:@"cover_url"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listAllBookName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    if ([listAllBookName count] > 0) {
        cell.textLabel.text = [listAllBookName objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    bookName = (indexPath.row < [listAllBookName count]) ? [listAllBookName objectAtIndex: indexPath.row] : @"";
    authorName = (indexPath.row < [listAllAuthorName count]) ? [listAllAuthorName objectAtIndex: indexPath.row] : @"";
    bookCover = (indexPath.row < [listAllCoverURL count]) ? [listAllCoverURL objectAtIndex: indexPath.row] : @"";
    
    NSLog(@"Book Name: %@", bookName);
    NSLog(@"Author Name: %@", authorName);
    NSLog(@"Cover URL Name: %@", bookCover);
    
    [self performSegueWithIdentifier:@"BookInfo" sender:self];
       
    /*
     bookDetails= [NSDictionary dictionaryWithObjectsAndKeys: bookName, @"title", authorName, @"author", bookCover, @"cover_url", nil];
    
    NSMutableArray *bookInformation = [[NSMutableArray alloc] init];
    [bookInformation addObject: bookDetails];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"BookInfo"])
    {
        BookInformation *bi = (BookInformation *)segue.destinationViewController;
        bi.nameBook = bookName;
        bi.nameAuthor = authorName;
        bi.bookCoverUrl = bookCover;
    }
}
@end