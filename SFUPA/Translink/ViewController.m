//
//  ViewController.m
//  Translink
//
//  Created by Mavis on 15-3-16.
//  Copyright (c) 2015年 Mavis. All rights reserved.
//
//  Known Bugs:
//
//  Contributors: Mavis
//
// Assignment 4:
// Edited by: | What was done?
// Mavis | Created
// Mavis | Linking to storyboard
// Mavis | Make the schedule image
// Victor | Implementing wayfinding

#import "ViewController.h"
#import "buslist.h"
#import "SearchController.h"

@interface TranController (){
    NSString *store;
    __weak IBOutlet UITextField *number;
    //__weak IBOutlet UILabel *test;
}

@property (weak, nonatomic) IBOutlet UIButton *FirstStop;
@property (weak, nonatomic) IBOutlet UIButton *SecondStop;
@property (weak, nonatomic) IBOutlet UIButton *ThirdStop;
@property (weak, nonatomic) IBOutlet UIButton *FourthStop;
@property (weak, nonatomic) IBOutlet UIButton *FifthStop;
@property (weak, nonatomic) IBOutlet UIButton *NoFirst;
@property (weak, nonatomic) IBOutlet UIButton *NoSecond;
@property (weak, nonatomic) IBOutlet UIButton *NoThird;
@property (weak, nonatomic) IBOutlet UIButton *NoFourth;
@property (weak, nonatomic) IBOutlet UIView *HideFirstView;
@property (weak, nonatomic) IBOutlet UIView *HideSecondView;
@property (weak, nonatomic) IBOutlet UIView *HideThirdView;
@property (weak, nonatomic) IBOutlet UIButton *UpFirstStop;
@property (weak, nonatomic) IBOutlet UIButton *UpSecondStop;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollimage;
@property (weak, nonatomic) IBOutlet UIImageView *image135;
@property (weak, nonatomic) IBOutlet UIImageView *image143;
@property (weak, nonatomic) IBOutlet UIImageView *image144;
@property (weak, nonatomic) IBOutlet UIImageView *image145;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation TranController

//show the 135 schedule when select 135
-(IBAction)clickNoFirst:(id)sender{
    self.scrollimage.hidden = NO;
    [self.scrollimage setScrollEnabled:YES];
    [self.scrollimage setContentSize:CGSizeMake(320, 10000)];
    self.image135.hidden = NO;
    self.image143.hidden = YES;
    self.image144.hidden = YES;
    self.image145.hidden = YES;
    self.image135.image = [UIImage imageNamed:@"135.png"];
}

//show the 143 schedule when select 143
-(IBAction)clickNoSecond:(id)sender{
    self.scrollimage.hidden = NO;
    [self.scrollimage setScrollEnabled:YES];
    [self.scrollimage setContentSize:CGSizeMake(320, 1000)];
    self.image135.hidden = YES;
    self.image143.hidden = NO;
    self.image144.hidden = YES;
    self.image145.hidden = YES;
    self.image143.image = [UIImage imageNamed:@"143.png"];
}

//show the 144 schedule when select 144
-(IBAction)clickNoThird:(id)sender{
    self.scrollimage.hidden = NO;
    [self.scrollimage setScrollEnabled:YES];
    [self.scrollimage setContentSize:CGSizeMake(320, 5000)];
    self.image135.hidden = YES;
    self.image143.hidden = YES;
    self.image144.hidden = NO;
    self.image145.hidden = YES;
    self.image144.image = [UIImage imageNamed:@"144.png"];
}

//show the 145 schedule when select 145
-(IBAction)clickNoFourth:(id)sender{
    self.scrollimage.hidden = NO;
    [self.scrollimage setScrollEnabled:YES];
    [self.scrollimage setContentSize:CGSizeMake(320, 2000)];
    self.image135.hidden = YES;
    self.image143.hidden = YES;
    self.image144.hidden = YES;
    self.image145.hidden = NO;
    self.image145.image = [UIImage imageNamed:@"145.png"];
    
}

