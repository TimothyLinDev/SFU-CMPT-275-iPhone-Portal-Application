//
//  ParkingViewController.h
//  SFUPA
//
//  Created by Rylan on 2015-04-05.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
