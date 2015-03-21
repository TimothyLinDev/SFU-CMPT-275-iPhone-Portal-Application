//
//  CourseManager.h
//  SFUPA
//
//  Created by Rylan on 2015-03-20.
//  Copyright (c) 2015 7thHeaven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseManager : NSObject

// An outline is a serialization of any JSON data returned by the Course Outline API
- (id) fetchOutline;

- (id) fetchOutlineWithParameters:(NSArray *)params;

- (id) downToLevel:(NSString *)parameter;

// Remove the last parameter of the query to the Course Outline API
- (void) upOneLevel;

- (NSInteger) level;

@end