//switch the view by segmented control
-(IBAction)switchcontroller{
    //show the view under "Down-Hill" selection
    if (segmentcontrol.selectedSegmentIndex == 0){
        self.HideFirstView.hidden = NO;
        self.HideSecondView.hidden = NO;
        self.HideThirdView.hidden = NO;
        self.FirstStop.hidden = NO;
        self.SecondStop.hidden = NO;
        self.ThirdStop.hidden = NO;
        self.FourthStop.hidden = NO;
        self.FifthStop.hidden = NO;
        self.UpFirstStop.hidden = YES;
        self.UpSecondStop.hidden = YES;
        self.NoFirst.hidden = YES;
        self.NoSecond.hidden = YES;
        self.NoThird.hidden = YES;
        self.NoFourth.hidden = YES;
        self.scrollimage.hidden = YES;
    }
    //show the view under "Up-Hill" selection
    else if(segmentcontrol.selectedSegmentIndex == 1){
        self.HideFirstView.hidden = YES;
        self.HideSecondView.hidden = YES;
        self.FirstStop.hidden = YES;
        self.SecondStop.hidden = YES;
        self.FourthStop.hidden = YES;
        self.UpFirstStop.hidden = NO;
        self.UpSecondStop.hidden = NO;
        self.NoFirst.hidden = YES;
        self.NoSecond.hidden = YES;
        self.NoThird.hidden = YES;
        self.NoFourth.hidden = YES;
        self.scrollimage.hidden = YES;
    }
    //show the view under "No-Internet" selection
    else if (segmentcontrol.selectedSegmentIndex == 2){
        self.HideFirstView.hidden = YES;
        self.HideSecondView.hidden = YES;
        self.HideThirdView.hidden = NO;
        self.FirstStop.hidden = YES;
        self.SecondStop.hidden = YES;
        self.ThirdStop.hidden = YES;
        self.FourthStop.hidden = YES;
        self.FifthStop.hidden = YES;
        self.UpFirstStop.hidden = YES;
        self.UpSecondStop.hidden = YES;
        self.NoFirst.hidden = NO;
        self.NoSecond.hidden = NO;
        self.NoThird.hidden = NO;
        self.NoFourth.hidden = NO;
        self.scrollimage.hidden = YES;
    }
}

//send the segue to another view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"SFU Transit Exchange"]){
        BusController *bus =[segue destinationViewController];
        bus.segueData = @"SFU Transit Exchange";
    }
    else if ([segue.identifier isEqualToString:@"SFU Transportation Center(Up)"]){
        BusController *bus =[segue destinationViewController];
        bus.segueData = @"SFU Transportation Center(Up)";
    }
    else if ([segue.identifier isEqualToString:@"University High St"]){
        BusController *bus =[segue destinationViewController];
        bus.segueData = @"University High St";
    }
    else if ([segue.identifier isEqualToString:@"SFU Transit Exchange"]){
        BusController *bus =[segue destinationViewController];
        bus.segueData = @"SFU Transit Exchange(Up)";
    }
    else if ([segue.identifier isEqualToString:@"Science Rd"]){
        BusController *bus =[segue destinationViewController];
        bus.segueData = @"Science Rd";
    }
    else if ([segue.identifier isEqualToString:@"SFU Transportation Center"]){
        BusController *bus =[segue destinationViewController];
        bus.segueData = @"SFU Transportation Center";
    }
    else if ([segue.identifier isEqualToString:@"Campus Rd"]){
        BusController *bus =[segue destinationViewController];
        bus.segueData = @"Campus Rd";
    }
    else if ([segue.identifier isEqualToString:@"SearchMain"]){
        SearchController *search =[segue destinationViewController];
        search.segueData = self.searchTextField.text;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchTextField.placeholder = @"Bus#/Stop#";
    
    //prepare the view
    self.UpFirstStop.hidden = YES;
    self.UpSecondStop.hidden = YES;
    self.NoFirst.hidden = YES;
    self.NoSecond.hidden = YES;
    self.NoThird.hidden = YES;
    self.NoFourth.hidden = YES;
    self.scrollimage.hidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
