//
//  ParkingViewController.m
//  SFUPA
//
//  Created by Rylan on 2015-04-05.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//

#import "ParkingViewController.h"
#import "WebViewScreen.h"

static NSArray *arr; // Array that contains the data to be drawn in the table view
static dispatch_once_t pred;
static NSString *const rootURLString = @"https://www.sfu.ca/parking";

// If the following character appears at the end of a cell label string,
// then a DisclosureIndicator will be drawn in the cell.
// The character itself will be removed from the string.
static const unichar SELECTABLE_UNICHAR = '>';

@interface ParkingViewController ()

@end

@implementation ParkingViewController {
    NSString *urlString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_once(&pred, ^{
        arr = @[
                @[
                    @"Outdoor Permit",
                    @"• $279.51/semester after tax",
                    @"• Permits you to park at:",
                    @"\t◦ B Lot>",
                    @"\t◦ C Lot>",
                    @"\t◦ Discovery P3>",
                    @"Indoor Permit",
                    @"• $381.15/semester after tax",
                    @"• Permits you to park at the above lots, as well as at:",
                    @"\t◦ West Mall>",
                    @"\t◦ Discovery P1/P2>"
                    ],
                @[
                    @"If you are a visitor or a student, you may park at the unreserved areas of:",
                    @"• B Lot>",
                    @"• C Lot>",
                    @"• Convocation Mall's Parkade>",
                    @"• West Mall's Visitor Parkade>",
                    @"• VN Lot>",
                    @"The rate is $3.25/hour, up to:",
                    @"• $13.00/day\n  from Mon to Fri",
                    @"• $6.50/day\n  on evenings and weekends",
                    @"• $5.00/day\n  at Discovery P1/P2 before 9:00 AM",
                    ],
                @[
                    @"Parking Website>",
                    @"Parking for Students>",
                    @"Parking for Visitors>",
                    @"Rates and Refunds>",
                    @"Parking Regulations>",
                    ]
                ];
    });

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [arr[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Student Parking";
        case 1:
            return @"Visitor Parking";
        default:
            return @"For more information";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    cell.textLabel.numberOfLines = 0;
    NSString *st = arr[indexPath.section][indexPath.row];
    if ([st characterAtIndex:st.length-1] == SELECTABLE_UNICHAR) {
        cell.textLabel.text = [st substringToIndex:st.length-1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.textLabel.text = st;
        // If `st` does not begin with a bullet and a space
        if ([cell.textLabel.text characterAtIndex:0] < 0x100 &&
            [cell.textLabel.text characterAtIndex:1] < 0x100) {
            cell.backgroundColor = [UIColor colorWithRed:(float)0xff/0xff
                                                   green:(float)0xd3/0xff
                                                    blue:(float)0xcc/0xff
                                                   alpha:1];
        }
    }
    return cell;
}

#pragma mark - NSSeguePerforming

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Send the URL of the web page to be viewed to the Web View controller
    if([segue.identifier isEqualToString:@"parkingToWeb"]){
        [segue.destinationViewController setSegueData:urlString];
    }
}

#pragma mark - UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *st = arr[indexPath.section][indexPath.row];
    if ([st characterAtIndex:st.length-1] != SELECTABLE_UNICHAR) {
        return nil;
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 2) { //TEMP
        return;
    }
    switch (indexPath.row) {
        case 0:
            urlString = [rootURLString stringByAppendingString:@".html"];
            break;
        case 1:
            urlString = [rootURLString stringByAppendingString:@"/students.html"];
            break;
        case 2:
            urlString = [rootURLString stringByAppendingString:@"/visitors.html"];
            break;
        case 3:
            urlString = [rootURLString stringByAppendingString:@"/rates-refunds.html"];
            break;
        case 4:
            urlString = [rootURLString stringByAppendingString:@"/parking-regulations.html"];
            break;
    }
    [self performSegueWithIdentifier:@"parkingToWeb" sender:self];
}

@end
