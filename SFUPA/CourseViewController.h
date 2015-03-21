//
//  CourseViewController.h
//  SFUPA
//
//  Created by Rylan on 2015-03-20.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *courseTableView;

@end
