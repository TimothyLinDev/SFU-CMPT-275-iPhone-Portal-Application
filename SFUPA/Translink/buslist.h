//
//  buslist.h
//  Translink
//
//  Created by Mavis on 15-3-16.
//  Copyright (c) 2015年 Mavis. All rights reserved.
//

#ifndef Translink_buslist_h
#define Translink_buslist_h
#import <UIKit/UIKit.h>

@interface BusController : UIViewController

@property (retain, nonatomic) NSString *segueData;

-(NSString*) makeRestAPICall : (NSString*) reqURLStr;
-(void)get145schedule:(NSString *)stop;
-(void)get135schedule:(NSString *)stop;
-(void)get144schedule:(NSString *)stop;
-(void)get143schedule:(NSString *)stop;

@end

#endif
