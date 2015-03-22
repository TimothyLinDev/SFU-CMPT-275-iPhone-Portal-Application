//
//  CourseManager.h
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

#import <Foundation/Foundation.h>

@interface CourseManager : NSObject

- (id)fetchJSONArray;

- (id)fetchJSONArrayWithParameters:(NSArray *)params;

- (id)downToLevel:(NSString *)parameter;

// Remove the last parameter of the query to the Course Outline API
- (id)upOneLevel;

- (NSInteger)level;

- (NSString *)query;

@end
