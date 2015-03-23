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

// Return an array fetched from the Course Outline API with the parameters contained in the CourseManager instance.
// If the fetch failed, return `nil`.
- (id)fetchJSONArray;

// Return an array fetched from the Course Outline API
// with parameters specified by the contents of `params`.
// If the fetch failed, return `nil`.
- (id)fetchJSONArrayWithParameters:(NSArray *)params;

// Return an array fetched from the Course Outline API
// with the parameters contained in the CourseManager instance
// after adding the parameter `parameter` to them.
// If the fetch failed, return `nil`.
- (id)downToLevel:(NSString *)parameter;

// Return an array fetched from the Course Outline API
// with the parameters contained in the CourseManager instance
// after the last parameter has been removed.
// If the fetch failed, return `nil`.
- (id)upOneLevel;

// Return the number of parameters to be sent to the Course Outline API
// if `fetchJSONArray` is called.
- (NSInteger)level;

// Return a query string made of parameters to be sent to the Course Outline API
- (NSString *)query;

@end
